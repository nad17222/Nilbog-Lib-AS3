package com.nilbog.log.view 
{
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.model.LogEvent;
	import com.nilbog.log.view.LogView;

	/**
	 * @author jmhnilbog
	 */
	public class TraceLogView extends LogView 
	{
		public function TraceLogView(level:LogLevel=null)
		{
			super( null, null );
			
			if (null != level)
			{
				_minimumLevel = level;
			}
		}
		
		/**
         * Simplest log method, calling trace().
         * 
         * @param	message	LogMessage
         */
        override public function onMessage( event:LogEvent ):void
        {
			if (event.message.level >= minimumLevel)
            {
                trace( event.message );
            }
        }
	}
}
