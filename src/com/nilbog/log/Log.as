package com.nilbog.log 
{
	import com.nilbog.log.view.LogMessage;
	import com.nilbog.log.model.LogModel;
	
	
	import com.nilbog.util.string.sprintf;

	/**
	 * @author Mark Hawley
     */
    public class Log implements ILog
    {   
        private var name:String;
        private var filter:LogLevel = LogLevel.INFO;
        private var model:LogModel;

        /**
         * Constructor.
         * 
         * @param	name			The name of this Log.
         * @param	logLevel		LogLevel this Log functions at.
         */
        public function Log( model:LogModel, name:String, logLevel:LogLevel=null )
        {
            this.model = model;
            this.name = name;
            
            if (null != logLevel)
            {
            	filter = logLevel;
            }
        }

        /**
         * Finest level of logging.
         * 
         * @param	message	Object
         */
        public function trace( ... rest ):void
        {
            logMessage( rest, LogLevel.TRACE );
        }

        /**
         * Level of logging suitable for testing.
         * 
         * @param	message	Object
         */
        public function debug( ... rest ):void
        {
            logMessage( rest, LogLevel.DEBUG );
        }

        /**
         * Most-used level of logging.
         * 
         * @param	message	Object
         */
        public function info( ... rest ):void
        {
            logMessage( rest, LogLevel.INFO );
        }

        /**
         * Level of logging used for errors that are recoverable or not
         * that bad in the first place.
         * 
         * @param	message	Object
         */
        public function warn( ... rest):void
        {
            logMessage( rest, LogLevel.WARN );
        }

        /**
         * Level of logging used when a true error is encountered.
         * 
         * @param	message	Object
         */
        public function error( ... rest ):void
        {
            logMessage( rest, LogLevel.ERROR );
        }

        /**
         * Level of logging used when disaster befalls us.
         * 
         * @param	message	Object
         */
        public function fatal( ... rest ):void
        {
            logMessage( rest, LogLevel.FATAL );
        }

        /**
         * Sets the level below which messages should be ignored.
         * 
         * @param	level	LogLevel
         */
        public function set minimumLevel( level:LogLevel ):void
        {
            filter = level;
        }
        public function get minimumLevel() :LogLevel
        {
        	return filter;
        }

        /**
         * Logs a message to each destination this Log has been given.
         * 
         * @param	message Object
         * @param	level	LogLevel
         */
        private function logMessage( args:Array, level:LogLevel ):void
        {
            if ( level < filter )
            {
                return;
            }

            var message:LogMessage = new LogMessage( );
            message.time = new Date( );
            message.level = level;
            message.message = sprintf.apply( null, args );
            message.origin = name;
            
            model.submitMessage(message);
        }
    }
}
