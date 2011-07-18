package com.nilbog.util.fsm 
{
	import flash.events.Event;
	/**
	 * @author jmhnilbog
	 */
	public class StateContext 
	{
		protected var fsm:StateMachine;

	    public function StateContext()
	    {
	        fsm = new StateMachine();
	    }
	
	    public function onChange( event:Event ):void
	    {
	        fsm.onChange( event );
	    }
	
	    public function getStateMachine():StateMachine
	    {
	        return fsm;
	    }		
	}
}
