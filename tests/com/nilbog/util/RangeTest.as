package com.nilbog.util 
{
	import asunit.framework.TestCase;		

	/**
	 * @author mark hawley
	 */
	public class RangeTest extends TestCase 
	{
		public function RangeTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
		}
		
		protected override function tearDown() :void
		{
		}
		
		public function testStringRange() :void
		{
			var r:Range = new Range( "a", "f" );
			
			var asArray:Array = r.toArray();
			
			assertTrue("5 elements found.", 5 == asArray.length);
			assertTrue(asArray[0] == "a");
			assertTrue(asArray[1] == "b");
			assertTrue(asArray[2] == "c");
			assertTrue(asArray[3] == "d");
			assertTrue(asArray[4] == "e");
		}
		
		public function testStringRangeInclusive() :void
		{
			var r:Range = new Range( "a", "f", Range.INCLUSIVE);
			
			var asArray:Array = r.toArray();
			
			assertTrue("6 elements found.", 6 == asArray.length);
			assertTrue(asArray[0] == "a");
			assertTrue(asArray[1] == "b");
			assertTrue(asArray[2] == "c");
			assertTrue(asArray[3] == "d");
			assertTrue(asArray[4] == "e");
			assertTrue(asArray[5] == "f");
		}
		
		public function testBadStringRanges() :void
		{
			var error:Boolean = false;
			var r:Range;
			try
			{
				r = new Range( "e", "a" );
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("end must be greater than start.", error);
			}
			error = false;
			try
			{
				r = new Range( "A", "A" );
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("start and end may not be equal in exclusive range.", error);
			}
			error = false;
			try
			{
				r = new Range( "0", 5 );
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("Can't mix and match start and end types.", error);
			}
		}
		
		public function testNumberRange() :void
		{
			var r:Range = new Range( 0, 5 );
			
			var asArray:Array = r.toArray();
			
			assertTrue("5 elements found.", 5 == asArray.length);
			assertTrue(asArray[0] == 0);			assertTrue(asArray[1] == 1);			assertTrue(asArray[2] == 2);			assertTrue(asArray[3] == 3);			assertTrue(asArray[4] == 4);
		}
		
		public function testNumberRangeInclusive() :void
		{
			var r:Range = new Range( 0, 5, Range.INCLUSIVE);
			
			var asArray:Array = r.toArray();
			
			assertTrue("6 elements found.", 6 == asArray.length);
			assertTrue(asArray[0] == 0);
			assertTrue(asArray[1] == 1);
			assertTrue(asArray[2] == 2);
			assertTrue(asArray[3] == 3);
			assertTrue(asArray[4] == 4);			assertTrue(asArray[5] == 5);
		}
		
		public function testBadNumberRanges() :void
		{
			var error:Boolean = false;
			var r:Range;
			try
			{
				r = new Range( 0, -1);
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("end must be greater than start.", error);
			}
			error = false;
			try
			{
				r = new Range( 0, 0 );
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("start and end may not be equal in exclusive range.", error);
			}
			error = false;
			try
			{
				r = new Range( 0, "b" );
			}
			catch( e:Error )
			{
				error = true;
			}
			finally
			{
				assertTrue("Can't mix and match start and end types.", error);
			}
		}
	}
}
