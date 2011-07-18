package com.nilbog.application
{
	import asunit.framework.TestCase;

	import com.nilbog.animation.Animation;
	import com.nilbog.log.Logger;

	/**
	 * @author mark hawley
	 */
	public class ApplicationTest extends TestCase 
	{
		private var instance:Application;
		
		public function ApplicationTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			// protect original values
			var description:ApplicationDescription = new ApplicationDescription();
			description.logger = Logger.logManager;
			description.animationPackage = Animation.animator;
			
			instance = new MockApplication( description );
			addChild(instance);
		}
		
		protected override function tearDown() :void
		{
			removeChild(instance);
			instance.destroy();
			instance = null;
		}

		public function testInstantiation() :void
		{
			assertTrue("Application instantiated.", instance is Application);
		}
	}
}
