package com.nilbog.physics.controllers 
{
	import com.nilbog.physics.models.PhysicsModel;
	import com.nilbog.physics.views.PhysicsView;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Controls the heartbeat of a physics simulation.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsTickController extends PhysicsController
	{		
		private var timer:Timer;
		private var timestep:Number;
		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 * @param	v	PhysicsView (defaults to null)
		 */
		public function PhysicsTickController(m:PhysicsModel, v:PhysicsView=null)
		{
			super(m, v);
			
			log.trace("%s(%s)", "PhysicsTickController", arguments.join(", "));
			
			var m:PhysicsModel = getModel() as PhysicsModel;
			timestep = m.timestep;
			timer = new Timer( timestep * 1000 );
			timer.addEventListener( TimerEvent.TIMER, onTick );
			timer.start();
		}
		
		/**
		 * Called once per timestep milliseconds. Advances the physics model
		 * the same number of milliseconds.
		 * 
		 * @param	event	TimerEvent
		 */
		protected function onTick(event:TimerEvent) :void
		{
			log.trace("%s(%s)", "onTick", arguments.join(", "));
			
			var m:PhysicsModel = getModel() as PhysicsModel;
			m.update();
		}
	}
}
