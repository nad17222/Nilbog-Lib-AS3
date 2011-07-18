package com.nilbog.mvc 
{
	import flash.display.Stage;
	import flash.events.IEventDispatcher;

	/**
	 * @author jmhnilbog
	 */
	public interface IView extends IEventDispatcher
	{
		function setModel(m:IModel):void;
		function getModel():IModel;
	
		function setController(c:IController):void;
		function getController():IController;
	
		function defaultController(model:IModel):IController;
		
		function get stage() :Stage;
		
		// wish I could extend IDestroyable as well
		function destroy() :void;
		function isDestroyed() :Boolean;
	}
}
