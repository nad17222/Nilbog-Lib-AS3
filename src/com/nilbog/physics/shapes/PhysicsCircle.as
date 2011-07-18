package com.nilbog.physics.shapes 
{
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.util.geometry.Circle;
	import com.nilbog.util.geometry.ICircle;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class PhysicsCircle extends Physics2DShape implements ICircle
	{
		public function PhysicsCircle( radius:Number=1, center:Point=null, graphic:DisplayObject=null, collisionGroup:int=0, collisionCategory:int=0x000f, collisionMask:int=0xffff, isSensor:Boolean=false)
		{
			super(graphic, collisionGroup, collisionCategory, collisionMask, isSensor);
			
			shape = new Circle(radius, center );
		}
		
		public function get radius():Number
		{
			return (shape as ICircle).radius;
		}
		public function set radius(v:Number) :void
		{
			(shape as Circle).radius = v;
		}
	}
}
