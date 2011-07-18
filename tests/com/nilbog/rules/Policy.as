package com.nilbog.rules 
{

	/**
	 * @author Mark Hawley
	 * 
	 * Example fact class for rule engine tests.
	 */
	public class Policy 
	{
		public var premium:Number = 100;
		
		/**
		 * Modifies the premium by a multiplier.
		 * 
		 * @param	multiplier	Number, defaults to 1.
		 */
		public function increasePremium( multiplier:Number=1 ) :void
		{
			premium *= multiplier;
			
			premium = Math.round(premium * 100)/100;
		}
	}
}
