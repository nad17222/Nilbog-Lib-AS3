package com.nilbog.physics.actors 
{
	import com.nilbog.physics.joints.PhysicsJoint;
	import com.nilbog.util.IDestroyable;

	/**
	 * @author jmhnilbog
	 */
	public class PhysicsMachine implements IDestroyable
	{
		public var parts:Object = {};
		public var joints:Array = [];

		public function PhysicsMachine()
		{
		}

		public function addActor( name:String, actor:PhysicsActor ):void
		{
			parts[name] = actor;
		}

		public function addJoint( joint:PhysicsJoint ):void
		{
			joints.push( joint );
		}

		public function destroy():void
		{
			for each (var part:String in parts) 
			{
				parts[part].destroy( );
				parts[part] = null;
			}
			joints = null;
			parts = null;
		}

		public function isDestroyed():Boolean
		{
			return null == parts;
		}
	}
}
