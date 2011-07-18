package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.physics.shapes.PhysicsCircle;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author jmhnilbog
	 */
	public class SquidMantle extends PhysicsActor 
	{
		public function SquidMantle()
		{
			var square:Physics2DShape = Physics2DShape.generateShapeFromRectangle(new Rectangle(-1, -.7, 2, 2));
			var circle:Physics2DShape = new PhysicsCircle( 1, new Point(0, -1.2) );

			super( Physics2DShape.generateShapeList(square, circle), Material.FLESH, null, 0, new SquidMantleSprite() );
		}
	}
}
