package com.nilbog.physics.events 
{
	import com.nilbog.physics.actors.PhysicsActor;

	import flash.events.Event;

	/**
	 * A PhysicsEvent related to a specific actor.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsActorEvent extends PhysicsEvent 
	{
		// an actor has been added to the simulation
		public static const ADDED:String = "physics actor added";
		
		// an actor has been removed from the simulation
		public static const REMOVED:String = "physics actor removed";
		
		// the actor involved
		public var actor:PhysicsActor;
		
		/**
		 * Constructor.
		 * 
		 * @param	type	String
		 */
		public function PhysicsActorEvent(type:String)
		{
			super( type );
		}
	}
}
