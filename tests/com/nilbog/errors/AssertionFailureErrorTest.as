package com.nilbog.errors 
{
	import asunit.framework.TestCase;			

	/**
	 * @author mark hawley
	 */
	public class AssertionFailureErrorTest extends TestCase 
	{
		private var instance:Error;
		
		public function AssertionFailureErrorTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			instance = new AssertionFailureError();
		}
		
		protected override function tearDown() :void
		{
			instance = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("AssertionFailureError instantiated.", instance is AssertionFailureError);
		}
	}
}
