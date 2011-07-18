package com.nilbog.dbc 
{
    import com.nilbog.assertions.assert;
    import com.nilbog.errors.InvariantFailureError;    
    com.nilbog.errors.InvariantFailureError;		
			
	
	/**
	 * Used to verify that an expression remains true for a time,
	 * as during a loop or method call.
	 * 
	 * @param	expression	Boolean
	 * @param	message		String
	 * 
	 * @throws	InvariantFailureError
	 */
    public function invariant( expression:Boolean, 
		message:String = "Invariant remains constant."):void
    {
        assert( expression, message, InvariantFailureError );
    }
}
