package com.nilbog.assertions
{
	import com.nilbog.errors.IllegalStateError;	
	import com.nilbog.errors.IllegalArgumentError;	
	import com.nilbog.errors.AssertionFailureError;	
	
	import asunit.framework.TestCase;		

	/**
	 * @author mark hawley
	 */
	public class AssertionTest extends TestCase 
	{
		public function AssertionTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testAssert() :void
		{
			assert(2+2 == 4);
			assertTrue("asserted 2+2==4.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				assert(2+2 == 5);
			}
			catch(e:AssertionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("2+2 != 5", errorCaught);
		}
		
		public function testCheckArgument() :void
		{
			checkArgument(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				checkArgument(false);
			}
			catch(e:IllegalArgumentError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
		}
		
		public function testCheckNotNull() :void
		{
			checkNotNull(undefined);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				checkNotNull(null);
			}
			catch(e:AssertionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
		}
		
		public function testCheckNotNullOrUndefined() :void
		{
			checkNotNullOrUndefined(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				checkNotNullOrUndefined(null);
			}
			catch(e:AssertionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
			
			try
			{
				checkNotNullOrUndefined(undefined);
			}
			catch(e:AssertionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("second falsity caught", errorCaught);
		}
		
		public function testCheckNotUndefined() :void
		{
			checkNotUndefined(null);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				checkNotUndefined(undefined);
			}
			catch(e:AssertionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
		}
		
		public function testCheckState() :void
		{
			checkState(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				checkState(false);
			}
			catch(e:IllegalStateError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
		}
	}
}
