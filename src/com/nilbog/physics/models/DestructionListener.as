package com.nilbog.physics.models 
{
	
	import Box2D.Collision.Shapes.b2Shape;
	import Box2D.Dynamics.Joints.b2Joint;
	import Box2D.Dynamics.b2DestructionListener;

	/**
	 * A Box2d world listener that broadcasts joint and shape destruction event.
	 * 
	 * @author jmhnilbog
	 */
	internal class DestructionListener extends b2DestructionListener
	{
		private var model:PhysicsModel;
		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 */
		public function DestructionListener( m:PhysicsModel )
		{
			model = m;
		}

		/**
		 * Called when a joint is about to be destroyed.
		 * 
		 * @param	joint b2Joint
		 */
		override public function SayGoodbyeJoint(joint:b2Joint):void
		{
			model.onJointToBeDestroyed( joint );
		}

		/**
		 * Called when a shape	is about to be destroyed.
		 * 
		 * @param	shape	b2Shape
		 */
		override public function SayGoodbyeShape(shape:b2Shape):void
		{
			model.onShapeToBeDestroyed( shape );
		}
	}
}
