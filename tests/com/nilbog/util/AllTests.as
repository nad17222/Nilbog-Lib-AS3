package com.nilbog.util 
{
	import asunit.framework.TestSuite;

	import com.nilbog.util.geometry.AllTests;

	/**
	 * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new ArrayUtilTest());			addTest(new ClassUtilTest());			addTest(new RangeTest());
			addTest(new FontUtilTest());
			addTest(new FontUtilTest());
			addTest(new com.nilbog.util.geometry.AllTests());
		}
	}
}
