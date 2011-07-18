package com.nilbog.rules 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;

	/**
	 * @author Mark Hawley
     * 
     * A simple rules engine.
     */
    public class RulesEngine 
    {
        // condition/fact matching
        private var matcher:IPatternMatchingStrategy;
        // list of Rules
        private var rules:Array;
        
        private var log:ILog;

        /**
         * Constructor.
         * 
         * @param	pms	IPatterMatchingStrategy
         */
        public function RulesEngine( pms:IPatternMatchingStrategy )
        {
        	log = getLog(this, LogLevel.INFO);
        	log.trace("%s(%s)", "RulesEngine", arguments.join(", "));
        	
            matcher = pms;
            rules = [];
        }

        /**
         * Adds a fact to the rules engine.
         * 
         * @param	fact	*, any object.
         */
        public function assert( fact:* ):void
        {
        	log.trace("%s(%s)", "assert", arguments.join(", "));
        	
            matcher.addFact( fact );
        }

        /**
         * Runs the rules engine on the current set of facts and rules. Rules
         * which apply to the current state of facts will have their result
         * functions execute.
         */
        public function match():void
        {
        	log.trace("%s(%s)", "match", arguments.join(", "));
        	
            matcher.match( rules );
        }

        /**
         * Removes a fact from the rules engine. Does nothing if the fact is not
         * present in the rules engine.
         * 
         * @param	fact	*, any object.
         */
        public function remove( fact:* ):void
        {
        	log.trace("%s(%s)", "remove", arguments.join(", "));
        	
            matcher.removeFact( fact );
        }

        /**
         * Adds a rule to the rules engine.
         * 
         * @param	rule	Rule
         */		
        public function addRule( rule:Rule ):void
        {
        	log.trace("%s(%s)", "addRule", arguments.join(", "));
        	
            rules.push( rule );
        }

        /**
         * Removes a rule from the rules engine. Does nothing if the rule is not
         * present in the rules engine.
         * 
         * @param	rule	Rule.
         */
        public function removeRule( rule:Rule ):void
        {
        	log.trace("%s(%s)", "removeRule", arguments.join(", "));
        	
            rules = rules.filter( function (item:Rule) :Boolean
            {
                return item != rule;
            }, this );
        }
    }
}
