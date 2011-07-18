package com.nilbog.log 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;

	/**
	 * @author jmhnilbog
	 */
	public class NullLog implements ILog 
	{
		public function trace(...rest:*):void
		{
			// do nothing
		}
		
		public function debug(...rest:*):void
		{
			// do nothing
		}
		
		public function info(...rest:*):void
		{
			// do nothing
		}
		
		public function warn(...rest:*):void
		{
			// do nothing
		}
		
		public function error(...rest:*):void
		{
			// do nothing
		}
		
		public function fatal(...rest:*):void
		{
			// do nothing
		}
		
		public function set minimumLevel(logLevel:LogLevel):void
		{
			// do nothing
		}
		public function get minimumLevel() :LogLevel
		{
			return LogLevel.OFF;
		}
	}
}
