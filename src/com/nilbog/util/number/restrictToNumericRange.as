package com.nilbog.util.number 
{    import com.nilbog.dbc.precondition;
    import com.nilbog.util.Range;    			
	
	/**
     * Returns a number within an upper and lower limit.
     * 
     * @param value Number The number to limit
     * @param range	Range A Range with numeric bounds.
     * 
     * @return Number, value confined to the bounds of Range.
     */
    public function restrictToNumericRange(value:Number, range:Range):Number 
    {
    	precondition(range.minimum is Number);
    	
    	return Math.max(range.minimum, Math.min(range.maximum, value)); 
    }
}