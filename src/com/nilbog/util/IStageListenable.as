package com.nilbog.util 
{
	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * @author jmhnilbog
	 */
	public interface IStageListenable extends IDestroyable
	{
		function get stage() :Stage;
		function onAddedToStage( event:Event ) :void;
		function onRemovedFromStage( event:Event ) :void;
		
		// wish I could extend IEventDispatcher as well
		function addEventListener( type:String, listener:Function, useCapture:Boolean = false, priority:int = 0, useWeakReference:Boolean = false ) :void;
		function removeEventListener( type:String, listener:Function, useCapture:Boolean = false) :void;
	}
}
