package com.nilbog.collections
{
	import asunit.framework.TestCase;		import com.nilbog.collections.IIterator;		/**
	 * @author mark hawley
	 */
	public class SetTest extends TestCase 
	{
		public function SetTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testInstantiation() :void
		{
			var s:Set = new Set();
			var iterator:IIterator = s.getIterator();
			
			assertTrue("List instantiated.", s is Set);
			assertTrue("Iterator instantiated.", iterator is ArrayOrderedIterator );
		}
		
		public function testSize() :void
		{
			var s:Set = new Set();
			
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
			
			var iterator:IIterator = s.getIterator();
			
			assertTrue("Size is 3.", s.size() == 3);
		}
		
		public function testOrder() :void
		{
			var s:Set = new Set();
			
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
			
			var iterator:IIterator = s.getIterator();
			
			var results:Array = [10, 5, 20];
			while( iterator.hasNext() )
			{
				var expectedResult:String = results.shift();
				assertTrue("Results as expected.", expectedResult == iterator.next());
			}
			assertTrue("All results found as expected.", results.length == 0);
		}
		
		public function testDuplicate() :void
		{
			var s:Set = new Set();
			
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
		
		public function testRemove() :void
		{
			var s:Set = new Set();
			
			s.add( 10 );
			s.add( 5 );
			s.add( 20 );
		
			assertTrue( "Added 3 items.", 3 == s.size());
			
			var removed:Boolean = s.remove( 10 );
			
			assertTrue( "Removed '10'.", !s.contains(10) && removed);
			assertTrue( "Size is now 2.", 2 == s.size());
			
			removed = s.remove( 'x' );
			
			assertTrue("Can't remove things not in a set.", !removed);
		}
		
		public function testReset() :void
		{
			var s:Set = new Set();
			
			
			s.add( "A" );
			s.add( "B" );
			s.add( "C" );
			
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
		
		public function testTypedSet() :void
		{
			var s:Set = new Set( null, String );
			
			s.add( "A" );
			s.add( "B" );
			s.add( "C" );
			
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
		
		public function testArrayInitializedSet() :void
		{
			var s:Set = new Set( [ "A", "B", "C"], String );
			
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
				assertTrue("Set contained 3 objects.", 3 == s.size());
			}
		}
		
		public function testBadlyArrayInitializedSet() :void
		{
			var s:Set;
			var error:Boolean = false;
			
			try
			{
				s = new Set( ["A", 45, {}], String );
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
				assertTrue("Set was not created.", s == null);
			}
		}
		
		public function testSetUnion() :void
		{
			var a:Set = new Set([ "A", "B" ,"C" ]);
			var b:Set = new Set([ "C", "D", "E" ]);
			
			var s:ISet = a.union(b);
			
			assertTrue("Union has 5 members.", 5 == s.size());
			assertTrue("Contains A.", s.contains("A"));			assertTrue("Contains B.", s.contains("B"));			assertTrue("Contains C.", s.contains("C"));			assertTrue("Contains D.", s.contains("D"));			assertTrue("Contains E.", s.contains("E"));
		}
		
		public function testSetDifference() :void
		{
			var a:Set = new Set([ "A", "B" ,"C" ]);
			var b:Set = new Set([ "C", "D", "E" ]);
			
			var s:ISet = a.difference(b);
			
			assertTrue("Difference has 2 members.", 2 == s.size());
			assertTrue("Contains A.", s.contains("A"));
			assertTrue("Contains B.", s.contains("B"));
		}
		
		public function testSetIntersection() :void
		{
			var a:Set = new Set([ "A", "B" ,"C" ]);
			var b:Set = new Set([ "C", "D", "E" ]);
			
			var s:ISet = a.intersection(b);
			
			assertTrue("Intersection has 1 member.", 1 == s.size());
			assertTrue("Contains C.", s.contains("C"));
		}
	}
}
