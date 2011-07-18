package com.nilbog.log.model 
{
	import com.nilbog.log.view.LogMessage;
	import com.nilbog.mvc.ModelEvent;

	/**
	 * A log event. (Currently only 'message', the event saying that a message 
	 * is ready to be logged.
	 * 
	 * @author jmhnilbog
	 */
	public class LogEvent extends ModelEvent 
	{
		public static const MESSAGE:String = "log event: message";
		
		public var message:LogMessage;
		
		/**
		 * Constructor.
		 * 
		 * @param	type	String
		 * @param	message	LogMessage
		 */
		public function LogEvent(type:String, message:LogMessage)
		{
			super( type );
			this.message = message;
		}
	}
}
