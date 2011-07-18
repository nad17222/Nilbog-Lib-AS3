package com.nilbog.physics.events 
{
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.Joints.b2Joint;

	import flash.events.Event;

	/**
	 * A PhysicsEvent associated with joint and shape destruction.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsDestructionEvent extends PhysicsEvent 
	{
		// a joint is about to be destroyed
		public static const JOINT_TO_BE_DESTROYED:String = "joint to be destroyed";
		
		// a shape is about to be destroyed
		public static const SHAPE_TO_BE_DESTROYED:String = "shape to be destroyed";
		
		// the joint associated with a joint destruction event
		public var joint:b2Joint;
		
		// the shape associated with a shape destruction event
		public var shape:b2Shape;
		
		/**
		 * Constructor.
		 * 
		 * @param	type	String
		 */
		public function PhysicsDestructionEvent(type:String)
		{
			super( type );
		}
	}
}
