package com.nilbog.physics.events 
{
	import com.nilbog.physics.actors.PhysicsActor;

	import flash.events.Event;

	/**
	 * A PhysicsEvent triggered by an interaction with the bounds of the 
	 * simulation space.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsBoundaryEvent extends PhysicsEvent 
	{
		// an actor has moved out of bounds
		public static const OUT_OF_BOUNDS:String = "out of bounds";
		
		// the actor affected
		public var actor:PhysicsActor;
		
		/**
		 * Constructor.
		 * 
		 * @param type	String
		 */
		public function PhysicsBoundaryEvent(type:String)
		{
			super( type );
		}
	}
}
