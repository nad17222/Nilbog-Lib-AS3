package com.nilbog.sfx.lensflare 
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.utils.getDefinitionByName;

	/**
	 * @author markhawley
	 * 
	 * Part of the lens flare -- a shine, a halo, a flare, a sparkle...
	 */
	public class LensFlareElement extends Sprite 
	{
		/**
		 * Ugly, but this holds distance/scale/dScale/alpha/rotate data for this
		 * object. Defaults to a value in the defaults listed in LensFlare.
		 */
		public const relativeValues:Object = {};
		private var image:DisplayObject;

		/**
		 * Constructor. Playing with the parameters after className is
		 * recommended is you don't like the default effects.
		 * 
		 * @param	className	String, the name of a DisplayObject-descended
		 * 						class in the FLA's library
		 * @param	distance 	Number
		 * @param	scale		Number
		 * @param	dScale		Number
		 * @param	alpha		Number
		 * @param	rotate		Boolean
		 */
		public function LensFlareElement( className:String, distance:Number = NaN, 
			scale:Number = NaN, dScale:Number = NaN, alpha:Number = NaN, 
			rotate:Boolean = false )
		{
			var imageClass:Class = getDefinitionByName( className ) as Class;
			image = new imageClass( ) as DisplayObject;
			addChild( image );
				
			relativeValues.distance = distance;
			relativeValues.scale = scale;
			relativeValues.dScale = dScale;
			relativeValues.alpha = alpha;
			relativeValues.rotate = rotate;
		}
	}
}
