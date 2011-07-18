package com.nilbog.animation
{
	import asunit.framework.TestCase;

	public class AnimatorTest extends TestCase 
	{
		private var animated:Object;
		private var animator:*;
	
		/**
		 * Standard setUp() method. Called before each test.
		 */
		protected override function setUp():void 
		{
			animated = { x: 0, y: 0 };
			animator = Animation.animator;
		}

		/**
		 * Standard tearDown() method. Called after each test.
		 */
		protected override function tearDown():void 
		{
			animated = null;
			animator = null;
		}
	
		/**
		 * Tests a simple true assertion.
		 */
		public function testAnimation():void 
		{
			animator.to( animated, 0, { y: 100 } );
			assertTrue("Animated y to 100. (" + animated.y + ")", 100 == animated.y);
		}
	}
}
