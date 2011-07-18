package com.nilbog.collections 
{
	import asunit.framework.TestSuite;					
	/**
	 * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new ChangeTest());			addTest(new ChangeWhileIteratingTest());			addTest(new ListRandomTest());
			addTest(new ListOrderedTest());
			addTest(new ListIteratorOrderedTest());
			addTest(new BagTest());			addTest(new ListChangedEventTest());			addTest(new ListAddEventTest());			addTest(new ListRemoveEventTest());			addTest(new SetTest());
			addTest(new OrderedSetTest());
		}
	}
}
