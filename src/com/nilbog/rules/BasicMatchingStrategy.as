package com.nilbog.rules 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.rules.IPatternMatchingStrategy;

	/**
	 * @author Mark Hawley
     * 
     * Naive rules engine pattern matching strategy.
     */
    public class BasicMatchingStrategy implements IPatternMatchingStrategy 
    {
    	private var log:ILog;
    	
        private var facts:Array;

        /**
         * Constructor.
         */
        public function BasicMatchingStrategy() 
        {
        	log = getLog(this, LogLevel.INFO);
        	log.trace("%s(%s)", "BasicMatchingStrategy", arguments.join(", "));
        	
            facts = [];
        }

        /**
         * Adds a 'fact'. A fact can be any kind of object.
         * 
         * @param	fact	*
         */
        public function addFact( fact:* ):void
        {
        	log.trace("%s(%s)", "addFact", arguments.join(", "));
        	
            facts.push( fact );
        }

        /**
         * Removes a 'fact'. A fact can be any kind of object. If the fact
         * is not present in the rules engine, nothing happens.
         * 
         * @param	fact	*
         */
        public function removeFact( fact:* ):void
        {
        	log.trace("%s(%s)", "removeFact", arguments.join(", "));
        	
            facts = facts.filter( function (item:*, index:int, array:Array) :Boolean
            {
                return item != fact;
            }, this );
        }

        /**
         * Takes a list of Rules and performs the result function for each passing
         * rule condition.
         * 
         * @param	rules	Array of Rules
         */
        public function match( rules:Array ):void
        {
        	log.trace("%s(%s)", "match", arguments.join(", "));
        	
            // evaluate all rules in turn
            rules.forEach( function (rule:Rule, index:int, array:Array ) :void
            {
                rule.evaluate( facts );	
            }, null );
        }
    }
}
