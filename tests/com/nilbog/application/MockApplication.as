package com.nilbog.application 
{
	import com.nilbog.application.Application;

	/**
	 * @author jmhnilbog
	 */
	public class MockApplication extends Application 
	{
		public function MockApplication(description:ApplicationDescription = null)
		{
			super( description );
		}
		
		override protected function run() :void
		{
			log.info("Running mock application.");
		}
	}
}
