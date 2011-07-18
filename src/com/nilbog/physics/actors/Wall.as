package com.nilbog.physics.actors 
{
	import com.nilbog.physics.materials.Material;
	import com.nilbog.physics.shapes.Physics2DShape;

	/**
	 * @author jmhnilbog
	 */
	public class Wall extends PhysicsActor 
	{
		public function Wall(shapeList:Vector.<Physics2DShape>, material:Material)
		{
			super( shapeList, material );
		}
	}
}
