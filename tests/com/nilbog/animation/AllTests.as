package com.nilbog.animation 
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
			addTest(new AnimatorTest());
		}
	}
}
