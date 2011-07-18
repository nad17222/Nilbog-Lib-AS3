package com.nilbog.log.view 
{
	import com.nilbog.errors.AbstractMethodCallError;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.model.LogEvent;
	import com.nilbog.mvc.AbstractView;
	import com.nilbog.mvc.IController;
	import com.nilbog.mvc.IModel;

	/**
	 * @author jmhnilbog
	 */
	public class LogView extends AbstractView implements ILogView
	{
		protected var _minimumLevel:LogLevel = LogLevel.INFO;
		
		public function LogView(m:IModel=null, c:IController = null)
		{
			super( m, c );
		}

        /**
         * Simplest log method, calling trace().
         * 
         * @param	message	LogMessage
         */
        public function onMessage( event:LogEvent ):void
        {
			throw new AbstractMethodCallError();
        }
        
        /**
         * Minimum log level accessor.
         * 
         * @return LogLevel
         */
        public function get minimumLevel() :LogLevel
        {
        	return _minimumLevel;
        }
        /**
         * Minimum log level mutator.
         * 
         * @param v	LogLevel
         */
        public function set minimumLevel(v:LogLevel) :void
        {
        	_minimumLevel = v;
        }
        
        override protected function getExpectedModelEvents() :Array
		{
			var e:Array = [];
			e.push( { name: LogEvent.MESSAGE, func: onMessage } );
			return e;
		}
	}
}
