package com.nilbog.physics.joints 
{
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.Joints.b2JointDef;

	import com.nilbog.util.IDestroyable;

	/**
	 * @author jmhnilbog
	 */
	public class PhysicsJoint implements IDestroyable 
	{
		public static const ALLOW_CONNECTED_COLLISIONS:Boolean = true;
		public static const DISALLOW_CONNECTED_COLLISIONS:Boolean = false;
		
		public var jointDef:b2JointDef;
		public var joint:b2Joint;
		
		private var collide:Boolean = true;
		
		public function PhysicsJoint( allowCollisions:Boolean=true )
		{
			collide = allowCollisions;
		}
		
		public function initialize() :void
		{
			jointDef.collideConnected = collide;
		}

		public function destroy():void
		{
			jointDef = null;
			joint = null;
		}
		
		public function isDestroyed():Boolean
		{
			return jointDef == null;
		}
	}
}
