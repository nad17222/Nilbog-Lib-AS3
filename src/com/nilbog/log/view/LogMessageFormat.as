package com.nilbog.log.view 
{
    import com.nilbog.assertions.fail;    	
    
    /**
     * @author markhawley
	 * 
	 * Collection of static references to various log message formats.
	 */
	internal class LogMessageFormat 
	{
		private static var initialized:Boolean = false;
		
		public static const DEFAULT:LogMessageFormat = new LogMessageFormat("%(level)s %(time)s: %(message)s (%(origin)s)");
		public static const SHORT:LogMessageFormat = new LogMessageFormat("%(level)s: %(message)s (%(origin)s)");
		
		private var format:String;
		
		{
			initialized = true;
		}
		
		/**
		 * Constructor. Only to be instantiated at compile time, currently.
		 * 
		 * @param	s	String
		 */
		public function LogMessageFormat(s:String)
		{
			if (initialized)
			{
				fail("This class is intended to only be instantiated at " +
					"compile time.");
			}
			format = s;
		}
		
		/**
		 * Simple string dump.
		 * 
		 * @return String
		 */
		public function toString() :String
		{
			return format;
		}
	}
}
