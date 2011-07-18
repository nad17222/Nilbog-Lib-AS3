package com.nilbog.physics.events 
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2ContactResult;

	import flash.events.Event;

	/**
	 * A PhysicsEvent triggered when two bodies interact.
	 * 
	 * @author jmhnilbog
	 */
	public class PhysicsContactEvent extends PhysicsEvent 
	{
		// two bodies touch at a new point
		public static const CONTACT_ADDED:String = "contact added";
		
		// two bodies maintain a contact
		public static const CONTACT_PERSISTED:String = "contact persisted";
		
		// two bodies lose a contact point.
		public static const CONTACT_REMOVED:String = "contact removed";
		
		// the physics of a contact have been resolved
		public static const CONTACT_RESOLVED:String = "contact resolved";
		
		// the contact point associated with added, persisted, and removed events
		public var contactPoint:b2ContactPoint;
		
		// the contact resolution associated withg resolved event
		public var contactResolution:b2ContactResult;
		
		public function PhysicsContactEvent(type:String)
		{
			super( type );
		}
	}
}
