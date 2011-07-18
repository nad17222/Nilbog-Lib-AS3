package com.nilbog.sfx 
{
	import flash.filters.BitmapFilter;
	import flash.filters.ColorMatrixFilter;

	/**
	 * @author jmhnilbog
	 */
	public class Greyscale 
	{
		public static function getFilter( luminosity:Number=1 ) :BitmapFilter
		{
			var mat:Array = 
			[ 
				luminosity, luminosity, luminosity, 0, 0,
          		luminosity, luminosity, luminosity, 0, 0,
          		luminosity, luminosity, luminosity, 0, 0,
          		luminosity, luminosity, luminosity, 1, 0
          	];
          	
			var colorMatrixFilter:ColorMatrixFilter = new ColorMatrixFilter(mat);
			return colorMatrixFilter;
		}
	}
}
