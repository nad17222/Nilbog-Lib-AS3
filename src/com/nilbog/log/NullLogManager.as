package com.nilbog.log 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.mvc.IView;

	/**
	 * @author jmhnilbog
	 */
	public class NullLogManager implements ILogManager 
	{
		private static const NULL_LOG:ILog = new NullLog();
		
		public function addView(v:Object):void
		{
			// do nothing
		}
		
		public function removeView(v:Object):void
		{
			// do nothing
		}
		
		public function getLog(logID:Object, logLevel:LogLevel = null):ILog
		{
			return NULL_LOG;
		}
	}
}
