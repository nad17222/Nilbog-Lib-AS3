package com.nilbog.physics.shapes 
{
	import com.nilbog.physics.shapes.Physics2DShape;
	import com.nilbog.util.geometry.IPolygon;
	import com.nilbog.util.geometry.Polygon;

	import flash.display.DisplayObject;
	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class PhysicsPolygon extends Physics2DShape implements IPolygon
	{
		public function PhysicsPolygon( points:Vector.<Point>, graphic:DisplayObject=null, collisionGroup:int=0, collisionCategory:int=0x000f, collisionMask:int=0xffff, isSensor:Boolean=false )
		{
			super( graphic, collisionGroup, collisionCategory, collisionMask, isSensor);
			
			shape = new Polygon(points);
		}
		
		public function get vertices():Vector.<Point>
		{
			return (shape as IPolygon).vertices;
		}
	}
}
