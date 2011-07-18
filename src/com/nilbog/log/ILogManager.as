package com.nilbog.log 
{

	/**
	 * @author jmhnilbog
	 */
	public interface ILogManager 
	{
		function addView( v:Object ) :void;
		function removeView( v:Object ) :void;
		
		function getLog( logID:Object, logLevel:LogLevel=null) :ILog;
	}
}
