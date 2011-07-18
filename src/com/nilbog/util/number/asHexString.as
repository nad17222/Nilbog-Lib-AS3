package com.nilbog.util.number 
{
	/**
	 * Adapted from as3lib.
	 * 
	 * Converts a uint into a string in the format "0x123456789ABCDEF". 
	 * This function is quite useful for displaying hex colors as text.
	 * The function <code>toString(radix:uint)</code> does a similar job but doesn't include
	 * "0x" at the beginning of the result nor does it include leading zeroes.
	 * 
	 * @author Mims H. Wright
	 * 
	 * @use getNumberAsHexString(255); // 0xFF
	 *			  getNumberAsHexString(0xABCDEF); // 0xABCDEF
	 *			  getNumberAsHexString(0x00FFCC); // 0xFFCC
	 *			  getNumberAsHexString(0x00FFCC, 6); // 0x00FFCC
	 * 
	 * 
	 * @param number The number to convert to hex. Note, numbers larger than 0xFFFFFFFF may produce unexpected results.
	 * @param minimumLength The smallest number of hexits to include in the output. 
	 *					  Missing places will be filled in with 0's. 
	 *					  e.g. getNumberAsHexString(0xFF33, 6); // results in "0x00FF33"
	 * @return String representation of the number as a string starting with "0x" 
	 */
	public function asHexString(number:uint, minimumLength:uint = 1):String 
	{
		// A hexit is the base-16 equivelant of a digit. 
		var hexit:uint = 0;
		// The string that will be output at the end of the function.
		var string:String = "";
		
		// otherwise, loop through all hexits in the number
		while (number > 0 || minimumLength > 0) 
		{
			minimumLength--;
			
			// get the first hexit from the number by masking the rest
			hexit = number & 0xF;
			// convert the digits over 9 into letters
			switch(hexit) 
			{
					case 0xA: string = "A" + string; break;
					case 0xB: string = "B" + string; break;
					case 0xC: string = "C" + string; break;
					case 0xD: string = "D" + string; break;
					case 0xE: string = "E" + string; break;
					case 0xF: string = "F" + string; break;
					default: string = hexit.toString() + string;
			}
			// erase the hexit from the original number
			number >>>= 4;
		}
		
		return "0x" + string;
	}}