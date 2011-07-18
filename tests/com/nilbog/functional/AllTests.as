package com.nilbog.functional
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
			addTest(new MapTest());			addTest(new ForEachTest());			addTest(new ReduceTest());
		}
	}
}
