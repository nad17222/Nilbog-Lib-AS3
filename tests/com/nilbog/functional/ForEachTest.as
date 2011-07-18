package com.nilbog.functional 
{
	import asunit.framework.TestCase;				

	/**
	 * @author mark hawley
	 */
	public class ForEachTest extends TestCase 
	{
		public const BLARG:String = "BLARG";
		
		public function ForEachTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testBadForEachCall() :void
		{
			var thrown:Boolean = false;
			
			try
			{
				forEach( this, "BAD");
			}
			catch( e:Error )
			{
				thrown = true;
			}
			
			assertTrue("Nope, can't call map like that.", thrown);
		}
	}
}
