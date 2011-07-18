package com.nilbog.log.view 
{
	import com.blitzagency.xray.logger.XrayLogger;
	import com.nilbog.log.LogLevel;
	
	import com.nilbog.log.model.LogEvent;
	import com.nilbog.log.view.ILogView;
	import com.nilbog.log.view.LogView;
	import com.nilbog.mvc.IController;
	import com.nilbog.mvc.IModel;

	/**
	 * @author jmhnilbog
	 */
	public class XRayLogView extends LogView implements ILogView 
	{
		private const xRayLogger:XrayLogger = XrayLogger.getInstance();
		
		public function XRayLogView(level:LogLevel=null)
		{
			super( null, null );
			
			if (null != level)
			{
				_minimumLevel = level;
			}
		}

		override public function onMessage( event:LogEvent  ):void 
        {
            if ( event.message.level < minimumLevel )
            {
                return;
            }
			
            var level:Number;
			
            switch( event.message.level )
            {
                case LogLevel.TRACE:
					// fall through - no TRACE in XRAY
                case LogLevel.DEBUG:
                    level = XrayLogger.DEBUG;
                    break;
                case LogLevel.INFO:
                    level = XrayLogger.INFO;
                    break;
                case LogLevel.WARN:
                    level = XrayLogger.WARN;
                    break;
                case LogLevel.ERROR:
                    level = XrayLogger.ERROR;
                    break;
                case LogLevel.FATAL:
                    level = XrayLogger.FATAL;
                    break;
            }
			
            // uses the short format: no time stamps		
            xRayLogger.log( event.message.toString( LogMessageFormat.SHORT ), "", "", level );
        }
	}
}
