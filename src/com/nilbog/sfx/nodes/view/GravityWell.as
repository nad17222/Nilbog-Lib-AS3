package com.nilbog.sfx.nodes.view 
{
	import flash.display.Sprite;

	/**
	 * @author jmhnilbog
	 */
	public class GravityWell extends Sprite 
	{
		public var strength:Number = 100;
		
		public function GravityWell()
		{
			with(graphics)
			{
				beginFill(0xffff00, 50);
				lineStyle(1, 0xffff00);
				drawCircle(0, 0, 20);
				endFill();
			}
		}
	}
}
