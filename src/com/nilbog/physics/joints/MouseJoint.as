package com.nilbog.physics.joints 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2MouseJoint;
	import Box2D.Dynamics.Joints.b2MouseJointDef;

	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.joints.PhysicsJoint;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class MouseJoint extends PhysicsJoint 
	{
		private var actor1:PhysicsActor;
		private var target:Point;
		private var maxForce:Number;
		
		public function MouseJoint(actor1:PhysicsActor, target:Point, maxForce:Number=300)
		{
			this.actor1 = actor1;
			this.target = target;
			this.maxForce = maxForce;
			
			jointDef = new b2MouseJointDef();
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2MouseJointDef = new b2MouseJointDef();
			
			j.body1 = null;
			j.body2 = actor1.body;
			j.target.Set( target.x, target.y );
			j.collideConnected = true;
			j.maxForce = maxForce * j.body2.GetMass();
			
			jointDef = j;
			
			actor1 = null;
			target = null;
		}
		
		public function setTarget( x:Number, y:Number ) :void
		{
			var j:b2MouseJoint = joint as b2MouseJoint;
			j.SetTarget(new b2Vec2(x, y));
		}
		
		override public function destroy() :void
		{
			actor1 = null;
			target = null;
			
			super.destroy();
		}
	}
}
