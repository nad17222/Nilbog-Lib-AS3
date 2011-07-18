package com.nilbog.util.fsm 
{
	import flash.events.Event;
	/**
	 * @author jmhnilbog
	 */
	public interface IState 
	{
		function enter():void;
    	function exit():void;
    	function onChange( event:Event ):void;
	}
}
