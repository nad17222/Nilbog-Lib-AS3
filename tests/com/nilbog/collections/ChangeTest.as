package com.nilbog.collections
{
	import asunit.framework.TestCase;		import com.nilbog.collections.List;	import com.nilbog.collections.events.CollectionEvent;	
	/**
	 * @author mark hawley
	 */
	public class ChangeTest extends TestCase 
	{
		private var list:List;
		private var changes:uint = 0;
		
		public function ChangeTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		override public function run() :void
		{
			list = new List();
			list.addEventListener(CollectionEvent.CHANGED, onListChanged);
			list.add("A");
			list.add("B");
			list.add("C");
			
			super.run();
		}
		
		private function onListChanged( event:CollectionEvent ) :void
		{
			log.info("onListChanged(%s)", arguments);
			
			changes++;
		}
		
		public function testChangesHeard() :void
		{
			assertTrue("3 changes heard.", changes == 3);
		}
	}
}
