package com.nilbog.physics.joints 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2RevoluteJointDef;

	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.joints.PhysicsJoint;
	import com.nilbog.util.Range;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class RevoluteJoint extends PhysicsJoint 
	{
		public var lowerAngle:Number = 0.0;
		public var upperAngle:Number = 0.0;
		public var maxMotorTorque:Number = 0.0;
		public var motorSpeed:Number = 0.0;
		public var enableLimit:Boolean = false;
		public var enableMotor:Boolean = false;
		
		private var actor1:PhysicsActor;
		private var actor2:PhysicsActor;
		private var anchor:Point;
		private var angles:Range;
		
		public function RevoluteJoint( actor1:PhysicsActor, actor2:PhysicsActor, anchor:Point, angles:Range=null, motorSpeed:Number=0, maxMotorTorque:Number=0 )
		{
			this.actor1 = actor1;
			this.actor2 = actor2;
			this.anchor = anchor;
			this.angles = angles;
			this.motorSpeed = motorSpeed;
			this.maxMotorTorque = maxMotorTorque;
			
			if (maxMotorTorque != 0)
			{
				enableMotor = true;
			}
			if (angles != null)
			{
				enableLimit = true;
			}
			
			jointDef = new b2RevoluteJointDef();	
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2RevoluteJointDef = jointDef as b2RevoluteJointDef;
			j.Initialize(actor1.body, actor2.body, new b2Vec2( anchor.x, anchor.y ));
			
			if (null != angles)
			{
				j.lowerAngle = angles.minimum;
				j.upperAngle = angles.maximum;
			}
			j.maxMotorTorque = maxMotorTorque;
			j.motorSpeed = motorSpeed;
			j.enableLimit = enableLimit;
			j.enableMotor = enableMotor;
			
			actor1 = null;
			actor2 = null;
			anchor = null;
			angles = null;
		}
		
		override public function destroy() :void
		{
			actor1 = null;
			actor2 = null;
			anchor = null;
			angles = null;
		}
	}
}
