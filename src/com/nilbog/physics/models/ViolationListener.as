package com.nilbog.physics.models 
{
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BoundaryListener;

	/**
	 * A Box2d world listener that broadcasts events as bodies leave the bounds
	 * of the simulation.
	 * 
	 * @author jmhnilbog
	 */
	internal class ViolationListener extends b2BoundaryListener
	{
		private var model:PhysicsModel;
		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 */
		public function ViolationListener( m:PhysicsModel )
		{
			model = m;
		}

		/**
		 * Called as bodies leave the bounds of the simulation.
		 * 
		 * @param	body	b2Body
		 */
		override public function Violation(body:b2Body):void
		{
			model.onOutOfBounds( body );
		}
	}
}
