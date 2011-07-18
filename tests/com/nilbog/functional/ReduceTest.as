package com.nilbog.functional 
{
	import asunit.framework.TestCase;								

	/**
	 * @author mark hawley
	 */
	public class ReduceTest extends TestCase 
	{
		private var char:String = "-";
		
		public function ReduceTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		/**
		 * Tests reduce without an initial value.
		 */
		public function testReduceSimple() :void
		{
			var argList1:Array = [2, 4, 6];
			
			var sum:Function = function( n1:Number, n2:Number ) :Number
			{
				return n1 + n2;
			};
			var result:Number = reduce( sum, argList1 ) as Number;
			
			assertTrue("Reduce found the correct result.", result == 12);
		}
		
		/**
		 * Tests reduce without an initial value.
		 */
		public function testReduceThisObj() :void
		{
			var argList1:Array = [2, 4, 6];
			
			var concatenate:Function = function( n1:Object, n2:Object ) :String
			{
				return n1.toString() + n2.toString() + this.char;
			};
			var result:* = reduce(this, concatenate, argList1 );
			
			assertTrue("Reduce found the correct result with thisObj " + result, result == "24-6-");
		}
		
		/**
		 * Tests reduce with an initial value.
		 */
		public function testReduceWithInitialValue() :void
		{
			var argList1:Array = [2, 4, 6];
			
			var sum:Function = function( n1:Number, n2:Number ) :Number
			{
				return n1 + n2;
			};
			var result:Number = reduce( sum, argList1, 10 ) as Number;
			
			assertTrue("Reduce found the correct result.", result == 22);
		}
		
		/**
		 * Tests reduce with an initial value, but no parameters.
		 */
		public function testReduceWithOnlyInitialValue() :void
		{
			var sum:Function = function( n1:Number, n2:Number ) :Number
			{
				return n1 + n2;
			};
			var result:Number = reduce( sum, null, 10 ) as Number;
			
			assertTrue("Reduce found the correct result.", result == 10);
		}
	}
}
