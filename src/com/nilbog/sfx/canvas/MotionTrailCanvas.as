package com.nilbog.sfx.canvas 
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.filters.BitmapFilter;
	import flash.filters.BlurFilter;
	import flash.filters.ColorMatrixFilter;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * @author jmhnilbog
	 */
	public class MotionTrailCanvas extends Canvas
	{
		private static const DEFAULT_BLUR_FILTER:BlurFilter = new BlurFilter( 2, 2, 2);
		private static const DEFAULT_COLOR_MATRIX_FILTER:ColorMatrixFilter = new ColorMatrixFilter( [ 1,0,0,0,0,0,1,0,0,0,0,0,1,0,0,0,0,0,0.9,0 ] );
		
		private var bmpData:BitmapData;
		private var bitmap:Bitmap;
		
		private var virtualCanvas:DisplayObject;
		private var iterativeFilters:Array;
		
		public function MotionTrailCanvas( virtualCanvas:DisplayObject, filterList:Array=null )
		{
			super();
			
			if (filterList == null)
			{
				//filterList = [ DEFAULT_BLUR_FILTER, DEFAULT_COLOR_MATRIX_FILTER ];
				filterList = [ DEFAULT_COLOR_MATRIX_FILTER ];
			}
			
			iterativeFilters = filterList;
			this.virtualCanvas = virtualCanvas;
			
			bmpData = new BitmapData( virtualCanvas.width, virtualCanvas.height, true, 0x00000000 );
			bitmap = new Bitmap(bmpData);
			
			addChild(bitmap);
		}

		override public function updateCanvas() :void
		{
			bmpData.draw(virtualCanvas);
			
			var p:Point = new Point();
			var r:Rectangle = bmpData.rect;
			for each (var filter:BitmapFilter in iterativeFilters) 
			{
				bmpData.applyFilter(bmpData, r, p, filter);
			}
		}
	}
}
