package com.nilbog.util 
{

	/**
	 * @author mark hawley
	 * 
	 * Interface for things that should be cleaned up before 
	 * disposal.
	 */
	public interface IDestroyable 
	{
		function destroy() :void;
		function isDestroyed() :Boolean;
	}
}
