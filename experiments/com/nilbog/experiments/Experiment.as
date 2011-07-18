package com.nilbog.experiments 
{
	import com.greensock.TweenMax;
	import com.nilbog.application.Application;
	import com.nilbog.application.ApplicationDescription;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.LogManager;
	import com.nilbog.log.Logger;
	import com.nilbog.log.view.XRayLogView;
	import com.nilbog.random.implementations.MersenneTwister;

	/**
	 * @author jmhnilbog
	 */
	public class Experiment extends Application 
	{
		public function Experiment(description:ApplicationDescription = null)
		{
			if (null == description)
			{
				description = new ApplicationDescription( );
			}
			if (null == description.animationPackage)
			{
				description.animationPackage = TweenMax;
			}
			if (Logger.logManager == description.logger)
			{
				description.logger = new LogManager( new XRayLogView( LogLevel.TRACE ) );
			}
			if (null == description.RNGImplementation)
			{
				description.RNGImplementation = new MersenneTwister( 0 );
			}
			super( description );
		}

		override protected function run():void
		{
			log.trace( "%s(%s)", "run", arguments.join( ", " ) );
		}
	}
}
