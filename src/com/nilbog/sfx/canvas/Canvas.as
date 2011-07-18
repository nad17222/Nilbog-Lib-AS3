package com.nilbog.sfx.canvas 
{
	import com.nilbog.errors.AbstractMethodCallError;

	import flash.display.Sprite;

	/**
	 * @author jmhnilbog
	 */
	public class Canvas extends Sprite 
	{
		public function Canvas()
		{
			super();
		}
		
		public function updateCanvas() :void
		{
			throw new AbstractMethodCallError();
		}
	}
}
