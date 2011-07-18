package com.nilbog.physics.controllers 
{
	import com.nilbog.mvc.AbstractController;
	import com.nilbog.mvc.IController;
	import com.nilbog.physics.models.PhysicsModel;
	import com.nilbog.physics.views.PhysicsView;

	/**
	 * Base controller class for physics-based simulations.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsController extends AbstractController implements IController
	{	
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 * @param	v	PhysicsView (defaults to null)
		 */
		public function PhysicsController(m:PhysicsModel, v:PhysicsView=null)
		{
			super(m, v);
			
			log.trace("%s(%s)", "PhysicsController", arguments.join(", "));
		}
	}
}
