package com.nilbog.util.displayobject 
{
	import com.nilbog.assertions.fail;

	/**
	 * @author jmhnilbog
	 */
	public class Alignment 
	{
		public static const LEFT:uint = 1;
		public static const CENTER:uint = 2;
		public static const RIGHT:uint = 4;
		public static const TOP:uint = 8;
		public static const MIDDLE:uint = 16;
		public static const BOTTOM:uint = 32;
		
		public function Alignment( value:uint ) 
		{
			fail("This class not not to be instantiated.");
		}
	}
}
