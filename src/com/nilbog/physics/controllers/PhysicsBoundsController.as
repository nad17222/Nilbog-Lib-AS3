package com.nilbog.physics.controllers 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.events.PhysicsBoundaryEvent;
	import com.nilbog.physics.events.PhysicsEvent;
	import com.nilbog.physics.models.PhysicsModel;
	import com.nilbog.physics.views.PhysicsView;

	import flash.events.TimerEvent;
	import flash.utils.Timer;

	/**
	 * Calls onOutOfBounds whenever an actor leaves the simulation space.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsBoundsController extends PhysicsController
	{		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 * @param	v	PhysicsView (defaults to null)
		 */
		public function PhysicsBoundsController(m:PhysicsModel, v:PhysicsView=null)
		{
			super(m, v);
			
			log.trace("%s(%s)", "PhysicsBoundsController", arguments.join(", "));
			
			var m:PhysicsModel = getModel() as PhysicsModel;
			m.addEventListener( PhysicsBoundaryEvent.OUT_OF_BOUNDS, onOutOfBounds);
		}
		
		/**
		 * Called when an actor leaves the bounds of the simulation.
		 * 
		 * @param	event	TimerEvent
		 */
		protected function onOutOfBounds(event:PhysicsBoundaryEvent) :void
		{
			log.trace("%s(%s)", "onPhysicsBoundardEvent", arguments.join(", "));
			
			// the bounds controller only cares about events involving
			// PhysicsActors -- not ordinary b2Bodies.
			
			var actor:PhysicsActor = event.actor;
			if (null == actor)
			{
				log.info("No actor associated with OOB b2Body: %s", actor); 
			}
			else
			{
				var m:PhysicsModel = getModel() as PhysicsModel;
				m.removeActor(actor);
				log.info("Removed actor: " + actor);
				actor.destroy();
			}
		}
	}
}
