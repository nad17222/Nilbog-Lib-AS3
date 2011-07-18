package com.nilbog.functional 
{
	import asunit.framework.TestCase;				

	/**
	 * @author mark hawley
	 */
	public class MapTest extends TestCase 
	{
		public const BLARG:String = "BLARG";
		
		public function MapTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testMapSimple() :void
		{
			var argList1:Array = [0, 1, 2];
		
			var double:Function = function (number:Number) :Number
			{
				return number * 2;
			};
			var results:Array = map( double, argList1 );
			
			var didDouble:Boolean = true;
			for (var i:Number = 0; i < argList1.length; i++)
			{
				trace(results[i] + " - " + (argList1[i] * 2));
				if (results[i] != (argList1[i] * 2)) 
				{
					didDouble = false;
				}
			}
			assertTrue("Map doubled its arguments.", didDouble);
		}
		
		/**
		 * Tests a more complex, 2 parameter map.
		 */
		public function testMapComplex() :void
		{
			var argList1:Array = [0, 1, 2];
			var argList2:Array = [2, 4, 6];
			
			var multiply:Function = function (n1:Number, n2:Number) :Number
			{
				return n1 * n2;
			};
			var results:Array = map( multiply, argList1, argList2 );
			
			var didMultiply:Boolean = true;
			for (var i:Number = 0; i < argList1.length; i++)
			{
				if (results[i] != (argList1[i] * argList2[i]))
				{
					didMultiply = false;
				}
			}
			assertTrue("Map multiplied its matching arguments.", didMultiply);
		}
		
		public function testMapThisObj() :void
		{
			var argList1:Array = [0, 1, 2];
			
			var double:Function = function (number:Number) :Number
			{
				return number * 2;
			};
			var results:Array = map( this, double, argList1 );
			
			var didDouble:Boolean = true;
			var i:Number;
			for (i = 0; i < argList1.length; i++)
			{
				if (results[i] != (argList1[i] * 2)) 
				{
					didDouble = false;
				}
			}
			assertTrue("Map doubled its arguments when passed a thisObject", didDouble);
			
			results = map( this, function (number:Number) :String
			{
				return (number * 2 + BLARG).toString();
			}, argList1 );
			
			didDouble = true;
			for (i = 0; i < argList1.length; i++)
			{
				if (results[i] != (argList1[i] * 2) + this.BLARG) 
				{
					didDouble = false;
				}
			}
			assertTrue("Map doubled its arguments when passed a thisObject and could reference the thisObject.", didDouble);
		}
		
		public function testBadMapCall() :void
		{
			var thrown:Boolean = false;
			
			try
			{
				map( this, "BAD");
			}
			catch( e:Error )
			{
				thrown = true;
			}
			
			assertTrue("Nope, can't call map like that.", thrown);
		}
	}
}
