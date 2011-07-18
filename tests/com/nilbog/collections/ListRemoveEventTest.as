package com.nilbog.collections
{
	import asunit.framework.TestCase;
	
	import com.nilbog.collections.events.CollectionEvent;		

	/**
	 * @author mark hawley
	 */
	public class ListRemoveEventTest extends TestCase 
	{
		private var event:CollectionEvent;
		
		public function ListRemoveEventTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testInstantiation() :void
		{
			var list:List = new List();
			
			assertTrue("List instantiated.", list is List);
		}
		
		override public function run() :void
		{
			var list:List = new List();
			list.addEventListener(CollectionEvent.REMOVE, onRemove);
			list.add( "1" );
			list.add( "2" );
			list.remove( "1" );
			list.removeEventListener(CollectionEvent.REMOVE, onRemove);
		}
		
		private function onRemove(event:CollectionEvent) :void
		{
			this.event = event;
			super.run();
		}
		
		public function testRemove() :void
		{
			assertNotNull("Remove event heard.", event);
			assertTrue("List removed from.", event.type == CollectionEvent.REMOVE);			assertTrue("Correct item removed.", event.items[0] == "1");
			assertTrue("List correct size.", (event.target as List).size() == 1);
		}
	}
}
