package com.nilbog.rules 
{

	import com.nilbog.rules.Car;
	import com.nilbog.rules.Rule;
	import com.nilbog.rules.RulesEngine;
	/**
	 * @author Mark Hawley
	 */
	public class Example 
	{
		private var engine:RulesEngine;
		
		public function Example()
		{
			/**
			 * var rule:Rule = new Rule( 
			 */	
			
			
			
			var conditions:Array = [];
			
			var driverYoungAndTall:Function = function (d:Driver) :Boolean
			{
				return d.age < 25 && d.height > 50;
			};
			conditions.push( new Condition( "D", Driver, driverYoungAndTall ) );
			
			var carRed:Function = function (c:Car) :Boolean
			{
				return c.color == 0xff0000;
			};
			conditions.push( new Condition( "C", Car, carRed ) );
			
			conditions.push( new Condition( "P", Policy ) );
			
			var rule:Rule = new Rule( conditions, function ( o:Object ) :void { trace("rule true. P:" + o["P"]); });
			
			engine = new RulesEngine(new BasicMatchingStrategy());
			engine.addRule(rule);
			
			engine.assert( new Driver( 50 ) );
			engine.assert( new Car() );
			engine.assert( new Policy() );
			
			engine.match();
		}
	}
}
