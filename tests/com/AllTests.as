package com 
{
    import asunit.framework.TestSuite;
    
    import com.nilbog.AllTests;	

    /**
	 * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new com.nilbog.AllTests());
		}
	}
}
