package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.physics.shapes.PhysicsPolygon;
	import com.nilbog.random.RNG;
	import com.nilbog.util.GraphicsUtil;
	import com.nilbog.util.array.castVectorToArray;
	import com.nilbog.util.geometry.GeometryUtil;
	import com.nilbog.util.geometry.Polygon;

	import flash.display.Sprite;
	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class RandomConvexShape extends PhysicsActor 
	{
		// TODO: fix obvious drawing problem
		public function RandomConvexShape(position:Point, radius:Number=1, rotation:Number = 0)
		{
			var vertices:uint = Math.floor( RNG.random() * 5 ) + 3;
			var poly:Polygon = GeometryUtil.createRandomConvexPolygon(vertices, radius);
			
			var sprite:Sprite = new Sprite();
			sprite.graphics.lineStyle( 0, 0xffff00 );
			sprite.graphics.beginFill( 0x333333 );
			GraphicsUtil.drawPoints(sprite.graphics, castVectorToArray(poly.vertices) );
			sprite.graphics.endFill();
			
			var shape:Physics2DShape = new PhysicsPolygon( poly.vertices );
			var shapeList:Vector.<Physics2DShape> = Physics2DShape.generateShapeList(shape);
			
			//trace("ShapeList: " + shapeList);
			
			super( shapeList, Material.GLASS, position, rotation, sprite );
		}
	}
}
