package com.nilbog.experiments.box2d.actors 
{
	import com.nilbog.physics.actors.PhysicsActor;
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;

	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class StaticWall extends PhysicsActor 
	{
		public function StaticWall(width:Number, height:Number, position:Point = null, rotation:Number = 0)
		{
			var shape:Physics2DShape = Physics2DShape.generateShapeFromWidthAndHeight(width, height);
			
			//var material:Material = new Material(0, Material.GRANITE.restitution, Material.GRANITE.friction);
			var material:Material = new Material(0, 0, 1);
			super( Physics2DShape.generateShapeList(shape), material, position, rotation, new PhysGround() );
		}
	}
}
