package com.nilbog.collections
{
	import asunit.framework.TestCase;		import com.nilbog.collections.IIterator;	import com.nilbog.collections.List;	
	/**
	 * @author mark hawley
	 */
	public class ListOrderedTest extends TestCase 
	{
		private var list:List;
		private var iterator:IIterator;
		
		public function ListOrderedTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			list = new List();
			list.add("A");
			list.add("B");
			list.add("C");
			iterator = list.getIterator();
		}

		protected override function tearDown() :void
		{
			iterator = null;
			list = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("List instantiated.", list is List);
			assertTrue("Iterator instantiated.", iterator is ArrayOrderedIterator );
		}
		
		public function testSize() :void
		{
			var size:uint = list.size();
			assertTrue("Size is 3.", size == 3);
		}
		
		public function testOrder() :void
		{
			var results:Array = ["A", "B", "C"];
			while( iterator.hasNext() )
			{
				var expectedResult:String = results.shift();
				assertTrue("Results as expected.", expectedResult == iterator.next());
			}
			assertTrue("All results found as expected.", results.length == 0);
		}
		
		public function testReset() :void
		{
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
	}
}
