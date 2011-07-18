package com.nilbog.util.font 
{
	import com.nilbog.assertions.fail;
	import com.nilbog.dbc.precondition;

	import flash.geom.Rectangle;
	import flash.text.AntiAliasType;
	import flash.text.GridFitType;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * Font-related utilities.
	 * 
	 * @author jmhnilbog
	 */
	public class FontUtil 
	{
		private static var test:TextField = new TextField();
		
		public function FontUtil()
		{
			fail("FontUtil is a static class.");
		}
		
		/**
		 * Returns true if a given font appears to have a fixed width.
		 * 
		 * @param fontName String, the font name as understood in Flash
		 * 
		 * @return Boolean
		 */
		public static function isFixedWidth( fontName:String ) :Boolean
		{
			var isFixed:Boolean = true;
			
			var tf:TextFormat = test.getTextFormat();
			tf.align = TextFormatAlign.LEFT;
			tf.font = fontName;
				
			test.defaultTextFormat = tf;
			test.antiAliasType = AntiAliasType.ADVANCED;
			test.gridFitType = GridFitType.PIXEL;
			test.text = "abcefABCDEF12345";
				
			var charWidth:Number = test.getCharBoundaries(0).width;
				
			for (var i:uint = 1; i < test.text.length; i++)
			{
				isFixed &&= test.getCharBoundaries(i).width == charWidth;	
			}
			return isFixed;
		}
		
		/**
		 * Returns the bounding box of a character in a certain text field.
		 * 
		 * @param	tf	TextField
		 * @param char	String, a 1-letter string.
		 * 
		 * @return	Rectangle
		 */
		public static function getCharacterBoundaries( tf:TextField, char:String="A" ) :Rectangle
		{
			precondition(char.length == 1);
			
			const original:String = tf.text;
			tf.text = char;
			var bounds:Rectangle = tf.getCharBoundaries(0);
			tf.text = original;
			return bounds;
		}
	}
}
