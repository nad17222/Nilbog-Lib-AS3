package  
{
    import asunit.framework.TestSuite;        import com.*;
    import asunit.*;
    /**
     * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new com.AllTests());
			addTest(new asunit.AllTests());
		}
	}
}
