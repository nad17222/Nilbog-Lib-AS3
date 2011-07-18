package com.nilbog.physics.events 
{
	import Box2D.Dynamics.b2World;

	import flash.events.Event;
	import flash.utils.Dictionary;

	/**
	 * The base event for Physics simulations.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsEvent extends Event 
	{
		// the physics engine has stepped
		public static const UPDATE:String = "physics update";
		
		// the physics engine timestep has changed
		public static const TIMESTEP_CHANGED:String = "timestep changed";
		
		// an array of all PhysicsActors that are in motion
		public var awakeActors:Array;
		
		/**
		 * Constructor.
		 * 
		 * @param	type	String
		 */
		public function PhysicsEvent(type:String)
		{	
			super( type);
		}
	}
}
