package com.nilbog.rules 
{

	/**
	 * @author Mark Hawley
	 * 
	 * Example fact class for rules engine testing.
	 */
	public class Driver 
	{
		public var age:Number;
		public var height:Number;
		public var isLegal:Boolean = undefined;
		
		/**
		 * Constructor.
		 * 
		 * @param	age		Number, defaults to 20.
		 * @param 	height	Number, defaults to 100.
		 */
		public function Driver( age:Number=20, height:Number = 100 )
		{
			this.age = age;
			this.height = height;
		}
	}
}
