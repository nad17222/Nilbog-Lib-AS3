package com.nilbog.util 
{
	import asunit.framework.TestCase;

	import com.nilbog.util.array.createMultidimensionalArray;
	import com.nilbog.util.array.shuffle;

	/**
	 * @author mark hawley
	 */
	public class ArrayUtilTest extends TestCase 
	{
		public function ArrayUtilTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
		}
		
		protected override function tearDown() :void
		{
		}
		
		public function testOneDMultidimensionalArray() :void
		{
			var oneD:Array = createMultidimensionalArray(10);
			
			assertTrue("1D array is 1-dimensional.", 
				oneD.every( function( item:Object, index:int, array:Array ) :Boolean
				{
					return item == null;
				}));
			assertTrue("1D array is 10 long.", oneD.length == 10);
			assertTrue("1D array is an Array.", oneD is Array);
		}
		
		public function testTwoDMultidimensionalArray() :void
		{
			var twoD:Array = createMultidimensionalArray(10, 5);
			
			assertTrue("2D array is 2-dimensional.", 
				twoD.every( function( item:Object, index:int, array:Array ) :Boolean
				{
					return item is Array;
				}) &&
				twoD.every( function (item:Object, index:int, array:Array ) :Boolean
				{
					return item[0] == undefined;
				}));
			assertTrue("2D array is 10 X 5 long.", twoD.length == 10 && twoD[0].length == 5);
			assertTrue("2D array is an Array.", twoD is Array);
		}
		
		public function testFiveDMultidimensionalArray() :void
		{
			var fiveD:Array = createMultidimensionalArray(10, 5, 3, 2, 1);
			
			assertTrue("5D array is 5-dimensional.", 
				fiveD.every( function( item:Object, index:int, array:Array ) :Boolean
				{
					return item is Array;
				}) &&
				fiveD.every( function (item:Object, index:int, array:Array ) :Boolean
				{
					return item[0] is Array;
				}) &&
				fiveD.every( function (item:Object, index:int, array:Array ) :Boolean
				{
					return item[0][0] is Array;
				}) &&
				fiveD.every( function (item:Object, index:int, array:Array ) :Boolean
				{
					return item[0][0][0] is Array;
				}) &&
				fiveD.every( function (item:Object, index:int, array:Array ) :Boolean
				{
					return item[0][0][0][0] == undefined;
				}));
			assertTrue("5D array is 10 X 5 X 3 X 2 X 1 long.", fiveD.length == 10 && fiveD[0].length == 5 && fiveD[0][0].length == 3 && fiveD[0][0][0].length == 2 && fiveD[0][0][0][0].length == 1);
			assertTrue("5D array is an Array.", fiveD is Array);
		}
		
		public function testShuffle() :void
		{
			var values:String = "0123456789abcdefghijklmnopqrstuvwxyz";
			var a:Array = values.split("");
			
			assertTrue("Array length as expected before shuffle.", a.length == values.length);
			var asExpected:Boolean = true;
			var i:int;
			for (i = 0; i < a.length; i++)
			{
				asExpected = asExpected && (a[i] == values.charAt(i));
			}
			assertTrue("Array starts out in correct order.", asExpected);
			
			// yes, this isn't perfect, but it should work well enough.
			shuffle(a);
			
			var inOrder:Boolean = true;
			for (i = 0; i < a.length; i++)
			{
				inOrder = inOrder && (a[i] == values.charAt(i));
			}
			assertFalse("Array shuffled.", inOrder);
		}
	}
}
