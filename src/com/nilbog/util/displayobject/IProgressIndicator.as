package com.nilbog.util.displayobject 
{

	/**
	 * @author jmhnilbog
	 */
	public interface IProgressIndicator 
	{
		function setProgress( current:Number, max:Number, message:String="" ) :void;
	}
}
