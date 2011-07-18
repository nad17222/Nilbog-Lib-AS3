package com.nilbog.util.string
{
	import com.nilbog.util.number.truncate;
	
	/**
	 * Turns a number into a string padded with the given number
	 * of digits.
	 * 
	 * @param	raw	Number to pad
	 * @param	decimals	int, desired width
	 * 
	 * @return	String
	 */
	public function padFloat(raw:Number, decimals:int = 2):String
	{
	    var num:Number = truncate(raw, decimals);
	    var numStr:String = num.toString();
	    
	    if (numStr.indexOf(".") == -1)
	        numStr += ".0";
	    
	    var buf:Array = [];
	    var i:int;
	    
	    for (i = 0; i < decimals - numStr.substr(numStr.indexOf(".") + 1).length; i++)
	    {
	        buf.push("0");
	    }
	    buf.unshift(numStr);
	    
	    return buf.join("");
	}}