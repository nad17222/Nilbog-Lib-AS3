package com.nilbog.util.email 
{

	{
		public static const SUCCESS:String = "emailSuccess";
		public static const FAILURE:String = "emailFailure";
		
		public var toEmail:String;
		public var fromEmail:String;
		
		/**
		 * Constructor.
		 * 
		 * @param	type	String
		 * @param	toEmail	String
		 * @param 	fromEmail String
		 */
			fromEmail:String=null)
		{
			
			this.toEmail = toEmail;
			this.fromEmail = fromEmail;
		
		/**
		 * Clones the event.
		 * 
		 * @return	Event (an EmailEvent)
		 */
		override public function clone() :Event
		{
			var c:EmailEvent = new EmailEvent( type, toEmail, fromEmail );
			return c;
		}
	}