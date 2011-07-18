package com.nilbog.util.geometry 
{
	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public class Circle implements ICircle
	{
		private const _center:Point = new Point(0, 0);
		
		private var _radius:Number = 1;
		
		public function Circle( radius:Number=1, center:Point=null )
		{
			if (null != center)
			{
				this.center.x = center.x;
				this.center.y = center.y;
			}
			this._radius = radius;
		}
		
		public function get radius():Number
		{
			return _radius;
		}
		public function set radius(v:Number) :void
		{
			_radius = v;
		}
		
		public function get center():Point
		{
			return _center;
		}
	}
}
