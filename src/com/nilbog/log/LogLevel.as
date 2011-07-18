package com.nilbog.log
{

	/**
	 * LogLevel enum used by Logger. Can be used as a String as well as a 
	 * Number thanks to toString() and valueOf() shenanigans.
	 * 
	 * @author hawleym
	 */
	
	public class LogLevel
	{
		private static var initialized:Boolean = false;
		
		public static const FATAL:LogLevel = new LogLevel( 10, "FATAL" );
		public static const ERROR:LogLevel = new LogLevel( 9, "ERROR" );
		public static const WARN:LogLevel = new LogLevel( 8, "WARN" );
		public static const INFO:LogLevel = new LogLevel( 7, "INFO" );
		public static const DEBUG:LogLevel = new LogLevel( 6, "DEBUG" );
		public static const TRACE:LogLevel = new LogLevel( 5, "TRACE" );
		
		// when off, even the highest priority messages are ignored, hence the
		// infinite numerical value here (OFF is always > any other LogLevel)
		public static const OFF:LogLevel = new LogLevel(uint.MAX_VALUE, "OFF");
		
		{
			initialized = true;
		}
		
		private var name:String;
		private var value:uint;
		
		/**
		 * Private constructor, as LogLevels are only constructed within this class.
		 * 
		 * @param	value	Number, the numeric value of a LogLevel.
		 */
		public function LogLevel( value:uint, name:String ) 
		{
			if (initialized)
			{
				throw new Error();
			}
			this.name = name;
			this.value = value;
		}
		
		/**
		 * Return name for string value.
		 * 
		 * @return String
		 */
		public function toString() :String
		{
			return name;
		}
		
		/**
		 * Return value for numeric usage.
		 * 
		 * @return Number
		 */
		public function valueOf() :Number
		{
			return value;
		}
	}
}