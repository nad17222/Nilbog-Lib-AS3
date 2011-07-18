package com.nilbog.util.number 
{
	/**
	 * Truncates a number to a certain precision.
	 * 
	 * @param	raw	Number to truncate
	 * @param	decimals, desired precision in digits
	 * 
	 * @return Number
	 */
	public function truncate(raw:Number, decimals:int=2) :Number 
	{
		var power:int = Math.pow(10, decimals);
		return Math.round(raw * ( power )) / power;
	}}