package com.nilbog.errors 
{
	import asunit.framework.TestCase;				

	/**
	 * @author mark hawley
	 */
	public class IllegalStateErrorTest extends TestCase 
	{
		private var instance:Error;
		
		public function IllegalStateErrorTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			instance = new IllegalStateError();
		}
		
		protected override function tearDown() :void
		{
			instance = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("IllegalStateError instantiated.", instance is IllegalStateError);
		}
	}
}
