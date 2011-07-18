package com.nilbog.mvc 
{
	import flash.events.Event;

	/**
	 * @author jmhnilbog
	 */
	public class ModelEvent extends Event 
	{
		public function get model() :IModel
		{
			return target as IModel;
		}
		
		public function ModelEvent(type:String)
		{
			super( type );
		}
	}
}
