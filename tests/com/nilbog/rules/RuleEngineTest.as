package com.nilbog.rules 
{
	import asunit.framework.TestCase;	

	/**
	 * @author mark hawley
	 */
	public class RuleEngineTest extends TestCase 
	{
		private var engine:RulesEngine;

		public function RuleEngineTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			engine = new RulesEngine(new BasicMatchingStrategy());
		}
		
		protected override function tearDown() :void
		{
			engine = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("RulesEngine instantiated.", engine is RulesEngine);
		}
		
		public function testSingleFact() :void
		{
			var driverIsLegal:Boolean = false;
			
			engine.addRule
			( 
				new Rule
				(
					[
						// a driver must be present
						new Condition("D", Driver, function (d:Driver) :Boolean
						{
							// and that driver must be 16 or over
							return d.age >= 16;
						})
					],
					// the driver is legal
					function ( o:Object ) :void
					{
						driverIsLegal = true;
						
						var driver:Driver = o["D"] as Driver;
						driver.isLegal = true;
					}
				)
			);
			
			var oldDriver:Driver = new Driver(20);
			var youngDriver:Driver = new Driver(10);
			
			engine.assert(oldDriver);
			engine.match();
			
			assertTrue("OldDriver is a legal driver.", driverIsLegal);
			
			engine.remove(oldDriver);
			driverIsLegal = false;
			
			engine.assert(youngDriver);
			engine.match();
			
			assertTrue("YoungDriver is too young to drive.", !driverIsLegal);
		}
		
		public function testMultipleRules() :void
		{
			// rules:
			// a policy must exist
			var policyCondition:Condition = new Condition( "P", Policy );
			// young drivers are charged 25% more for the same car.
			var youngCondition:Condition = new Condition( "D", Driver, function (d:Driver) :Boolean
			{
				return d.age < 25;
			});
			var youngRule:Rule = new Rule([youngCondition, policyCondition], function (o:Object) :void
			{
				var policy:Policy = o["P"] as Policy;
				policy.increasePremium(1.25);
			});
			// drivers with red cars are charged 15% more for the same car.
			var redCar:Condition = new Condition( "C", Car, function (c:Car) :Boolean
			{
				return c.color == 0xFF0000;
			});
			var redRule:Rule = new Rule([redCar, policyCondition], function (o:Object) :void
			{
				var policy:Policy = o["P"] as Policy;
				policy.increasePremium(1.15);
			});
			
			engine.addRule(youngRule);
			engine.addRule(redRule);
			
			var p:Policy = new Policy();
			var d:Driver = new Driver( 24 );
			var c:Car = new Car( 0xFF0000 );
			
			engine.assert(p);
			engine.assert(d);
			engine.assert(c);
			
			engine.match();
			
			// premium should be 143.75 now, for a young driver and a red car
			
			assertTrue("Policy premimum now 143.75. " + p.premium, p.premium == 143.75);
			
			// change the facts
			p.premium = 100;
			d.age = 50;
			
			engine.match();
			
			// premium should be 115 now, for an experienced driver in a red car
			
			assertTrue("Policy premium now 115.00. " + p.premium, p.premium == 115);
			
			p.premium = 100;
			c.color = 0xcccccc;
			
			engine.match();
			
			// 'silver' car, experienced driver: normal premium
			
			assertTrue("Policy premium now 100.", p.premium == 100);
		}
		
		public function testMultipleFacts() :void
		{
			engine.addRule
			( 
				new Rule
				(
					[
						// a driver must be present
						new Condition("D", Driver, function (d:Driver) :Boolean
						{
							// and that driver must be 16 or over
							return d.age >= 16;
						})
					],
					// the driver is legal
					function ( o:Object ) :void
					{	
						var driver:Driver = o["D"] as Driver;
						driver.isLegal = true;
					}
				)
			);
			
			var oldDriver:Driver = new Driver(20);
			var youngDriver:Driver = new Driver(10);
			
			engine.assert(oldDriver);
			engine.assert(youngDriver);
			engine.match();
			
			// the old driver should be legal, the young one illegal
			
			assertTrue("Old Driver is legal.", oldDriver.isLegal );
			assertFalse("Young Driver is illegal.", youngDriver.isLegal);
		}
	}
}
