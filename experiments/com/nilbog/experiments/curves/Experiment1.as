package com.nilbog.experiments.curves 
{
	import com.nilbog.random.RNG;
	import com.nilbog.random.implementations.MersenneTwister;
	import com.nilbog.sfx.canvas.MotionTrailCanvas;
	import com.nilbog.util.FPSCounter;
	import com.nilbog.util.array.shuffle;
	import com.nilbog.util.displayobject.FrameUpdater;
	import com.nilbog.util.displayobject.UpdateEvent;
	import com.nilbog.util.displayobject.interpolateColors;
	import com.senocular.drawing.Path;

	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.utils.Timer;

	/**
	 * @author jmhnilbog
	 */
	public class Experiment1 extends Sprite
	{
		private static const MAX_POINTS:uint = 2;
		
		private const rng:RNG = new RNG( new MersenneTwister( 1 ));
		private const timer:Timer = new Timer(100);
		
		private const canvas:Sprite = new Sprite();
		
		private var renderer:MotionTrailCanvas;
		
		private var generationPoints:Array = [ new Point(200, 200), new Point(200, 200) ];
		private var paths:Array = [];
		
		private var pathPortion:Number = 0;
		
		public function Experiment1()
		{
			super();
			
			timer.addEventListener(TimerEvent.TIMER, onTimeOut);
			timer.start();
			
			canvas.graphics.lineStyle(1, 0xDDDDDD );
			canvas.graphics.drawRect(0, 0, 399, 399);

			renderer = new MotionTrailCanvas(canvas);
			addChild(renderer);
			
			addChild(new FPSCounter());
			
			FrameUpdater.instance.addEventListener(UpdateEvent.UPDATE, onUpdate);
			
			draw();
		}
		
		private function draw() :void
		{	
			paths = [];
			var curveColor:Number = interpolateColors(0x000000, 0xFFFFFF, rng.random());
			var lineColor:Number = interpolateColors(0x000000, 0xFF0000, rng.random());
			var newPoints:Array = [];
			var rect:Rectangle = new Rectangle(0, 0, 400, 400);
			for each (var p:Point in generationPoints) 
			{
				var times:uint = Math.floor(rng.random() * 0) + 1;
				for (var i:uint = 0; i < times; i++)
				{
					var endPoint:Point = new Point;
					endPoint.x = rng.random() * 400;
					endPoint.y = rng.random() * 400;
					newPoints.push(endPoint);

					var controlPoint:Point = new Point( );
					controlPoint.x = rng.random() * 400;
					controlPoint.y = rng.random() * 400;
					
					var path:Path = new Path();
					path.moveTo( p.x, p.y );
					path.curveTo( controlPoint.x, controlPoint.y, endPoint.x, endPoint.y );
					
					paths.push(path);
					
				}
			}
			
			generationPoints = newPoints;
			shuffle(generationPoints );
			generationPoints.length = MAX_POINTS;
		}

		private function onTimeOut(event:TimerEvent) :void
		{
			pathPortion = 0;
			draw();
			renderer.updateCanvas();
			canvas.graphics.clear();
		}
		
		private function onUpdate( event:UpdateEvent ) :void
		{	
			var t:Number = event.time * 10;
			
			canvas.graphics.lineStyle(5, 0);
			for each (var p:Path in paths) 
			{
				p.draw(canvas.graphics, pathPortion, pathPortion +t);	
			}
			
			pathPortion += t;
			
			renderer.updateCanvas();
			canvas.graphics.clear();
		}
	}
}
