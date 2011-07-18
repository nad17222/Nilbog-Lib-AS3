package com.nilbog.dbc
{
	import asunit.framework.TestCase;
	
	import com.nilbog.errors.InvariantFailureError;
	import com.nilbog.errors.PostconditionFailureError;
	import com.nilbog.errors.PreconditionFailureError;		

	/**
	 * @author mark hawley
	 */
	public class DesignByContractTest extends TestCase 
	{
		public function DesignByContractTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testPrecondition() :void
		{
			precondition(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				precondition(false);
			}
			catch(e:PreconditionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("asserted false", errorCaught);
		}
		
		public function testPostcondition() :void
		{
			postcondition(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				postcondition(false);
			}
			catch(e:PostconditionFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("asserted false", errorCaught);
		}
		
		public function testInvariant() :void
		{
			invariant(true);
			assertTrue("asserted truth.", true);
			
			var errorCaught:Boolean = false;
			try
			{
				invariant(false);
			}
			catch(e:InvariantFailureError)
			{
				errorCaught = true;	
			}
			
			assertTrue("falsity caught", errorCaught);
		}
	}
}
