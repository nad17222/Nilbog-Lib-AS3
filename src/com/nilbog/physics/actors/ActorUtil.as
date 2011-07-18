package com.nilbog.physics.actors 
{
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.models.PhysicsModel;
	import com.nilbog.physics.shapes.Physics2DShape;

	import flash.geom.Rectangle;

	/**
	 * @author jmhnilbog
	 */
	public class ActorUtil 
	{
		public static function encloseRectangle( m:PhysicsModel, r:Rectangle=null ) :void
		{
			if (null == r)
			{
				r = m.worldSize;
			}
			
			var thickness:Number = 1;
			
			var ceilingShape:Physics2DShape = Physics2DShape.generateShapeFromRectangle(new Rectangle(r.left-thickness-(r.width/2), r.top-thickness-(r.height/2), r.width+(thickness*2), thickness));
			var floorShape:Physics2DShape = Physics2DShape.generateShapeFromRectangle(new Rectangle(r.left-thickness, r.bottom, r.width+(thickness * 2), thickness));
			var leftShape:Physics2DShape = Physics2DShape.generateShapeFromRectangle(new Rectangle(r.left, r.top, 1, r.height));
			var rightShape:Physics2DShape = Physics2DShape.generateShapeFromRectangle(new Rectangle(r.right, r.top, 1, r.height));
			
			var wallShapes:Vector.<Physics2DShape> = Physics2DShape.generateShapeList( ceilingShape, floorShape, leftShape, rightShape );
			var wall:Wall = new Wall(wallShapes, Material.GRANITE );
			
			m.addActor(wall);
		}
	}
}
