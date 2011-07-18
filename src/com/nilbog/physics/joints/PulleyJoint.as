package com.nilbog.physics.joints 
{
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.Joints.b2PulleyJointDef;

	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.joints.PhysicsJoint;
	import com.nilbog.util.Range;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class PulleyJoint extends PhysicsJoint 
	{
		private var actor1:PhysicsActor;
		private var actor2:PhysicsActor;
		private var anchor1:Point;
		private var anchor2:Point;
		private var groundAnchor1:Point;
		private var groundAnchor2:Point;
		private var ratio:Number;
				
		public function PulleyJoint(actor1:PhysicsActor, actor2:PhysicsActor, groundAnchor1:Point, groundAnchor2:Point, anchor1:Point, anchor2:Point, ratio:Number=1)
		{
			this.actor1 = actor1;
			this.actor2 = actor2;
			this.groundAnchor1 = groundAnchor1;
			this.groundAnchor2 = groundAnchor2;
			this.anchor1 = anchor1;
			this.anchor2 = anchor2;
			this.ratio = ratio;
			
			jointDef = new b2PulleyJointDef();
		}
		
		override public function initialize() :void
		{
			super.initialize();
			
			var j:b2PulleyJointDef = jointDef as b2PulleyJointDef;
			j.Initialize(actor1.body, actor2.body, new b2Vec2(groundAnchor1.x, groundAnchor2 .y), new b2Vec2(groundAnchor2.x, groundAnchor2.y), new b2Vec2(anchor1.x, anchor1.y), new b2Vec2(anchor2.x, anchor2.y), ratio );
			
			actor1 =null;
			actor2 = null;
			groundAnchor1 = null;
			groundAnchor2 = null;
			anchor1 = null;
			anchor2 = null;
		}

		override public function destroy() :void
		{
			actor1 =null;
			actor2 = null;
			groundAnchor1 = null;
			groundAnchor2 = null;
			anchor1 = null;
			anchor2 = null;
			
			super.destroy();
		}
	}
}
