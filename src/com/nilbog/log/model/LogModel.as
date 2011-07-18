package com.nilbog.log.model 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.Log;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.view.LogMessage;
	import com.nilbog.mvc.AbstractModel;

	import flash.utils.Dictionary;
	import flash.utils.describeType;

	/**
	 * The log model. Handles the dictionary of log instances, and allows
	 * the submission of messages.
	 * 
	 * @author jmhnilbog
	 */
	public class LogModel extends AbstractModel 
	{
		private static const logs:Dictionary = new Dictionary(true);
	
		/**
		 * Constructor.
		 */	
		public function LogModel()
		{
			super();
		}
		
		/**
         * Log accessor.
         * 
         * @param	logID		Object, the ID of a Log instance. If
         * 						the name has been encountered before, that
         * 						Log instance is returned. Otherwise, a new
         * 						Log with that name is created and returned.
         * 						(optional, deaults to '[ ? ]'
         * @param	logLevel	LogLevel, the default logging level of the Log
         * 						(optional, defaults to TRACE)
         */
        public function getLog( logID:Object, logLevel:LogLevel = null ):ILog
        {	
            var logName:String;
			
            if (logID is String)
            {
                logName = logID as String;
            }
            else
            {
                var d:XML = describeType( logID );
                logName = d.@name.toString( );
            }
			
            if (null == logLevel)
            {
                logLevel = LogLevel.TRACE;
            }
			
            var log:ILog = logs[ logName ];
			
            // make a new Log if we never saw this name before
            if (log == null)
            {
                logs[ logName ] = new Log( this, logName, logLevel );
                log = logs[ logName ];
            }
            return log;
        }
        
        /**
         * Submits a message. This should probably be in the LogController..,
         * but it doesn't seem important at this point to move it.
         * 
         * @param	msg	LogMessage
         */
        public function submitMessage( msg:LogMessage ) :void
		{
			var event:LogEvent = new LogEvent(LogEvent.MESSAGE, msg);
			dispatchEvent(event);
		}
	}
}
