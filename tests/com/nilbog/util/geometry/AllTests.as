package com.nilbog.util.geometry 
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
			addTest(new Vector2DTest());
		}
	}
}
