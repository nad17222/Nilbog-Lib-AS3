package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.PhysicsCircle;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class CircleFace extends PhysicsActor 
	{
		public function CircleFace(radius:Number, position:Point = null, rotation:Number = 0)
		{
			super( Vector.<Point>([new PhysicsCircle(radius)]), Material.STEEL, position, rotation, new PhysCircle() );
		}
	}
}
