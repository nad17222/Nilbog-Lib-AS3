package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.assertions.assert;
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.physics.shapes.PhysicsPolygon;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class SquareFace extends PhysicsActor 
	{
		public function SquareFace(width:Number, height:Number, position:Point = null, rotation:Number = 0)
		{
			var shape:Physics2DShape = Physics2DShape.generateShapeFromWidthAndHeight(width, height);
			super( Physics2DShape.generateShapeList(shape), Material.GLASS, position, rotation, new PhysBox() );
		}
		
		
	}
}
