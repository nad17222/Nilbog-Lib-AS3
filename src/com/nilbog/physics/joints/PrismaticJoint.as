package com.nilbog.physics.joints 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PrismaticJointDef;

	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.joints.PhysicsJoint;
	import com.nilbog.util.Range;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class PrismaticJoint extends PhysicsJoint 
	{
		private var actor1:PhysicsActor;
		private var anchor:Point;
		private var actor2:PhysicsActor;
		private var axis:Point;
		private var translationRange:Range;
		private var motorSpeed:Number;
		private var maxMotorForce:Number;

		public function PrismaticJoint(actor1:PhysicsActor, actor2:PhysicsActor, anchor:Point, axis:Point, translationRange:Range=null, motorSpeed:Number=0, maxMotorForce:Number=0)
		{
			this.actor1 = actor1;
			this.actor2 = actor2;
			this.anchor = anchor;
			this.axis = axis;
			this.translationRange = translationRange;
			this.motorSpeed = motorSpeed;
			this.maxMotorForce = maxMotorForce;
			
			jointDef = new b2PrismaticJointDef();
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2PrismaticJointDef = jointDef as b2PrismaticJointDef;
			j.Initialize(actor1.body, actor2.body, new b2Vec2(anchor.x, anchor.y), new b2Vec2(axis.x, axis.y));
			if (maxMotorForce != 0)
			{
				j.enableMotor = true;
			}
			if (null != translationRange)
			{
				j.enableLimit = true;
				j.lowerTranslation = translationRange.minimum;
				j.upperTranslation = translationRange.maximum;
			}
			j.maxMotorForce = maxMotorForce;
			j.motorSpeed = motorSpeed;
			
			actor1 = null;
			actor2 = null;
			anchor = null;
			axis = null;
			translationRange = null;
		}
		
		override public function destroy() :void
		{
			actor1 = null;
			actor2 = null;
			anchor = null;
			axis = null;
			translationRange = null;
			
			super.destroy();
		}
	}
}
