package com.nilbog.collections
{
	import asunit.framework.TestCase;
	
	import com.nilbog.collections.events.CollectionEvent;	

	/**
	 * @author mark hawley
	 */
	public class ListChangedEventTest extends TestCase 
	{
		private var event:CollectionEvent;
		
		public function ListChangedEventTest(testMethod:String = null)
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
			list.addEventListener(CollectionEvent.CHANGED, onChanged);
			list.add( "1" );
			list.removeEventListener(CollectionEvent.CHANGED, onChanged);
		}
		
		private function onChanged(event:CollectionEvent) :void
		{
			this.event = event;
			super.run();
		}
		
		public function testChanged() :void
		{
			assertNotNull("Change event heard.", event);
			assertTrue("List changed.", event.type == CollectionEvent.CHANGED);
		}
	}
}
