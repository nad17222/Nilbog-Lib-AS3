package com.nilbog.util 
{
	import asunit.framework.TestCase;

	import com.nilbog.util.string.chomp;
	import com.nilbog.util.string.ltrim;
	import com.nilbog.util.string.rtrim;
	import com.nilbog.util.string.trim;

	/**
	 * @author mark hawley
	 */
	public class StringUtilTest extends TestCase 
	{
		public function StringUtilTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
		}
		
		protected override function tearDown() :void
		{
		}
		
		public function testChomp() :void
		{
			var t:String = "Test string\n";
			var chomped:String = chomp(t);
			
			assertTrue("Chomp removed trailing newline.", "Test string" == chomped);
			assertTrue("Chomp did not remove other trailing character.", "Test string" == chomp(chomped));
		}
		
		public function testTrim() :void
		{
			var a:String = "   test   ";
			var b:String = "test   ";
			var c:String = "   test";
			
			assertTrue("Trim removed spaces.", "test" == trim(a));
			assertTrue("Ltrim removed left spaces.", "test" == ltrim(c) && "test   " == ltrim(a));
			assertTrue("Rtrim removed right spaces.", "test" == rtrim(b) && "   test" == rtrim(a));
		}
	}
}
