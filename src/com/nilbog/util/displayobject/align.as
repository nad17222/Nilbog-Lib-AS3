package com.nilbog.util.displayobject 
{
	import flash.display.DisplayObject;	import flash.geom.Rectangle;		
	
	/**
	 * Adapted from Yahoo! Flash Developer utilities.
	 * 
	 * Aligns a DisplayObject vertically and horizontally within specific bounds.
	 * 
	 * @param target			The DisplayObject to align.
	 * @param bounds			The rectangle in which to align the target DisplayObject.
	 * @param alignment			uint, a bitmask of Alignment constants.
	 */
	public function align(target:DisplayObject, bounds:Rectangle, alignment:uint):void
	{	
		var horizontalDifference:Number = bounds.width - target.width;
		
		if (alignment & Alignment.LEFT)
		{
			target.x = bounds.x;
		}
		else if (alignment & Alignment.CENTER)
		{
			target.x = bounds.x + (horizontalDifference) / 2;
		}
		else if (alignment & Alignment.RIGHT)
		{
			target.x = bounds.x + horizontalDifference;
		}
		else
		{
			// do nothing
		}	
		
		var verticalDifference:Number = bounds.height - target.height;
		
		if (alignment & Alignment.TOP)
		{
			target.y = bounds.y;
		}
		else if (alignment & Alignment.MIDDLE)
		{
			target.y = bounds.y + (verticalDifference) / 2;
		}
		else if (alignment & Alignment.BOTTOM)
		{
			target.y = bounds.y + verticalDifference;
		}
		else
		{
			// do nothing
		}	
	}}