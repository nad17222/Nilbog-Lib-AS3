package com.nilbog.util.displayobject 
{
	import flash.text.TextFieldAutoSize;
	import flash.display.Sprite;
	import flash.geom.Rectangle;
	import flash.text.TextField;

	/**
	 * @author jmhnilbog
	 */
	public class Grid extends Sprite
	{
		private var bounds:Rectangle = new Rectangle();
		
		private var rect:Rectangle;
		private var scale:Number;
		
		private var tlMarker:TextField = new TextField();
		private var brMarker:TextField = new TextField();
		
		public function Grid( rect:Rectangle, scale:Number )
		{
			this.rect =rect;
			this.scale = scale;	
		
			bounds.x = bounds.y = 0;
			bounds.width = rect.width * scale;
			bounds.height = rect.height * scale;
			
			tlMarker.autoSize = TextFieldAutoSize.LEFT;
			brMarker.autoSize = TextFieldAutoSize.RIGHT;
			
			addChild(tlMarker);
			addChild(brMarker);
			
			update();
		}
		
		public function update() :void
		{
			graphics.clear();
			
			var a:Number = .5;
			var x:Number = 0;
			var y:Number = 0;
			var increment:Number = uint(rect.width) * scale;
			
			trace("scale: " + scale);
			trace("increment: " + increment);
			while( increment >= 5 )
			{ 
				x = 0;
				y = 0;
				graphics.lineStyle(0, 0xAAAAAA, a);
				for (var i:uint=0; i < bounds.width/increment; i++)
				{
					x = increment * i;
					graphics.moveTo( x, 0 );
					graphics.lineTo( x, bounds.height );
				}
				for (i=0; i < bounds.height/increment; i++)
				{
					y = increment * i;
					graphics.moveTo( 0, y );
					graphics.lineTo( bounds.width, y );
				}
					
				increment = increment / 10;	
				a = a * 2/3;
			}
			
			tlMarker.text = "(" + rect.x + ", " + rect.y + ")";
			tlMarker.x = -tlMarker.width;
			tlMarker.y = -tlMarker.height/2;
			
			brMarker.text = "(" + (rect.x + rect.width) + ", " + (rect.y + rect.height) + ")";
			brMarker.x = bounds.width;
			brMarker.y = bounds.height - (brMarker.height/2);
//			
//			
//			var increment:Number = scale / 10;
//			for (var i:uint=0; i < ticksW; i++)
//			{
//				graphics.lineStyle(0, 0x0, 1);
//				var x:Number = scale * i;
//				graphics.moveTo( x, 0 );
//				graphics.lineTo( x, bounds.height );
//				
//				trace("DARK AT: " + x);
//				if (increment > 5)
//				{
//					for (var j:uint=1; j < 10; j++)
//					{
//						x += increment;
//						graphics.lineStyle(0, 0xDDDDDD, .75);
//						trace("LIGHT AT: " + x);
//						graphics.moveTo( x, 0);
//						graphics.lineTo( x, bounds.height);
//					}
//				}
//			}
			
//			graphics.lineStyle(0, 0x0, 1);
//			var ticksH:uint = uint(rect.height);
//			for (i=0; i < ticksH; i++)
//			{
//				var y:Number = scale * i;
//				graphics.moveTo( 0, y );
//				graphics.lineTo( bounds.width, y );
//				
////				if (increment > 5)
////				{
////					for (j=1; j < 10; j++)
////					{
////						graphics.lineStyle(0, 0xDDDDDD, .75);
////						graphics.moveTo( 0, y + (increment * j));
////						graphics.lineTo( bounds.width, y + (increment * j));
////					}
////				}
//			}
			
//			graphics.lineStyle(1, 0xEEEEEE, 1);
//			graphics.drawRect(0, 0, rect.width * scale, rect.height * scale);
		}
	}
}
