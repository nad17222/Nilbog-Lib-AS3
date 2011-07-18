﻿package com.nilbog.physics.models {	import Box2D.Collision.Shapes.b2CircleDef;	import Box2D.Collision.Shapes.b2PolygonDef;	import Box2D.Collision.Shapes.b2Shape;	import Box2D.Collision.Shapes.b2ShapeDef;	import Box2D.Collision.b2AABB;	import Box2D.Collision.b2ContactPoint;	import Box2D.Common.Math.b2Vec2;	import Box2D.Dynamics.Contacts.b2ContactResult;	import Box2D.Dynamics.Joints.b2Joint;	import Box2D.Dynamics.b2Body;	import Box2D.Dynamics.b2BodyDef;	import Box2D.Dynamics.b2BoundaryListener;	import Box2D.Dynamics.b2ContactListener;	import Box2D.Dynamics.b2DebugDraw;	import Box2D.Dynamics.b2DestructionListener;	import Box2D.Dynamics.b2World;	import com.nilbog.collections.Set;	import com.nilbog.dbc.precondition;	import com.nilbog.log.LogLevel;	import com.nilbog.mvc.AbstractModel;	import com.nilbog.mvc.IModel;	import com.nilbog.physics.actors.PhysicsActor;	import com.nilbog.physics.actors.PhysicsMachine;	import com.nilbog.physics.events.PhysicsActorEvent;	import com.nilbog.physics.events.PhysicsBoundaryEvent;	import com.nilbog.physics.events.PhysicsContactEvent;	import com.nilbog.physics.events.PhysicsDestructionEvent;	import com.nilbog.physics.events.PhysicsEvent;	import com.nilbog.physics.joints.PhysicsJoint;	import com.nilbog.physics.shapes.Physics2DShape;	import com.nilbog.util.geometry.ICircle;	import com.nilbog.util.geometry.IPolygon;	import flash.display.Sprite;	import flash.geom.Point;	import flash.geom.Rectangle;	[Event(name="physics update", type="com.nilbog.physics.event.PhysicsEvent")]	[Event(name="physics timestep changed", type="com.nilbog.physics.event.PhysicsEvent")]	[Event(name="physics actor added", type="com.nilbog.physics.event.PhysicsActorEvent")]	[Event(name="physics actor removed", type="com.nilbog.physics.event.PhysicsActorEvent")]	[Event(name="out of bounds", type="com.nilbog.physics.events.PhysicsBoundaryEvent")]	[Event(name="joint to be destroyed", type="com.nilbog.physics.events.PhysicsDestructionEvent")]	[Event(name="shape to be destroyed", type="com.nilbog.physics.events.PhysicsDestructionEvent")]	[Event(name="contact added", type="com.nilbog.physics.events.PhysicsContactEvent")]	[Event(name="contact persisted", type="com.nilbog.physics.events.PhysicsContactEvent")]	[Event(name="contact removed", type="com.nilbog.physics.events.PhysicsContactEvent")]	[Event(name="contact resolved", type="com.nilbog.physics.events.PhysicsContactEvent")]	/**	 * Model representing a physics simulation. Uses Box2d, but attempts to hide	 * that as much as possible.	 * 	 * @author jmhnilbog	 */	public class PhysicsModel extends AbstractModel implements IModel	{			// bitmask constants		public static const DISPATCH_BOUNDARY_EVENTS:Number = 1;		public static const DISPATCH_CONTACT_EVENTS:Number = 2;		public static const DISPATCH_DESTRUCTION_EVENTS:Number = 4;		// default gravity is Earth-normal		public static const EARTH_GRAVITY:Point = new Point( 0, 9.80665 );		public static const ZERO_GRAVITY:Point = new Point( 0, 0 );		public var worldSize:Rectangle;				private var _world:b2World;		private var iterations:uint;		private var _timestep:Number;		private var _eventFlags:Number;		private var oobListener:b2BoundaryListener;		private var dListener:b2DestructionListener;		private var cListener:b2ContactListener;		private var bodiesToDestroy:Array = [];		/**		 * Constructor.		 * 		 * @param	worldSize	Rectangle		 * @param	timestep	Number		 * @param	gravity		Point (defaults to Earth normal)		 * @param	allowSleep	Boolean (defaults to true)		 * @param	iterations	uint (defaults to 10)		 * @param	eventFlags	Number from bitmask constants in this class. 		 * 						(defaults to 0)		 */		public function PhysicsModel( worldSize:Rectangle, timestep:Number, gravity:Point = null, allowSleep:Boolean = true, iterations:uint = 10, eventFlags:Number = 0 )		{			super( );					log.minimumLevel = LogLevel.WARN;			log.trace( "%s(%s)", "PhysicsModel", arguments.join( ", " ) );						this._timestep = timestep;			this.iterations = iterations;			this.worldSize = worldSize;						// construct the world			var bounds:b2AABB = new b2AABB( );			bounds.lowerBound.Set( worldSize.x, worldSize.y );			bounds.upperBound.Set( worldSize.width, worldSize.height );						null == gravity ? gravity = EARTH_GRAVITY : 1;									var b2Gravity:b2Vec2 = new b2Vec2( gravity.x, gravity.y );						_world = new b2World( bounds, b2Gravity, allowSleep );						log.info("World count: %s", _world.GetBodyCount());						// allow for event listening			oobListener = new ViolationListener( this );			dListener = new DestructionListener( this );			cListener = new ContactListener( this );					this.eventFlags = eventFlags;		}		/**		 * Changes the events the model will respond to.		 * 		 * @param	v	Number, from the bitmask constants above.		 */		public function set eventFlags( v:Number ):void		{			var bound:b2BoundaryListener = null;			var destruct:b2DestructionListener = null;			var contact:b2ContactListener = null;						v & DISPATCH_BOUNDARY_EVENTS ? bound = oobListener : bound = null;			v & DISPATCH_CONTACT_EVENTS ? contact = cListener : contact = null;			v & DISPATCH_DESTRUCTION_EVENTS ? destruct = dListener : destruct = null;						_world.SetBoundaryListener( bound );			_world.SetContactListener( contact );			_world.SetDestructionListener( destruct );						_eventFlags = v;		}				public function get world() :b2World		{			return _world;		}		/**		 * Returns a bitmask of the events the model will respond to.		 * 		 * @return Number		 */		public function get eventFlags():Number		{			return _eventFlags;		}		/**		 * Retrieves the current timestep.		 * 		 * @return Number		 */		public function get timestep():Number		{			return _timestep;		}		/**		 * Retrieves the current number of actors in the simulation.		 * 		 * @return uint		 */		public function get actorCount():uint		{			return _world.GetBodyCount( );		}		/**		 * Retrieves the actor under the a given point (in MKS units).		 * 		 * @param 	p	Point		 * @param	includeStatic Include static actors (defaults to false)		 * 		 * @return	PhysicsActor at the point, or null		 */		public function getActorAtPoint( p:Point, includeStatic:Boolean = false ):PhysicsActor		{			var point:b2Vec2 = new b2Vec2( p.x, p.y );						// Make a small box.			var aabb:b2AABB = new b2AABB( );			aabb.lowerBound.Set( p.x - 0.001, p.y - 0.001 );			aabb.upperBound.Set( p.x + 0.001, p.y + 0.001 );						// Query the world for overlapping shapes.			const MAX_COUNT:int = 10;			var shapes:Array = [];			var count:int = _world.Query( aabb, shapes, MAX_COUNT );			var body:b2Body = null;			for (var i:uint = 0; i < count ; ++i)			{				var shape:b2Shape = shapes[i];				var tBody:b2Body = shape.GetBody( );				if (tBody.IsStatic( ) == false || includeStatic)				{					var inside:Boolean = shape.TestPoint( tBody.GetXForm( ), point );					if (inside)					{						body = tBody;						break;					}				}			}			if (null == body)			{				return null;			}			else			{				return body.GetUserData( ) as PhysicsActor;			}		}		public function addJoint( joint:PhysicsJoint ):PhysicsJoint		{			log.trace( "%s(%s)", "addJoint", arguments.join( ", " ) );						joint.initialize( );			// use the world as a default first joint body			if (joint.jointDef.body1 == null)			{				joint.jointDef.body1 = _world.GetGroundBody( );			}			joint.joint = _world.CreateJoint( joint.jointDef );			return joint;		}		/**		 * Removes a joint from the simulation.		 * 		 * @param	joint	b2Joint		 */		public function removeJoint( joint:PhysicsJoint ):void		{			_world.DestroyJoint( joint.joint );		}		public function addMachine( machine:PhysicsMachine ):void		{			log.trace( "%s(%s)", "addMachine", arguments.join( ", " ) );						log.warn( "adding machine: " + machine );						for (var part:String in machine.parts)			{				var actor:PhysicsActor = machine.parts[part];				addActor( actor );			}						for each (var j:PhysicsJoint in machine.joints) 			{				addJoint( j );			}		}		/**		 * Adds an actor to the simulation. Note that PhysicsActors will not 		 * have body fields populated until they have been passed to this method.		 * 		 * @param	actor	PhysicsActor		 */		public function addActor( actor:PhysicsActor, group:Number = NaN ):void		{	 			log.trace( "%s(%s)", "addActor", arguments.join( ", " ) );			log.info("Current body count: %s", _world.GetBodyCount());						var bodyDef:b2BodyDef = new b2BodyDef( );			bodyDef.position.Set( actor.position.x, actor.position.y );			bodyDef.angle = actor.rotation;						var body:b2Body = _world.CreateBody( bodyDef );						actor.shapeList.forEach( function (shape:Physics2DShape, index:int, vector:Vector.<Physics2DShape>) :void			{				var shapeDef:b2ShapeDef;				if (shape is ICircle)				{					var c:ICircle = shape as ICircle;					var circleDef:b2CircleDef = new b2CircleDef( );					circleDef.radius = c.radius;					circleDef.localPosition.x = c.center.x;					circleDef.localPosition.y = c.center.y;					shapeDef = circleDef;				}				else if (shape is IPolygon)				{					var p:IPolygon = shape as IPolygon;					var polyDef:b2PolygonDef = new b2PolygonDef( );					polyDef.vertexCount = p.vertices.length;					for (var i:uint = 0; i < p.vertices.length ; i++)					{						var tp:Point = p.vertices[i];						polyDef.vertices[i].Set( tp.x, tp.y );						}					shapeDef = polyDef;				}				else				{					throw new Error( "Bad shape found." );				}								shapeDef.friction = actor.material.friction;				shapeDef.density = actor.material.density;				shapeDef.restitution = actor.material.restitution;				shapeDef.filter.groupIndex = shape.collisionGroup;				shapeDef.filter.maskBits = shape.collisionMask;				shapeDef.filter.categoryBits = shape.collisionCategory;								body.CreateShape( shapeDef );			} );						body.SetMassFromShapes( );			body.SetUserData( actor );			actor.body = body;						var e:PhysicsActorEvent = new PhysicsActorEvent( PhysicsActorEvent.ADDED );			e.actor = actor;			dispatchEvent( e );		}		/**		 * Removes an actor from the simulation.		 * 		 * @param	actor	PhysicsActor		 */		public function removeActor( actor:PhysicsActor ):void		{			log.trace( "%s(%s)", "removeActor", arguments.join( ", " ) );			log.info("Current body count: %s", _world.GetBodyCount());						precondition( null != actor.body, "PhysicsActor is in the simulation." );						// world destroys the body, views handle the actor			var body:b2Body = actor.body;			actor.body = null;						body.SetUserData(null);						bodiesToDestroy.push(body);						var e:PhysicsActorEvent = new PhysicsActorEvent( PhysicsActorEvent.REMOVED );			e.actor = actor;			dispatchEvent( e );		}		public function removeMachine( machine:PhysicsMachine ):void		{			log.trace( "%s(%s)", "removeMachine", arguments.join( ", " ) );						for (var part:String in machine.parts)			{				var actor:PhysicsActor = machine.parts[part];				removeActor( actor );			}		}		/**		 * Tells the model to draw debugging data into a sprite on each timestep.		 * 		 * @param	sprite	Sprite		 * @param	scale	Number		 * @param	flags	Number composed of a bitmask derived from constants		 * 					in the PhsyicsDebugView class. (defaults to all)		 * @param	fillAlpha	Number (defaults to .5)		 * @param	lineThickness	Number (defaults to 1)		 */		public function drawDebuggingData( sprite:Sprite, scale:Number, flags:Number = 0xFFFFFFFF, fillAlpha:Number = .5, lineThickness:Number = 1):void		{			log.trace( "%s(%s)", "drawDebuggingData", arguments.join( ", " ) );						var dbgDraw:b2DebugDraw = new b2DebugDraw( );			dbgDraw.m_sprite = sprite;			dbgDraw.m_drawScale = scale;			dbgDraw.m_fillAlpha = fillAlpha;			dbgDraw.m_lineThickness = lineThickness;			dbgDraw.SetFlags( flags );			_world.SetDebugDraw( dbgDraw );		}		/**		 * Updates the model by the current timestep.		 */		public function update():void		{			log.trace( "%s(%s)", "update", arguments.join( ", " ) );			log.info("Current body count: %s", _world.GetBodyCount());									_world.Step( _timestep, iterations );						while(0 != bodiesToDestroy.length)			{				_world.DestroyBody(bodiesToDestroy.pop());			}			var allActors:Array = [];			var staticActors:Array = [];			var sleepingActors:Array = [];			var awakeActors:Array = [];						var groundBody:b2Body = _world.GetGroundBody();			for (var b:b2Body = _world.GetBodyList( ); b ; b = b.GetNext( ))			{				var actor:PhysicsActor = b.GetUserData() as PhysicsActor;				if (null != actor)				{					if (b.IsStatic( ))					{						staticActors.push( actor );					}					else if (b.IsSleeping( ))					{						sleepingActors.push( actor );					}					else					{						awakeActors.push( actor );					}					allActors.push( actor );				}				else if (groundBody != b)				{					log.warn("%b.GetUserData() could not be cast to PhysicsActor " +					"and was not the ground body.", b);				}			}						// all bodies have updated			var e:PhysicsEvent = new PhysicsEvent( PhysicsEvent.UPDATE );			e.awakeActors = awakeActors;			dispatchEvent( e );		}		//		/**		//		 * Adds a mouse joint to the simulation.		//		 * 		//		 * @param	actor1	PhysicsActor. Usually null. If null, the world is		//		 * 					used at the first body in the joint.		//		 * @param	actor2	PhysicsActor		//		 * @param	target	Point, the anchor of the mouse joint.		//		 * 		//		 * @return	b2MouseJoint		//		 */		//		private function addMouseJoint( joint:MouseJoint ):MouseJoint		//		{		//			log.trace( "%s(%s)", "addMouseJoint", arguments.join( ", " ) );		//					//			// use the world as body1 if one is not provided		//			if (null == joint.jointDef.body1)		//			{		//				joint.jointDef.body1 = world.GetGroundBody();		//			}		//					//			joint.joint = world.CreateJoint( joint.jointDef );		//			joint.jointDef.body2.WakeUp( );		//					//			return joint;		//		}		//				//		private function addGearJoint( joint:GearJoint ) :GearJoint		//		{		//			log.trace("%s(%s)", "addGearJoint", arguments.join(", "));		//					//			joint.joint = world.CreateJoint(joint.jointDef);		//			return joint;		//		}		//				//		private function addPrismaticJoint( joint:PrismaticJoint ) :PrismaticJoint		//		{		//			log.trace("%s(%s)", "addPrismaticJoint", arguments.join(", "));		//					//			joint.joint = world.CreateJoint(joint.jointDef);		//			return joint;		//		}		//				//		private function addPulleyJoint( joint:PulleyJoint ) :PulleyJoint		//		{		//			log.trace("%s(%s)", "addPulleyJoint", arguments.join(", "));		//					//			joint.joint = world.CreateJoint( joint.jointDef );		//			return joint;		//		}		//				//		private function addLineJoint( joint:LineJoint ) :LineJoint		//		{		//			log.trace("%s(%s)", "addLineJoint", arguments.join(", "));		//					//			joint.joint = world.CreateJoint( joint.jointDef );		//			return joint;		//		}				//		private function addPrismaticJoint( actor1:PhysicsActor, actor2:PhysicsActor, anchor:Point, axis:Point ) :b2PrismaticJoint		//		{		//			log.trace("%s(%s)", "addPrismaticJoint", arguments.join(", "));		//					//			var j:b2PrismaticJointDef = new b2PrismaticJointDef();		//			j.Initialize( actor1.body, actor2.body, new b2Vec2(anchor.x, anchor.y), new b2Vec2(axis.x, axis.y));		//					//			var prismaticJoint:b2PrismaticJoint = world.CreateJoint( j ) as b2PrismaticJoint;		//					//			return prismaticJoint;		//		}				//		private function addPulleyJoint( actor1:PhysicsActor, actor2:PhysicsActor, groundAnchor1:Point, groundAnchor2:Point, anchor1:Point, anchor2:Point, ratio:Number ) :b2PulleyJoint		//		{		//			log.trace("%s(%s)", "addPulleyJoint", arguments.join(", "));		//					//			var j:b2PulleyJointDef = new b2PulleyJointDef();		//			j.Initialize( actor1.body, actor2.body, new b2Vec2(groundAnchor1.x, groundAnchor1.y), new b2Vec2(groundAnchor2.x, groundAnchor2.y), new b2Vec2(anchor1.x, anchor1.y), new b2Vec2(anchor2.x, anchor2.y), ratio);		//					//			var pulleyJoint:b2PulleyJoint = world.CreateJoint( j ) as b2PulleyJoint;		//					//			return pulleyJoint;		//		}				//		private function addLineJoint( actor1:PhysicsActor, actor2:PhysicsActor, anchor:Point, axis:Point) :b2LineJoint		//		{		//			log.trace("%s(%s)", "addLineJoint", arguments.join(", "));		//					//			var j:b2LineJointDef = new b2LineJointDef();		//			j.Initialize(actor1.body, actor2.body, new b2Vec2(anchor.x, anchor.y), new b2Vec2(axis.x, axis.y));		//					//			var lineJoint:b2LineJoint = world.CreateJoint(j) as b2LineJoint;		//					//			return lineJoint;		//		}		//		/**		//		 * Adds a revolute joint to the simulation.		//		 * 		//		 * @param	actor1	PhysicsActor		//		 * @param	actor2	PhysicsActor		//		 * @param	position	Point, the point the joint bends at		//		 * @param	rangeLow	Number the low end of allowed bending, in radians		//		 * @param	rangeHigh	Number, the high end of allowed bending, in radians		//		 * 		//		 * @return	b2Joint		//		 */		//		private function addRevoluteJoint( joint:RevoluteJoint ):RevoluteJoint		//		{		//			log.trace( "%s(%s)", "addRevoluteJoint", arguments.join( ", " ) );		//					//			joint.initialize();		//			joint.joint = world.CreateJoint( joint.jointDef );		//					//			return joint;		//		}		//				//		private function addDistanceJoint( joint:DistanceJoint ) :DistanceJoint		//		{		//			log.trace("%s(%s)", "addDistanceJoint", arguments.join(", "));		//					//			joint.initialize();		//			joint.joint = world.CreateJoint( joint.jointDef );		//			return joint;		//		}		/**		 * Called by listeners to send PhysicsBoundaryEvents out of the model.		 * 		 * @param	body	b2Body		 */		internal function onOutOfBounds( body:b2Body ):void		{			log.trace( "%s(%s)", "onOutOfBounds", arguments.join( ", " ) );						var e:PhysicsBoundaryEvent = new PhysicsBoundaryEvent( PhysicsBoundaryEvent.OUT_OF_BOUNDS );			e.actor = body.GetUserData( ) as PhysicsActor;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsDestructionEvents out of the model.		 * 		 * @param	joint	b2Joint		 */		internal function onJointToBeDestroyed( joint:b2Joint ):void		{			log.trace( "%s(%s)", "onJointToBeDestroyed", arguments.join( ", " ) );						var e:PhysicsDestructionEvent = new PhysicsDestructionEvent( PhysicsDestructionEvent.JOINT_TO_BE_DESTROYED );			e.joint = joint;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsDestructionEvents out of the model.		 * 		 * @param	shape	b2Shape		 */		internal function onShapeToBeDestroyed( shape:b2Shape ):void		{			log.trace( "%s(%s)", "onShapeToBeDestroyed", arguments.join( ", " ) );						var e:PhysicsDestructionEvent = new PhysicsDestructionEvent( PhysicsDestructionEvent.SHAPE_TO_BE_DESTROYED );			e.shape = shape;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsContactEvents out of the model.		 * 		 * @param	point	b2ContactPoint		 */		internal function onContactPointAdded( point:b2ContactPoint ):void		{			log.trace( "%s(%s)", "onContactPointAdded", arguments.join( ", " ) );						var e:PhysicsContactEvent = new PhysicsContactEvent( PhysicsContactEvent.CONTACT_ADDED );			e.contactPoint = point;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsContactEvents out of the model.		 * 		 * @param	point	b2ContactPoint		 */		internal function onContactPointPersisted( point:b2ContactPoint ):void		{			log.trace( "%s(%s)", "onContactPointPersisted", arguments.join( ", " ) );						var e:PhysicsContactEvent = new PhysicsContactEvent( PhysicsContactEvent.CONTACT_PERSISTED );			e.contactPoint = point;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsContactEvents out of the model.		 * 		 * @param	point	b2ContactPoint		 */		internal function onContactPointRemoved( point:b2ContactPoint ):void		{			log.trace( "%s(%s)", "onContactPointRemoved", arguments.join( ", " ) );						var e:PhysicsContactEvent = new PhysicsContactEvent( PhysicsContactEvent.CONTACT_REMOVED );			e.contactPoint = point;			dispatchEvent( e );		}		/**		 * Called by listeners to send PhysicsContactEvents out of the model.		 * 		 * @param	point	b2ContactResult		 */		internal function onContactPointResolved( point:b2ContactResult ):void		{			log.trace( "%s(%s)", "onContactPointResolved", arguments.join( ", " ) );						var e:PhysicsContactEvent = new PhysicsContactEvent( PhysicsContactEvent.CONTACT_RESOLVED );			e.contactResolution = point;			dispatchEvent( e );		}	}}