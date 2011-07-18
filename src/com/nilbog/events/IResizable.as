package com.nilbog.events 
{

	/**
	 * @author jmhnilbog
	 */
	public interface IResizable 
	{
		function get width() :Number;
		function set width(v:Number) :void;
		function get height() :Number;
		function set height(v:Number) :void
		function resize(width:Number, height:Number) :void;
	}
}
