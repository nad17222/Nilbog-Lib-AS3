package com.nilbog.physics.joints 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2DistanceJointDef;

	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.joints.PhysicsJoint;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class DistanceJoint extends PhysicsJoint 
	{
		public var frequencyHz:Number;
		public var dampingRatio:Number;
		public var length:Number;
		
		private var actor1:PhysicsActor;
		private var actor2:PhysicsActor;
		private var anchor1:Point;
		private var anchor2:Point;
		
		public function DistanceJoint( actor1:PhysicsActor, actor2:PhysicsActor, anchor1:Point, anchor2:Point, length:Number=1, frequencyHz:Number=0, dampingRatio:Number=0 )
		{
			this.actor1 = actor1;
			this.actor2 = actor2;
			this.anchor1 = anchor1;
			this.anchor2 = anchor2;
			this.length = length;
			this.frequencyHz = frequencyHz;
			this.dampingRatio = dampingRatio;
			
			jointDef = new b2DistanceJointDef();
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2DistanceJointDef = jointDef as b2DistanceJointDef;
			
			j.Initialize(actor1.body, actor2.body, new b2Vec2( anchor1.x, anchor1.y ), new b2Vec2( anchor2.x, anchor2.y ));
			j.frequencyHz = frequencyHz;
			j.dampingRatio = dampingRatio;
			this.length != 1 ? j.length = length : 1;
			
			actor1 = null;
			actor2 = null;
			anchor1 = null;
			anchor2 = null;
		}
		
		override public function destroy() :void
		{
			actor1 = null;
			actor2 = null;
			anchor1 = null;
			anchor2 = null;
			
			super.destroy();
		}
	}
}
