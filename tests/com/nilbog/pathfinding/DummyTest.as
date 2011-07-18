package com.nilbog.pathfinding 
{
	import asunit.framework.TestCase;
	
	import com.nilbog.errors.IllegalStateError;				

	/**
	 * @author mark hawley
	 */
	public class DummyTest extends TestCase 
	{
		private var instance:Error;
		
		public function DummyTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			instance = new IllegalStateError();
		}
		
		protected override function tearDown() :void
		{
			instance = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("IllegalStateError instantiated.", instance is IllegalStateError);
		}
	}
}
