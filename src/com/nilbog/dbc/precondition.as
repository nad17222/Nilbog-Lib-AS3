package com.nilbog.dbc 
{
    import com.nilbog.assertions.assert;
    import com.nilbog.errors.PreconditionFailureError;    
    com.nilbog.errors.PreconditionFailureError;				
	
	/**
	 * Checks that an expression is true, throwing an error if not. The 
	 * expression should relate to object state at the beginning of a method
	 * call.
	 * 
	 * @param	expression	Boolean
	 * @param	message		String
	 * 
	 * @throws	PreconditionFailureError
	 */
    public function precondition( expression:Boolean, 
		message:String="Precondition is true."):void
    {
        assert( expression, message, PreconditionFailureError );
    }
}