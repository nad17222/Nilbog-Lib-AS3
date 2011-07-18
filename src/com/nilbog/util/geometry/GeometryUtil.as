package com.nilbog.util.geometry 
{
	import com.nilbog.assertions.checkArgument;
	import com.nilbog.random.RNG;

	import flash.display.DisplayObject;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author jmhnilbog
	 */
	public class GeometryUtil 
	{
		public static function getBoundingBoxOfPoints( points:Vector.<Point> ) :Rectangle
		{
			var minX:Number = Number.POSITIVE_INFINITY;
			var maxX:Number = Number.NEGATIVE_INFINITY;
			var minY:Number = Number.POSITIVE_INFINITY;
			var maxY:Number = Number.NEGATIVE_INFINITY;
			
			for (var i:uint=0; i < points.length; i++)
			{
				var p:Point = points[i];
				minX = Math.min( p.x, minX );
				maxX = Math.max( p.x, maxX );
				minY = Math.min( p.y, minY );
				maxY = Math.max( p.y, maxY );
			}
			
			var rect:Rectangle = new Rectangle(minX, minY, maxX - minX, maxY - minY);
			return rect;
		}
		
		public static function getBoundingBox( points:Object ) :Rectangle
		{
			checkArgument( points is Array || points is Vector.<Point> || points is DisplayObject || points is Rectangle || points is IShape );
			
			if (points is Array)
			{
				var v:Vector.<Point> = new Vector.<Point>;
				for (var i:uint=0; i < points.length; i++)
				{
					v[i] = points[i];	
				}
				return getBoundingBoxOfPoints(v);
			}
			else if (points is Vector.<Point>)
			{
				return getBoundingBoxOfPoints(points as Vector.<Point>);
			}
			else if (points is DisplayObject)
			{
				var d:DisplayObject = points as DisplayObject;
				return d.getBounds(d);
			}
			else if (points is Rectangle)
			{
				return points as Rectangle;
			}
			else if (points is IShape)
			{
				if (points is ICircle)
				{
					var c:ICircle = points as ICircle;
					return new Rectangle( c.center.x, c.center.y, c.radius * 2, c.radius * 2);
				}
				else if (points is IPolygon)
				{
					var p:IPolygon = points as IPolygon;
					return getBoundingBoxOfPoints(p.vertices);
				}
			}
			else
			{
				throw new Error();
			}
			return null;
		}

		public static function getWidth( ...points ) :Number
		{
			return getBoundingBox(points).width;
		}
		
		public static function getHeight( ...points ) :Number
		{
			return getBoundingBox.(points).height;
		}
		
		public static function createRandomConvexPolygon( vertexCount:uint=0, radius:Number=1, center:Point=null ) :Polygon
		{
			if (vertexCount < 3)
			{
				vertexCount = RNG.random() * 20;
			}
			if (null == center)
			{
				center = new Point();
			}
			
			// generate random times
			var tList:Array = [];
			for (var i:uint=0; i < vertexCount; i++)
			{
				tList.push( RNG.random() * Math.PI * 2 );
			}
			tList.sort();
			
			var points:Vector.<Point> = new Vector.<Point>();
			for (i = 0; i < vertexCount; i++)
			{
				var t:Number = tList[i];
				var x:Number = radius * Math.cos(t) - (radius/2) + center.x;
				var y:Number = radius * Math.sin(t) - (radius/2) + center.y;	
				points.push( new Point(x, y) );
			}
			
			var poly:Polygon = new Polygon(points);
			return poly;
		}
	}
}
