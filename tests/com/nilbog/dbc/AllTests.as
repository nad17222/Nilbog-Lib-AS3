package com.nilbog.dbc 
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
			addTest(new DesignByContractTest());
		}
	}
}
