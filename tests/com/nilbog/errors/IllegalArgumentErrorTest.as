package com.nilbog.errors 
{
	import asunit.framework.TestCase;				

	/**
	 * @author mark hawley
	 */
	public class IllegalArgumentErrorTest extends TestCase 
	{
		private var instance:Error;
		
		public function IllegalArgumentErrorTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			instance = new IllegalArgumentError();
		}
		
		protected override function tearDown() :void
		{
			instance = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("IllegalArgumentError instantiated.", instance is IllegalArgumentError);
		}
	}
}
