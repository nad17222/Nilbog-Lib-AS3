package com.nilbog.physics.joints 
{
	import Box2D.Dynamics.Joints.b2GearJointDef;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2PrismaticJoint;
	import Box2D.Dynamics.Joints.b2RevoluteJoint;

	import com.nilbog.dbc.precondition;
	import com.nilbog.physics.joints.PhysicsJoint;

	/**
	 * @author jmhnilbog
	 */
	public class GearJoint extends PhysicsJoint 
	{
		private var joint1:b2Joint;
		private var joint2:b2Joint;
		private var ratio:Number;
		
		public function GearJoint(joint1:b2Joint, joint2:b2Joint, ratio:Number=1)
		{
			precondition( joint1 is b2PrismaticJoint || joint1 is b2RevoluteJoint, 
				"Joint1 is a prismatic or revolute joint." );
			precondition( joint2 is b2PrismaticJoint || joint2 is b2RevoluteJoint, 
				"Joint2 is a prismatic or revolute joint." );
			precondition( joint1.GetBody1().IsStatic(),
				"Joint1 must be attached to a static body as body1.");
			precondition( joint2.GetBody1().IsStatic(),
				"Joint2 must be attached to a static body as body1.");
			
			this.joint1 = joint1;
			this.joint2 = joint2;
			this.ratio = ratio;
			
			jointDef = new b2GearJointDef();
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2GearJointDef = jointDef as b2GearJointDef;
			j.joint1 = joint1;
			j.joint2 = joint2;
			j.ratio = ratio;
			
			jointDef = j;
			
			joint1 = null;
			joint2 = null;
		}
		
		override public function destroy() :void
		{
			joint1 = null;
			joint2 = null;
			
			super.destroy();
		}
	}
}
