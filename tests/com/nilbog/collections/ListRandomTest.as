package com.nilbog.collections
{
	import com.nilbog.collections.ListIterationType;
	import com.nilbog.collections.List;
	import com.nilbog.collections.IIterator;
	import com.nilbog.collections.ArrayRandomIterator;
	import asunit.framework.TestCase;		
	/**
	 * @author mark hawley
	 */
	public class ListRandomTest extends TestCase 
	{
		private var instance:List;
		private var iterator:IIterator;
		
		public function ListRandomTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
			instance = new List();
			instance.add(1);
			instance.add(2);
			iterator = instance.getIterator( ListIterationType.RANDOM );
		}

		protected override function tearDown() :void
		{
			iterator = null;
			instance = null;
		}
		
		public function testInstantiation() :void
		{
			assertTrue("List instantiated.", instance is List);
			assertTrue("Iterator instantiated.", iterator is ArrayRandomIterator );
		}
		
		public function testOrder() :void
		{
			var size:uint = instance.size();
			
			var count:uint = 0;
			var values:Object = {};
			while ( count < 1000 )
			{
				var v:Object = iterator.next();
				if (values[v] == null)
				{
					values[v] = 0;			
				}
				values[v]++;
				
				trace(values[v]);
				count++;
			}
			
			assertTrue("Always got a new value.", count > size);
			assertTrue("Had correct number of trials.", values[1] + values[2] == count);
		}
	}
}
