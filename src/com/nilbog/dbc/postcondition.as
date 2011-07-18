package com.nilbog.dbc 
{
    import com.nilbog.assertions.assert;
    import com.nilbog.errors.PostconditionFailureError;    
    com.nilbog.errors.PostconditionFailureError;		
	
	/**
	 * Checks that an expression is true, throwing an error if not. The 
	 * expression should relate to object state at the end of a method
	 * call.
	 * 
	 * @param	expression	Boolean
	 * @param	message		String
	 * 
	 * @throws	PostconditionFailureError
	 */
    public function postcondition( expression:Boolean, 
		message:String = "Postcondition is true."):void
    {
        assert( expression, message, PostconditionFailureError );
    }
}
