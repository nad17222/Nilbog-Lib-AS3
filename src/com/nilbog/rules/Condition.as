package com.nilbog.rules 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;

	/**
	 * @author Mark Hawley
     * 
     * A Condition for the rules engine.
     */
    public class Condition 
    {
        public var ID:String;
        
        private var factType:Class;
        private var factCheck:Function;

		private var log:ILog;
		
        /**
         * Constructor.
         * 
         * @param	ID	String, a key that can be used in the right-hand-side of
         * 				a Rule containing this Condition in order to refer to
         * 				the object satisfying this Condition. Generally a one-letter
         * 				String.
         * @param 	type	Class, the class of object required for this Condition.
         * @param	check	Function, optional. A function that takes an argument
         * 					of type 'type' (the previous argument) and returns
         * 					a Boolean.
         */		
        public function Condition( ID:String, type:Class, check:Function = null )
        {
        	log = getLog(this, LogLevel.INFO);
        	log.trace("%s(%s)", "Condition", arguments.join(", "));
        	
            this.ID = ID;
            this.factType = type;
            this.factCheck = check;
        }

        /**
         * Checks this Condition against a fact. If the fact satisfies the factCheck
         * function, returns true. Returns false otherwise.
         * 
         * @param	fact	Object, any object.
         * 
         * @return 	Boolean. True if the fact satisfies the factCheck function,
         * 					 or false.
         */
        public function evaluate( fact:Object ):Boolean
        {
        	log.trace("%s(%s)", "evaluate", arguments.join(", "));
        	
            try
            {
                if (fact is factType && (factCheck == null || factCheck( fact )))
                {
                    return true;
                }
            }
			catch( e:Error )
            {
                // log errors
                trace( "Error: " + e );
            }
            return false;
        }
    }
}
