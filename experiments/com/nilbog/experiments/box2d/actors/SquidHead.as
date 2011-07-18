package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.physics.shapes.PhysicsCircle;

	/**
	 * @author jmhnilbog
	 */
	public class SquidHead extends PhysicsActor 
	{
		public function SquidHead()
		{
			var headCircle:PhysicsCircle = new PhysicsCircle(1);
			super( Physics2DShape.generateShapeList(headCircle), Material.FLESH, null, 0, new SquidHeadSprite() );
		}
	}
}
