package com.nilbog.layout 
{
	import com.nilbog.util.displayobject.Alignment;
	import flash.display.Sprite;
	import flash.events.MouseEvent;

	/**
	 * @author jmhnilbog
	 */
	public class LayoutTest extends Sprite 
	{
		private var boxes:Array = [];
		
		public function LayoutTest()
		{
			boxes.push( new Box( new VerticalLayoutStrategy(0, Alignment.LEFT)));
			boxes.push( new Box( new VerticalLayoutStrategy(0, Alignment.CENTER)));
			boxes.push( new Box( new VerticalLayoutStrategy(0, Alignment.RIGHT))); 
		
			for (var i:uint = 0; i < boxes.length; i++)
			{
				var box:Box = boxes[i];
				box.x = 200 * i;
				addChild(box);
				box.graphics.lineStyle(1, 0x000000);
				box.graphics.lineTo( 0, 5 );
				box.graphics.moveTo( 0, 0 );
				box.graphics.lineTo( 5, 0 );
			}
			
			stage.addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(event:MouseEvent) :void
		{
			for each (var box:Box in boxes)
			{
				var s:Sprite = new Sprite();
				s.graphics.beginFill(0xff0000);
				s.graphics.drawRect(0, 0, Math.random() * 50 + 5, Math.random() * 50 + 5);
				s.graphics.endFill();
				
				box.addChild(s);
			}
		}
	}
}
