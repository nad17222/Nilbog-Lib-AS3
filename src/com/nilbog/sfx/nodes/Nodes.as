package com.nilbog.sfx.nodes 
{
	import com.greensock.TweenMax;
	import com.nilbog.application.Application;
	import com.nilbog.application.ApplicationDescription;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.LogManager;
	import com.nilbog.log.view.XRayLogView;
	import com.nilbog.random.implementations.MersenneTwister;
	import com.nilbog.sfx.nodes.controller.ClickController;
	import com.nilbog.sfx.nodes.model.GraphModel;
	import com.nilbog.sfx.nodes.view.GraphView;

	/**
	 * @author jmhnilbog
	 */
	public class Nodes extends Application
	{
		private var model:GraphModel;
		private var view:GraphView;
		private var clickController:ClickController;
		
		public function Nodes()
		{
			var description:ApplicationDescription = new ApplicationDescription();
			description.animationPackage = TweenMax;
			description.logger = new LogManager
			(
				new XRayLogView(LogLevel.INFO)
			);
			description.RNGImplementation = new MersenneTwister(0);
			super( description );
			
			
		}
		
		override protected function run() :void
		{
			model = new GraphModel();
			
			view = new GraphView(model);
			addChild(view);
			clickController = new ClickController(model, view);
			view.setController(clickController);
			
			view.x = 275;
			view.y = 200;
		}
	}
}
