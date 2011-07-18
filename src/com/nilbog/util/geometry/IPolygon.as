package com.nilbog.util.geometry 
{
	import flash.geom.Point;

	/**
	 * @author jmhnilbog
	 */
	public interface IPolygon extends IShape
	{
		function get vertices() :Vector.<Point>;
	}
}
