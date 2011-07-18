package com.nilbog.experiments.box2d.tests.views 
{
	import com.nilbog.physics.models.PhysicsModel;
	import com.nilbog.physics.views.PhysicsView;
	import com.nilbog.util.FPSCounter;

	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;

	/**
	 * @author jmhnilbog
	 */
	public class UIView extends PhysicsView 
	{
		private const fps:FPSCounter = new FPSCounter();
		private const about:TextField = new TextField();
		private const instructions:TextField = new TextField();
		
		public function UIView(m:PhysicsModel)
		{
			super( m, null );
			
			addChild(fps);
			
			var instructionsTextFormat:TextFormat = new TextFormat( "_typewriter", 16, 0xffffff, false, false, false );
			instructionsTextFormat.align = TextFormatAlign.RIGHT;
			
			instructions.defaultTextFormat = instructionsTextFormat;
			instructions.x = 140;
			instructions.y = 4.5;
			instructions.width = 495;
			instructions.height = 61;
			instructions.text = "Box2DFlashAS3 2.0.1\n'Left'/'Right' arrows to go to previous/next example. \n'R' to reset.";
			instructions.mouseEnabled = false;
			addChild( instructions );
			
			var aboutTextFormat:TextFormat = new TextFormat( "_typewriter", 16, 0x00CCFF, true, false, false );
			aboutTextFormat.align = TextFormatAlign.RIGHT;
			about.defaultTextFormat = aboutTextFormat;
			about.x = 334;
			about.y = 71;
			about.width = 300;
			about.height = 30;
			about.mouseEnabled = false;
			
			addChild(about);
		}
	}
}
