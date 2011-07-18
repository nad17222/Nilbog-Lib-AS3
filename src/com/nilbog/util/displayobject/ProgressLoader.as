package com.nilbog.util.displayobject 
{
	import com.nilbog.util.geometry.setFromRectangle;
	import com.nilbog.assertions.checkArgument;
	import com.nilbog.util.IDestroyable;

	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;

	/**
	 * @author jmhnilbog
	 */
	public class ProgressLoader extends Sprite implements IDestroyable
	{
		private var errorDisplayObject:DisplayObject;
		private var progressIndicator:IProgressIndicator;
		private var loader:Loader;
		private var dimensions:Rectangle;
		
		public function ProgressLoader( indicator:IProgressIndicator, errorDisplayObject:DisplayObject=null, dimensions:Rectangle=null )
		{
			checkArgument( indicator is DisplayObject );
			
			this.progressIndicator = indicator;
			this.errorDisplayObject = errorDisplayObject;
			this.dimensions = dimensions;
			
			if (null != errorDisplayObject)
			{
				addChild(errorDisplayObject );
				errorDisplayObject.visible = false;
			}
			
			loader = new Loader();
			addChild(loader);
			addChild(progressIndicator as DisplayObject);
			
			visible = false;
			
			if (null != dimensions)
			{
				setFromRectangle( errorDisplayObject, dimensions );
				setFromRectangle( progressIndicator, dimensions );
			}
		}
		
		public function load( urlRequest:URLRequest, dimensions:Rectangle=null ) :void
		{
			if (null != dimensions)
			{
				this.dimensions = dimensions;
			}
			
			visible = true;
			
			errorDisplayObject.visible = false;
			loader.visible = false;
			(progressIndicator as DisplayObject).visible = true;
			
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, onError);
			
			if (null != dimensions)
			{
				setFromRectangle(errorDisplayObject, dimensions);
				setFromRectangle(progressIndicator, dimensions);
				setFromRectangle(loader, dimensions);
			}
			
			loader.load(urlRequest);
		}

		public function unload() :void
		{
			visible = false;
		}

		public function destroy():void
		{
			if (progressIndicator is IDestroyable)
			{
				var pi:IDestroyable = progressIndicator as IDestroyable;
				pi.destroy();
			}
			removeChild( progressIndicator as DisplayObject );
			progressIndicator = null;
			
			loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onComplete);
			loader.contentLoaderInfo.removeEventListener(ProgressEvent.PROGRESS, onProgress);
			loader.contentLoaderInfo.removeEventListener(IOErrorEvent.IO_ERROR, onError);
			loader.unloadAndStop();
			removeChild(loader);
			loader = null;
			
			if (null != errorDisplayObject)
			{
				removeChild( errorDisplayObject );
			}
			errorDisplayObject = null;
			
			dimensions = null;
		}

		public function isDestroyed():Boolean
		{
			return null == loader;
		}
		
		private function onComplete( event:Event ) :void
		{
			visible = true;
			
			errorDisplayObject.visible = false;
			loader.visible = true;
			(progressIndicator as DisplayObject).visible = false;
			
			if (null != dimensions)
			{
				setFromRectangle(errorDisplayObject, dimensions);
				setFromRectangle(progressIndicator, dimensions);
				setFromRectangle(loader, dimensions);
			}
		}
		
		private function onProgress( event:ProgressEvent ) :void
		{
			(progressIndicator as DisplayObject).visible = true;
			
			progressIndicator.setProgress( event.bytesLoaded, event.bytesTotal );
		}
		
		private function onError( event:IOErrorEvent ) :void
		{
			errorDisplayObject.visible = true;
			loader.visible = false;
			(progressIndicator as DisplayObject).visible = false;
			
			if (null != dimensions)
			{
				setFromRectangle(errorDisplayObject, dimensions);
				setFromRectangle(progressIndicator, dimensions);
				setFromRectangle(loader, dimensions);
			}
		}
	}
}
