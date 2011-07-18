package com.nilbog.errors 
{
	import asunit.framework.TestSuite;
	
	/**
	 * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new AssertionFailureErrorTest());
			addTest(new IllegalArgumentErrorTest());
			addTest(new IllegalStateErrorTest());
		}
	}
}
