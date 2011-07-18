package com.nilbog.sfx.bubble 
{
	import com.nilbog.random.RNG;

	import flash.display.Sprite;

	/**
	 * @author jmhnilbog
	 */
	public class BubbleField extends Sprite 
	{
		public const LENS_RADIUS:Number = 100;
		public const MAGNIFICATION:Number = 4;
		
		private const bubbles:Vector.<BubbleSprite> = new Vector.<BubbleSprite>();
		
		public function BubbleField()
		{
			// add some bubbles
			for (var i:uint = 0; i < 50; i++)
			{
				var b:BubbleSprite = new BubbleSprite( this );
				b.x = RNG.random() * 200 - 100;
				b.y = RNG.random() * 200 - 100;
				addChild(b);
				bubbles.push(b);
			}
		}
	}
}
