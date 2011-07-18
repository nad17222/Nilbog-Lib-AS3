package com.nilbog.application 
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
			addTest(new ApplicationTest());
		}
	}
}
