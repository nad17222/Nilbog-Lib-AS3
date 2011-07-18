package com.nilbog.collections
{
	import asunit.framework.TestCase;
	
	import com.nilbog.collections.IIterator;	
	/**
	 * @author mark hawley
	 */
	public class OrderedSetTest extends TestCase 
	{
		public function OrderedSetTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testInstantiation() :void
		{
			var s:OrderedSet = new OrderedSet();
			var iterator:IIterator = s.getIterator();
			
			assertTrue("List instantiated.", s is OrderedSet);
			assertTrue("Iterator instantiated.", iterator is ArrayOrderedIterator );
		}
		
		public function testSize() :void
		{
			var s:OrderedSet = new OrderedSet();
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
			
			var iterator:IIterator = s.getIterator();
			
			var size:uint = s.size();
			assertTrue("Size is 3.", size == 3);
		}
		
		public function testNumberOrder() :void
		{
			var s:OrderedSet = new OrderedSet();
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
			
			var iterator:IIterator = s.getIterator();
			
			var results:Array = [5, 10, 20];
			while( iterator.hasNext() )
			{
				var expectedResult:Number = results.shift();
				assertTrue("Results as expected.", expectedResult == iterator.next());
			}
			assertTrue("All results found as expected.", results.length == 0);
		}
		
		public function testIComparableOrder() :void
		{
			var s:OrderedSet = new OrderedSet( null, ExampleComparable);
			
			s.add( new ExampleComparable( 100 ));
			s.add( new ExampleComparable( 0 ));
			s.add( new ExampleComparable( 50 ));
			
			trace("SIZE: " + s.size());
			
			var iterator:IIterator = s.getIterator();
			
			var results:Array = [ 0, 50, 100 ];
			while( iterator.hasNext())
			{
				var expectedResult:ExampleComparable = new ExampleComparable( results.shift() as int );
				var next:ExampleComparable = iterator.next();
				trace("NEXT: " + next.valueOf());
				trace("EXPECTED: " + expectedResult.valueOf());
				assertTrue("Results as expected. " + next.valueOf() + "/" + expectedResult.valueOf(), expectedResult.equals( next ));
			}
			assertTrue("All results found as expected.", results.length == 0);
		}
		
		public function testDuplicate() :void
		{
			var s:OrderedSet = new OrderedSet();
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
			
			var error:Boolean = false;
			try
			{
				s.add(20);
			}
			catch( e:Error)
			{
				error = true;	
			}
			finally
			{
				assertFalse("Can't have duplicates in a set.", error);
			}
		}
		
		public function testReset() :void
		{
			var s:OrderedSet = new OrderedSet();
			
			
			s.add( "A" );
			s.add( "C" );
			s.add( "B" );
			
			var iterator:IIterator = s.getIterator();
			
			var results:Array = ["A", "B", "C", "A", "B", "C"];
			while( iterator.hasNext() )
			{
				var expectedResult:String = results.shift();
				assertTrue("Results as expected.", expectedResult == iterator.next());
				
				if (results.length == 3)
				{
					iterator.reset();
				}
			}
			assertTrue("All results found as expected.", results.length == 0);
		}
		
		public function testTypedOrderedSet() :void
		{
			var s:OrderedSet = new OrderedSet( null, String );
			
			s.add( "C" );
			s.add( "A" );
			s.add( "B" );
			
			var error:Boolean = false;
			
			try
			{
				s.add( 42 );
			}
			catch( e:TypeError)
			{
				error = true;
			}
			catch( x:Error)
			{
				// do nothing
			}
			finally
			{
				assertTrue("Couldn't add a number to a set of Strings.", error);
			}
		}
		
		public function testArrayInitializedOrderedSet() :void
		{
			var s:OrderedSet = new OrderedSet( [ "A", "C", "B"], String );
			
			var error:Boolean = false;
			
			try
			{
				s.add( 42 );
			}
			catch( e:TypeError)
			{
				error = true;
			}
			catch( x:Error)
			{
				// do nothing
			}
			finally
			{
				assertTrue("Couldn't add a number to a set of Strings.", error);
				assertTrue("OrderedSet contained 3 objects.", 3 == s.size());
			}
		}
		
		public function testBadlyArrayInitializedOrderedSet() :void
		{
			var s:OrderedSet;
			var error:Boolean = false;
			
			try
			{
				s = new OrderedSet( ["A", 45, {}], String );
			}
			catch( e:TypeError)
			{
				error = true;
			}
			catch( x:Error)
			{
				// do nothing
			}
			finally
			{
				assertTrue("Couldn't add a number to a set of Strings.", error);
				assertTrue("OrderedSet was not created.", s == null);
			}
		}
		
		public function testOrderedSetUnion() :void
		{
			var a:OrderedSet = new OrderedSet([ "A", "B" ,"C" ]);
			var b:OrderedSet = new OrderedSet([ "C", "D", "E" ]);
			
			var s:ISet = a.union(b);
			
			assertTrue("Union has 5 members.", 5 == s.size());
			assertTrue("Contains A.", s.contains("A"));			assertTrue("Contains B.", s.contains("B"));			assertTrue("Contains C.", s.contains("C"));			assertTrue("Contains D.", s.contains("D"));			assertTrue("Contains E.", s.contains("E"));
		}
		
		public function testOrderedSetDifference() :void
		{
			var a:OrderedSet = new OrderedSet([ "A", "B" ,"C" ]);
			var b:OrderedSet = new OrderedSet([ "C", "D", "E" ]);
			
			var s:ISet = a.difference(b);
			
			assertTrue("Difference has 2 members.", 2 == s.size());
			assertTrue("Contains A.", s.contains("A"));
			assertTrue("Contains B.", s.contains("B"));
		}
		
		public function testOrderedSetIntersection() :void
		{
			var a:OrderedSet = new OrderedSet([ "A", "B" ,"C" ]);
			var b:OrderedSet = new OrderedSet([ "C", "D", "E" ]);
			
			var s:ISet = a.intersection(b);
			
			assertTrue("Intersection has 1 member.", 1 == s.size());
			assertTrue("Contains C.", s.contains("C"));
		}
	}
}
