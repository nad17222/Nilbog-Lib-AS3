package com.nilbog 
{
	import asunit.framework.TestSuite;

	import com.nilbog.animation.*;
	import com.nilbog.application.*;
	import com.nilbog.assertions.*;
	import com.nilbog.collections.*;
	import com.nilbog.dbc.*;
	import com.nilbog.errors.*;
	import com.nilbog.functional.*;
	import com.nilbog.graph.*;
	import com.nilbog.log.*;
	import com.nilbog.pathfinding.*;
	import com.nilbog.random.*;
	import com.nilbog.rules.*;
	import com.nilbog.tracking.*;
	import com.nilbog.util.*;

	/**
	 * @author mark hawley
	 */
	public class AllTests extends TestSuite 
	{
		public function AllTests()
		{
			super();
			addTest(new com.nilbog.animation.AllTests());
			addTest(new com.nilbog.application.AllTests());			addTest(new com.nilbog.assertions.AllTests());			addTest(new com.nilbog.collections.AllTests());			addTest(new com.nilbog.dbc.AllTests());
			addTest(new com.nilbog.errors.AllTests());			addTest(new com.nilbog.functional.AllTests());
			addTest(new com.nilbog.graph.AllTests());			addTest(new com.nilbog.log.AllTests());
			addTest(new com.nilbog.pathfinding.AllTests());			addTest(new com.nilbog.random.AllTests());
			addTest(new com.nilbog.rules.AllTests());
			addTest(new com.nilbog.tracking.AllTests());
			addTest(new com.nilbog.util.AllTests());
		}
	}
}
