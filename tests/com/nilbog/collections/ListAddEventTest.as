﻿package com.nilbog.collections
{
	import asunit.framework.TestCase;
	
	import com.nilbog.collections.events.CollectionEvent;		

	/**
	 * @author mark hawley
	 */
	public class ListAddEventTest extends TestCase 
	{
		private var event:CollectionEvent;
		
		public function ListAddEventTest(testMethod:String = null)
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
			list.addEventListener(CollectionEvent.ADD, onAdd);
			list.add( "1" );
			list.removeEventListener(CollectionEvent.ADD, onAdd);
		}
		
		private function onAdd(event:CollectionEvent) :void
		{
			this.event = event;
			super.run();
		}
		
		public function testAdd() :void
		{
			assertNotNull("Add event heard.", event);
			assertTrue("List added to.", event.type == CollectionEvent.ADD);			assertTrue("Correct item added.", event.items[0] == "1");
		}
	}
}
