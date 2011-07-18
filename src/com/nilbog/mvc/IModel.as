package com.nilbog.mvc 
{
	import flash.events.Event;
	import flash.events.IEventDispatcher;

	/**
	 * @author jmhnilbog
	 */
	public interface IModel extends IEventDispatcher
	{
		// wish I could extend IDestroyable as well
		function destroy() :void;
		function isDestroyed() :Boolean;
	}
}
