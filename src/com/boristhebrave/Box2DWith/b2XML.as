/*
 * Copyright (c) 2009 Adam Newgas http://www.boristhebrave.com
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 1. The origin of this software must not be misrepresented; you must not
 * claim that you wrote the original software. If you use this software
 * in a product, an acknowledgment in the product documentation would be
 * appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 * misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

package com.boristhebrave.Box2DWith 
{
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;
	import Box2D.Dynamics.Joints.*;

	/**
	 * Contains functions for loading Box2D shapes, bodies and joints from a simple XML format.
	 * 
	 * <p>The XML format is formally defined in using <a href="http://relaxng.org/">Relax NG</a> in the file
	 * <a href="box2d.rng">box2d.rng</a> found in the same directory as this class.
	 * An <a href="http://www.w3.org/XML/Schema">XML Schema</a> file is also <a href="box2d.xsd">available</a>, autotranslated by 
	 * <a href="http://www.thaiopensource.com/relaxng/trang.html">Trang</a>.</p>
	 * 
	 * <p>Simply stated, the XML format has a root &lt;world/&gt; element. Inside that, there are various body and joint elements, 
	 * and inside each body element is various shape elements, thus matching Box2Ds design layout quite closely.
	 * See the methods loadShapeDef, loadBodyDef, and loadJointDef for the details on how each element is formed.</p>
	 * 
	 * <p>In general, attribute names match exactly the corresponding Box2D property, and has the same defaults as Box2D.
	 * Reasonable values are generated for certain properties when not specified, in the same manner as the various
	 * Initialize functions of Box2D. Joint anchors can be specified in either world or local co-ordinates, either single
	 * or jointly, though this implementation will not prevent you from overspecifying attributes.</p>
	 * 
	 * <p>It is expected that in most cases, you will not want to use the XML to fully define worlds using loadWorld, as
	 * this library doesn't provide any mechanism for handling other data, such as the appearance of a body. Instead, you
	 * can use the various loading functions to synthesize your own XML format containing parts of the Box2D XML specification.
	 * Or you can simply use this class as a more consise and portable way of writing out defintions, and deal with defining
	 * the world in your own way.</p>
	 * 
	 * @see #loadShapeDef()
	 * @see #loadBodyDef()
	 * @see #loadJointDef()
	 */
	public class b2XML 
	{
		/**
		 * Loads a Number from a given attribute.
		 * @param	attribute	An attribute list of zero or one attributes to parse into a Number.
		 * @param	defacto		The default number to use in case there is no attribute or it is not a valid Number.
		 * @return The parsed Number, or defacto.
		 */
		public static function loadFloat(attribute:XMLList, defacto:Number):Number
		{
			try
			{
				if (attribute.length( ))
					return parseFloat( attribute );
			}
			catch (error:Error)
			{
			}
			return defacto;
		}

		/**
		 * Loads a int from a given attribute.
		 * @param	attribute	An attribute list of zero or one attributes to parse into a int.
		 * @param	defacto		The default number to use in case there is no attribute or it is not a valid int.
		 * @return The parsed int, or defacto.
		 */
		public static function loadInt(attribute:XMLList, defacto:int):int
		{
			try
			{
				if (attribute.length( ))
					return parseInt( attribute );
			}
			catch (error:Error)
			{
			}
			return defacto;
		}

		/**
		 * Loads a Boolean from a given attribute. Only the value "true" is recognized as true. Everything else is false.
		 * @param	attribute	An attribute list of zero or one attributes to parse into a Boolean.
		 * @param	defacto		The default number to use in case there is no attribute.
		 * @return The parsed Boolean, or defacto.
		 */
		public static function loadBool(attribute:XMLList, defacto:Boolean = false):Boolean
		{
			try
			{
				if (attribute.length( ))
					return attribute.toString( ) == "true";
			}
			catch (error:Error)
			{
			}
			return defacto;
		}

		/**
		 * Loads a b2Vec2 from a given attribute. Vectors are stored as space delimited Numbers, e.g. "1.5 2.3".
		 * @param	attribute	An attribute list of zero or one attributes to parse into a b2Vec2.
		 * @param	defacto		The default number to use in case there is no attribute or it is not a valid b2Vec2.
		 * @return The parsed b2Vec2, or defacto.
		 */
		public static function loadVec2(attribute:XMLList, defacto:b2Vec2 = null):b2Vec2
		{
			try
			{
				var a:Array = String( attribute ).split( /\s+/ );
				return b2Vec2.Make.apply( null, a );
			}
			catch (error:Error)
			{
			}
			return defacto;
		}

		/**
		 * Reads common shape def attributes from xml.
		 */
		private static function assignShapeDefFromXML(xml:XML, to:b2ShapeDef, base:b2ShapeDef = null):void
		{
			if (base) 
			{
				to.density = base.density;
				to.filter = base.filter.Copy( );
				to.friction = base.friction;
				to.isSensor = base.isSensor;
				to.restitution = base.restitution;
				to.userData = base.userData;
			}
			if (xml.@density.length( )) 
			{
				var density:String = xml.@density.toString( ).toLowerCase( );
				switch(density) 
				{
					case "":
					case "default":
						break;
					default:
						to.density = parseFloat( xml.@density );
				}
			}
			to.restitution = loadFloat( xml.@restitution, to.restitution );
			to.friction = loadFloat( xml.@friction, to.friction );
			to.isSensor = loadBool( xml.@isSensor, to.isSensor );
			if (xml.@userData.length( ))
				to.userData = xml.@userData;
			to.filter.categoryBits = loadInt( xml.@categoryBits, to.filter.categoryBits );
			to.filter.maskBits = loadInt( xml.@maskBits, to.filter.maskBits );
			to.filter.groupIndex = loadInt( xml.@groupIndex, to.filter.groupIndex );
		}

		/**
		 * Converts an XML element into a b2ShapeDef.
		 * 
		 * <p>The following elements/usages are recognized:</p>
		 * <pre>
		 * &lt;circle radius="0." x="0." y="0."/&gt;
		 * 	    b2CircleDef 
		 * &lt;circle radius="0." localPosition="0. 0."/&gt;
		 * 	    b2CircleDef    
		 * &lt;polygon&gt;
		 * 	&lt;vertex x="0." y="0."/&gt;
		 *  &lt;vertex x="0." y="0."/&gt;
		 *  &lt;vertex x="0." y="0."/&gt;
		 * &lt;/polygon&gt;
		 * 	    b2PolygonDef
		 * &lt;box x="0." y="0." width="0." height="0." angle="0."/&gt;
		 * 	    b2PolygonDef formed into an OBB.
		 * &lt;box left="" right="" top="" bottom=""/&gt;
		 * 	    b2PolygonDef formed into an AABB.
		 * 	    height and width can substitute for one of top/bottom and one of left/right.</pre>
		 * 
		 * <p>Additionally, all elements support the following attributes.</p>
		 * <pre>
		 * density        float
		 * friction       float
		 * isSensor       Boolean
		 * userData       String
		 * categoryBits   int
		 * maskBits       int
		 * groupIndex     int</pre>
		 * 
		 * @param	shape An XML element in the above format
		 * @param	base A shape definition to use as the default when an XML attribute is missing.
		 * @return	The corresponding b2ShapeDef
		 */
		public static function loadShapeDef(shape:XML, base:b2ShapeDef = null):b2ShapeDef
		{
			switch(shape.localName( )) 
			{
				case "circle":
					var circleDef:b2CircleDef = new b2CircleDef( );
					assignShapeDefFromXML( shape, circleDef, base );
					circleDef.radius = loadFloat( shape.@radius, 0 );
					circleDef.localPosition.x = loadFloat( shape.@x, 0 );
					circleDef.localPosition.y = loadFloat( shape.@y, 0 );
					circleDef.localPosition = loadVec2( shape.@localPosition, circleDef.localPosition );
					return circleDef;
				case "polygon":
					var polygonDef:b2PolygonDef = new b2PolygonDef( );
					assignShapeDefFromXML( shape, polygonDef, base );
					var vertices:XMLList = shape.vertex;
					if (vertices.length( ) == 0)
						vertices = shape.vertex;
					polygonDef.vertexCount = vertices.length( );
					for (var i:int = 0; i < vertices.length( ) ; i++) 
					{
						polygonDef.vertices[i].x = parseFloat( vertices[i].@x );
						polygonDef.vertices[i].y = parseFloat( vertices[i].@y );
					}
					return polygonDef;
				case "box":
					var boxDef:b2PolygonDef = new b2PolygonDef( );
					assignShapeDefFromXML( shape, boxDef, base );
					//Standard format
					var width:Number = parseFloat( shape.@width );
					var height:Number = parseFloat( shape.@height );
					var x:Number = loadFloat( shape.@x, 0 );
					var y:Number = loadFloat( shape.@y, 0 );
					var angle:Number = loadFloat( shape.@angle, 0 );
					//Alt format
					if (!shape.@angle.length( ))
					{
						if (shape.@left.length( ) && shape.@right.length( ))
						{
							x = (parseFloat( shape.@right ) + parseFloat( shape.@left )) / 2;
							width = parseFloat( shape.@right ) - parseFloat( shape.@left );
						}
						if (shape.@left.length( ) && shape.@width.length( ))
						{
							x = parseFloat( shape.@left ) + width / 2;
						}
						if (shape.@right.length( ) && shape.@width.length( ))
						{
							x = parseFloat( shape.@right ) - width / 2;
						}
						if (shape.@top.length( ) && shape.@bottom.length( ))
						{
							y = (parseFloat( shape.@bottom ) + parseFloat( shape.@top )) / 2;
							height = parseFloat( shape.@bottom ) - parseFloat( shape.@top );
						}
						if (shape.@top.length( ) && shape.@height.length( ))
						{
							y = parseFloat( shape.@top ) + height / 2;
						}
						if (shape.@bottom.length( ) && shape.@height.length( ))
						{
							y = parseFloat( shape.@bottom ) - height / 2;
						}
					}
					boxDef.SetAsOrientedBox( width / 2, height / 2, new b2Vec2( x, y ), angle );
					return boxDef;
			}
			return null;
		}

		/**
		 * Converts a &lt;body/&gt; element into a b2BodyDef.
		 * 
		 * <p>The following attributes are recognized, corresponding directly
		 * to the b2BodyDef properties:</p>
		 * <pre>
		 * allowSleep       Boolean
		 * angle            Number
		 * angularDamping   Number
		 * fixedRotation    Boolean
		 * isBullet         Boolean
		 * isSleeping       Boolean
		 * linearDamping    Number
		 * center           b2Vec2
		 * I                Number
		 * mass             Number
		 * x                Number
		 * y                Number
		 * position         b2Vec2
		 * userData         &#x2A; 	</pre>
		 * @param	body An XML element in the above format.
		 * @param	base A body definition to use as the default when an XML attribute is missing.
		 * @return The specified b2BodyDef.
		 */
		public static function loadBodyDef(body:XML, base:b2BodyDef = null):b2BodyDef
		{
			var bodyDef:b2BodyDef = new b2BodyDef( );
			if (base)
			{
				bodyDef.allowSleep = base.allowSleep;
				bodyDef.angle = base.angle;
				bodyDef.angularDamping = base.angularDamping;
				bodyDef.fixedRotation = base.fixedRotation;
				bodyDef.isBullet = base.isBullet;
				bodyDef.isSleeping = base.isSleeping;
				bodyDef.linearDamping = base.linearDamping;
				bodyDef.massData.center = base.massData.center.Copy( );
				bodyDef.massData.I = base.massData.I;
				bodyDef.massData.mass = base.massData.mass;
				bodyDef.position = base.position.Copy( );
				bodyDef.userData = base.userData;
			}
			bodyDef.allowSleep = loadBool( body.@allowSleep, bodyDef.allowSleep );
			bodyDef.angle = loadFloat( body.@angle, bodyDef.angle );
			bodyDef.angularDamping = loadFloat( body.@angularDamping, bodyDef.angularDamping );
			bodyDef.fixedRotation = loadBool( body.@fixedRotation, bodyDef.fixedRotation );
			bodyDef.isBullet = loadBool( body.@isBullet, bodyDef.isBullet );
			bodyDef.isSleeping = loadBool( body.@isSleeping, bodyDef.isSleeping );
			bodyDef.linearDamping = loadFloat( body.@linearDamping, bodyDef.linearDamping );
			bodyDef.massData.center = loadVec2( body.@center, bodyDef.massData.center );
			bodyDef.massData.I = loadFloat( body.@I, bodyDef.massData.I );
			bodyDef.massData.mass = loadFloat( body.@mass, bodyDef.massData.mass );
			bodyDef.position.x = loadFloat( body.@x, bodyDef.position.x );
			bodyDef.position.y = loadFloat( body.@y, bodyDef.position.y );
			bodyDef.position = loadVec2( body.@position, bodyDef.position );
			if (body.@userData.length( ))
				bodyDef.userData = String( body.@userData );
			return bodyDef;
		}

		/**
		 * Creates a body from a &lt;body/&gt; element with nested shape elementss, using the definitions from loadBodyDef and loadShapeDef.
		 * @param	xml	The &lt;body/&gt; element to parse.
		 * @param	world	The world to create the body from.
		 * @param	bodyDef	The base body definition to use for defaults.
		 * @param	shapeDef The base shape definition to use for defaults.
		 * @return A newly created body in world.
		 * @see #loadBodyDef()
		 * @see #loadShapeDef()
		 */
		public static function loadBody(xml:XML, world:b2World, bodyDef:b2BodyDef = null, shapeDef:b2ShapeDef = null):b2Body
		{
			var bd:b2BodyDef = loadBodyDef( xml, bodyDef );
			if (!bd)
				return null;
			var body:b2Body = world.CreateBody( bd );
			for each(var shapeXML:XML in xml.*)
			{
				var sd:b2ShapeDef = loadShapeDef( shapeXML, shapeDef );
				if(sd)
					body.CreateShape( sd );
			}
			if (!xml.@mass.length( ))
				body.SetMassFromShapes( );
			return body;
		}

		/**
		 * Reads common joint def attributes from xml.
		 */
		private static function assignJointDefFromXML(xml:XML, to:b2JointDef, body1:b2Body, body2:b2Body, base:b2JointDef = null):void 
		{
			if (base)
			{
				to.userData = base.userData;
				to.body1 = base.body1;
				to.body2 = base.body2;
				to.collideConnected = base.collideConnected;
				if (base is b2GearJointDef && to is b2GearJointDef)
				{
					(to as b2GearJointDef).joint1 = (base as b2GearJointDef).joint1;
					(to as b2GearJointDef).joint2 = (base as b2GearJointDef).joint2;
				}
			}
			to.body1 = body1;
			to.body2 = body2;
			var localAnchor1:b2Vec2 = loadVec2( xml.attribute( "local-anchor1" ) );
			var localAnchor2:b2Vec2 = loadVec2( xml.attribute( "local-anchor2" ) );
			var worldAnchor1:b2Vec2 = loadVec2( xml.attribute( "world-anchor1" ) );
			var worldAnchor2:b2Vec2 = loadVec2( xml.attribute( "world-anchor2" ) );
			var worldAnchor:b2Vec2 = loadVec2( xml.attribute( "world-anchor" ) );
			if (worldAnchor)
				worldAnchor1 = worldAnchor2 = worldAnchor;
			if (worldAnchor1)
				localAnchor1 = to.body1.GetLocalPoint( worldAnchor1 );
			if (worldAnchor2)
				localAnchor2 = to.body2.GetLocalPoint( worldAnchor2 );
			if (!localAnchor1)
				localAnchor1 = new b2Vec2( );
			if (!localAnchor2)
				localAnchor2 = new b2Vec2( );
			{
			if (to is b2DistanceJointDef)
			{
				(to as b2DistanceJointDef).localAnchor1 = localAnchor1;
				(to as b2DistanceJointDef).localAnchor2 = localAnchor2;
			}
			if (to is b2PrismaticJointDef)
			{
				(to as b2PrismaticJointDef).localAnchor1 = localAnchor1;
				(to as b2PrismaticJointDef).localAnchor2 = localAnchor2;
			}
			if (to is b2RevoluteJointDef)
			{
				(to as b2RevoluteJointDef).localAnchor1 = localAnchor1;
				(to as b2RevoluteJointDef).localAnchor2 = localAnchor2;
			}
			if (to is b2PulleyJointDef)
			{
				(to as b2PulleyJointDef).localAnchor1 = localAnchor1;
				(to as b2PulleyJointDef).localAnchor2 = localAnchor2;
			}
			}
			if (xml.@collideConnected.length( ))
				to.collideConnected = xml.@collideConnected == "true";
		}

		/**
		 * Converts an XML element into a b2JointDef.
		 * 
		 * <p>The following elements and attributes are recognized:</p>
		 * <pre>
		 * &lt;gear/&gt;    b2GearJointDef
		 *         ratio           Number
		 *         joint1          String    (resolved)
		 *         joint2          String    (resolved)
		 * 
		 * &lt;prismatic/&gt; b2PrismaticJointDef
		 *         motorSpeed      Number
		 *         maxMotorForce   Number
		 *         enableMotor     Boolean   (automatically set)
		 *         lower           Number
		 *         upper           Number
		 *         enableLimits    Boolean   (automatically set)
		 *         referenceAngle  Number    (automatically set)
		 *         world-axis      b2Vec2
		 *         local-axis1     b2Vec2
		 * 
		 * &lt;revolute/&gt;    b2RevoluteJointDef
		 *         motorSpeed      Number
		 *         maxMotorTorque  Number
		 *         enableMotor     Boolean   (automatically set)
		 *         lower           Number
		 *         upper           Number
		 *         enableLimits    Boolean   (automatically set)
		 *         referenceAngle  Number    (automatically set)
		 * 
		 * &lt;distance/&gt;    b2DistanceJointDef
		 *         dampingRatio    Number
		 *         frequencyHz     Number
		 *         length          Number    (automatically set)
		 * 
		 * &lt;pulley/&gt; b2PulleyJointDef
		 *         ratio           Number
		 *         maxLength1      Number
		 *         maxLength2      Number
		 *         world-ground    b2Vec2
		 *         world-ground1   b2Vec2
		 *         world-ground2   b2Vec2
		 *         length1         Number    (automatically set)
		 *         length2         Number    (automatically set)
		 * 
		 * &lt;mouse/&gt;    b2MouseJointDef
		 *         dampingRatio    Number
		 *         frequencyHz     Number
		 *         maxForce        Number
		 *         target          b2Vec2 </pre>
		 * 
		 * <p>Additionally, all elements support the following attributes:</p>
		 * <pre>
		 * body1             String          (resolved)
		 * body2             String          (resolved)
		 * world-anchor      b2Vec2
		 * world-anchor1     b2Vec2
		 * world-anchor2     b2Vec2
		 * local-anchor1     b2Vec2
		 * local-anchor2     b2Vec2
		 * collideConnected  Boolean </pre>
		 * 
		 * <p>Note that if the joint does not have a well defined body from body1/body2 or via providing base,
		 * then world co-ordinates cannot be used, except for the ground anchors of a pulley joint.</p>
		 * 
		 * @param	joint An XML element in the above format
		 * @param	resolver A function mapping strings to b2Bodys (and b2Joint).
		 * This is used so that the body1 and body2 (and joint1 and joint2 from &lt;gear/&gt;) can get resolved
		 * to the correct references. You can avoid using this if these properties are not defined, and providing them via base.
		 * @param	base A joint definition to use as the default when an XML attribute is missing.
		 * @return	The corresponding b2ShapeDef
		 */
		public static function loadJointDef(joint:XML, resolver:Function, base:b2JointDef = null):b2JointDef
		{
			//Determine the bodies involved.
			var body1:b2Body;
			var body2:b2Body;
			if (base && base.body1)
				body1 = base.body1;
			if (base && base.body2)
				body2 = base.body2;
			if (joint.@body1.length( ))
				body1 = resolver( String( joint.@body1 ) );
			if (joint.@body2.length( ))
				body2 = resolver( String( joint.@body2 ) );
			switch(joint.localName( )) 
			{
				case "gear":
					var gearDef:b2GearJointDef = new b2GearJointDef( );
					assignJointDefFromXML( joint, gearDef, body1, body2, base );
					gearDef.collideConnected = true;
					gearDef.ratio = loadFloat( joint.@ratio, 1 );
					gearDef.joint1 = resolver( String( joint.@joint1 ) );
					gearDef.joint2 = resolver( String( joint.@joint2 ) );
					return gearDef;
				case "prismatic":
					var prismaticDef:b2PrismaticJointDef = new b2PrismaticJointDef( );
					assignJointDefFromXML( joint, prismaticDef, body1, body2, base );
					// Parse from joint
					// Motor stuff
					prismaticDef.motorSpeed = loadFloat( joint.@motorSpeed, prismaticDef.motorSpeed );
					prismaticDef.maxMotorForce = loadFloat( joint.@maxMotorForce, Number.POSITIVE_INFINITY );
					prismaticDef.enableMotor = loadBool( joint.@enableMotor, joint.@motorSpeed.length( ) || joint.@maxMotorForce.length( ) );
					// Limit stuff
					prismaticDef.lowerTranslation = loadFloat( joint.@lower, Number.NEGATIVE_INFINITY );
					prismaticDef.upperTranslation = loadFloat( joint.@upper, Number.POSITIVE_INFINITY );
					prismaticDef.enableLimit = loadBool( joint.@enableLimit, joint.@lower.length( ) || joint.@upper.length( ) );
					//Joint stuff
					prismaticDef.referenceAngle = loadFloat( joint.@referenceAngle, body2.GetAngle( ) - body1.GetAngle( ) );
						
					var worldAxis:b2Vec2 = loadVec2( joint.attribute( "world-axis" ) );
					var localAxis:b2Vec2 = loadVec2( joint.attribute( "local-axis1" ) );
					if (worldAxis)
						localAxis = body1.GetLocalVector( worldAxis );
					localAxis.Normalize( );
					prismaticDef.localAxis1 = localAxis;
					
					return prismaticDef;
				case "revolute":
					var revoluteDef:b2RevoluteJointDef = new b2RevoluteJointDef( );
					assignJointDefFromXML( joint, revoluteDef, body1, body2, base );
					// Motor stuff
					revoluteDef.motorSpeed = loadFloat( joint.@motorSpeed, revoluteDef.motorSpeed );
					revoluteDef.maxMotorTorque = loadFloat( joint.@maxMotorTorque, Number.POSITIVE_INFINITY );
					revoluteDef.enableMotor = loadBool( joint.@enableMotor, joint.@motorSpeed.lenght || joint.@maxMotorTorque.length( ) );
					// Limit stuff
					revoluteDef.lowerAngle = loadFloat( joint.@lower, Number.NEGATIVE_INFINITY );
					revoluteDef.upperAngle = loadFloat( joint.@upper, Number.POSITIVE_INFINITY );
					revoluteDef.enableLimit = loadBool( joint.@enableLimit, joint.@lower.length( ) || joint.@upper.length( ) );
					revoluteDef.referenceAngle = loadFloat( joint.@referenceAngle, body2.GetAngle( ) - body1.GetAngle( ) );
					return revoluteDef;
				case "distance":
					var distanceDef:b2DistanceJointDef = new b2DistanceJointDef( );
					assignJointDefFromXML( joint, distanceDef, body1, body2, base );
					distanceDef.dampingRatio = loadFloat( joint.@dampingRatio, distanceDef.dampingRatio );
					distanceDef.frequencyHz = loadFloat( joint.@frequencyHz, distanceDef.frequencyHz );
					if (joint.@length.length( ))
					{
						distanceDef.length = loadFloat( joint.@length.length( ), 0 );
					}
					else
					{
						distanceDef.length = b2Math.SubtractVV( body1.GetWorldPoint( distanceDef.localAnchor1 ), body2.GetWorldPoint( distanceDef.localAnchor2 ) ).Length( );
					}
					return distanceDef;
				case "pulley":
					var pulleyDef:b2PulleyJointDef = new b2PulleyJointDef( );
					assignJointDefFromXML( joint, pulleyDef, body1, body2, base );
					
					pulleyDef.ratio = loadFloat( joint.@ratio, 1 );
					pulleyDef.maxLength1 = loadFloat( joint.@maxLength1, pulleyDef.maxLength1 );
					pulleyDef.maxLength2 = loadFloat( joint.@maxLength2, pulleyDef.maxLength2 );
					pulleyDef.groundAnchor1 = loadVec2( joint.attribute( "world-ground1" ), pulleyDef.groundAnchor1 );
					pulleyDef.groundAnchor2 = loadVec2( joint.attribute( "world-ground2" ), pulleyDef.groundAnchor2 );
					var ground:b2Vec2 = loadVec2( joint.attribute( "world-ground" ) );
					if (ground)
					{
						pulleyDef.groundAnchor1 = ground.Copy( );
						pulleyDef.groundAnchor2 = ground.Copy( );
					}
					if (joint.@length1.length( ))
					{
						pulleyDef.length1 = loadFloat( joint.@length1, pulleyDef.length1 );
					}
					else
					{
						pulleyDef.length1 = b2Math.SubtractVV( body1.GetWorldPoint( pulleyDef.localAnchor1 ), pulleyDef.groundAnchor1 ).Length( );
					}
					if (joint.@length2.length( ))
					{
						pulleyDef.length2 = loadFloat( joint.@length2, pulleyDef.length2 );
					}
					else
					{
						pulleyDef.length2 = b2Math.SubtractVV( body2.GetWorldPoint( pulleyDef.localAnchor2 ), pulleyDef.groundAnchor2 ).Length( );
					}
					return pulleyDef;
				case "mouse":
					var mouseDef:b2MouseJointDef = new b2MouseJointDef( );
					assignJointDefFromXML( joint, mouseDef, body1, body2, base );
					mouseDef.dampingRatio = loadFloat( joint.@dampingRatio, mouseDef.dampingRatio );
					mouseDef.frequencyHz = loadFloat( joint.@frequencyHz, mouseDef.frequencyHz );
					mouseDef.maxForce = loadFloat( joint.@maxForce, mouseDef.maxForce );
					mouseDef.target = loadVec2( joint.@target, mouseDef.target );
					return mouseDef;
			}
			return null;
		}

		/**
		 * Loads a world given a XML defintion. 
		 * 
		 * <p>xml is expected to a &lt;world&gt; element with child &lt;body&gt; and joint elements as specified in
		 * loadBodyDef and loadShapeDef. &lt;body/&gt; elements should have children shape elements as 
		 * specified in loadShapeDef.</p>
		 * 
		 * <p>Both body and joint elements can have an id attribute that gives a string identifier
		 * to be later resolved for use with the body1 and body2 attributes of joints,
		 * and joint1 and joint2 attribute of gear joints.</p>
		 * 
		 * @param	xml		A <world/> element in the above format.
		 * @param	world	A world to load into. Unlike other load functions, this function does not create an object from scratch.
		 * @param	bodyDef	A body definition to use for defaults.
		 * @param	shapeDef A shape definition to use for defaults.
		 * @param	jointDef A joint definition to use for defaults.
		 * @return A function you can use to resolve the loaded elements, as defined in loadJointDef.
		 * @see #loadJointDef
		 */
		public static function loadWorld(xml:XML, world:b2World, bodyDef:b2BodyDef = null, shapeDef:b2ShapeDef = null, jointDef:b2JointDef = null):Function
		{
			var idMapping:Object = { };
			var resolver:Function = function(id:String):*
			{
				return idMapping[id];
			};
			for each(var element:XML in xml.*)
			{
				if (element.localName( ) == "body")
				{
					var body:b2Body = loadBody( element, world, bodyDef, shapeDef );
					if (element.@id.length( ))
						idMapping[String( element.@id )] = body;
				}
				else
				{
					var jd:b2JointDef = loadJointDef( element, resolver, jointDef );
					var joint:b2Joint = world.CreateJoint( jd );
					if (element.@id.length( ))
						idMapping[String( element.@id )] = joint;
				}
			}
			return resolver;
		}
	}
}