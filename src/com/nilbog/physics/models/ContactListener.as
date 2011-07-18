package com.nilbog.physics.models 
{
	import Box2D.Collision.b2ContactPoint;
	import Box2D.Dynamics.Contacts.b2ContactResult;
	import Box2D.Dynamics.b2ContactListener;

	

	/**
	 * A Box2d world listener that boradcasts contact events.
	 * 
	 * @author jmhnilbog
	 */
	internal class ContactListener extends b2ContactListener
	{
		private var model:PhysicsModel;
		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 */
		public function ContactListener( m:PhysicsModel )
		{
			model = m;
		}
		
		/**
		 * Called as bodies contact each other.
		 * 
		 * @param	point	b2ContactPoint
		 */
		override public function Add(point:b2ContactPoint) :void
		{
			model.onContactPointAdded(point);
		}
		
		/**
		 * Called as bodies' contacts persist over multiple steps.
		 * 
		 * @param	point	b2ContactPoint
		 */
		override public function Persist(point:b2ContactPoint) :void
		{
			model.onContactPointPersisted(point);
		}
		
		/**
		 * Called as bodies disengage from each other.
		 * 
		 * @param	point	b2ContactPoint
		 */
		override public function Remove(point:b2ContactPoint) :void
		{
			model.onContactPointRemoved(point);
		}
		
		/**
		 * Called as contacts as resolved.
		 * 
		 * @param point	b2ContactResult
		 */
		override public function Result(point:b2ContactResult) :void
		{
			model.onContactPointResolved(point);
		}
	}
}
