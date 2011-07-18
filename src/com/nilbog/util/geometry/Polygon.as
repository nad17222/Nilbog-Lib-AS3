package com.nilbog.util.geometry 
{
	import com.nilbog.dbc.precondition;
	import com.nilbog.util.string.sprintf;

	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author jmhnilbog
	 */
	public class Polygon implements IPolygon
	{
		private var _points:Vector.<Point>;
		
		public static function fromRectangle(r:Rectangle) :Polygon
		{
			var p:Vector.<Point> = Vector.<Point>(
			[ 
				r.topLeft, 
				new Point(r.x + r.width, r.y), 
				r.bottomRight, 
				new Point(r.x, r.y + r.height)
			]);
			return new Polygon( p );
		}
		
		public function Polygon( points:Vector.<Point> )
		{
			precondition(points.length >=3 );
			
			_points = points;
		}
		
		public function get vertices():Vector.<Point>
		{
			return _points;
		}
		
		public function get center():Point
		{
			var bounds:Rectangle = GeometryUtil.getBoundingBox(_points);
			var c:Point = new Point( bounds.x + bounds.width/2, bounds.y + bounds.height/2 );
			return c;
		}
		
		public function toString() :String
		{
			var s:String = sprintf("Polygon (%s-gon: %s)", vertices.length, vertices);
			return s;
		}
	}
}
