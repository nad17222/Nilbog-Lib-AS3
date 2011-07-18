package com.bryanheisey.vcam 
{
	import com.nilbog.util.IDestroyable;
	import com.nilbog.util.IStageListenable;
	import com.nilbog.util.displayobject.FrameUpdater;
	import com.nilbog.util.displayobject.StagingHandler;
	import com.nilbog.util.displayobject.UpdateEvent;

	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * VCam AS3 v1.01
	 *
	 * VCam based on original code by Sham Bhangal and Dave Dixon
	 *
	 * Dynamic Registration AS3 code based on work by Oscar Trelles, AS2 work by Darron Schall (www.darronschall.com)
	 * and AS1 work by Robert Penner (www.robertpenner.com)
	 *
	 * Special Thanks to Josh Steele and Jeff Brenner
	 *
	 * @author Bryan Heisey
	 * @version 1.01
	 * @created 27-May-2008
	 *
	 * Requirements: Flash CS3+ & Actionscript 3
	 */
	public class VCam extends Sprite implements IStageListenable, IDestroyable
	{
		private var stagingHandler:StagingHandler;
		private var exactStageDimensions:Rectangle;
		private var virtualCameraBounds:Rectangle;
		private var registrationPoint:Point;
		private var viewBitmap:Bitmap;
		private var viewBitmapData:BitmapData;

		public function VCam()
		{
			stagingHandler = new StagingHandler( this );
		}

		private function getExactStageDimensions():Rectangle
		{
			var oldScaleMode:String = stage.scaleMode;
			stage.scaleMode = "exactFit";
			
			var exactStageDimensions:Rectangle = new Rectangle( 0, 0, stage.stageWidth, stage.stageHeight );
			stage.scaleMode = oldScaleMode;
			
			return exactStageDimensions;
		}

		private function getVirtualCameraBounds():Rectangle
		{
			var obj:Object = getBounds( this );
			
			return new Rectangle( 0, 0, obj.width, obj.height );
		}

		public function onAddedToStage(event:Event):void
		{
			FrameUpdater.instance.addEventListener( UpdateEvent.UPDATE, onUpdate );
			
			visible = false;
			parent.cacheAsBitmap = true;
			
			exactStageDimensions = getExactStageDimensions( );
			virtualCameraBounds = getVirtualCameraBounds( );
			registrationPoint = new Point( x, y );
			
			viewBitmapData = new BitmapData( exactStageDimensions.width, exactStageDimensions.height, true, 0 );
			viewBitmap = new Bitmap( viewBitmapData );
			
			drawCameraView();
			
			stage.addChild( viewBitmap );
		}

		public function onRemovedFromStage(event:Event):void
		{
			FrameUpdater.instance.removeEventListener( UpdateEvent.UPDATE, onUpdate );
		}
		
		private function drawCameraView() :void
		{
			parent.visible = true;

			// Move the registration point to the vCams current position ///////////////
			registrationPoint.x = x;
			registrationPoint.y = y;
		
			// Gets the current scale of the vCam //////////////////////////////////////
			var h:Number = virtualCameraBounds.height * scaleY;
			var w:Number = virtualCameraBounds.width * scaleX;
		
			// Gets the stage to vCam scale ratio //////////////////////////////////////
			var _scaleY:Number = exactStageDimensions.height / h;
			var _scaleX:Number = exactStageDimensions.width / w;
		
			////////////////////////////////////////////////////////////////////////////
			// Positions the parent ////////////////////////////////////////////////////
			x2 = w / 2 * _scaleX;
			y2 = h / 2 * _scaleY;
		
			scaleX2 = _scaleX;
			scaleY2 = _scaleY;
		
			rotation2 = -rotation;
		
			////////////////////////////////////////////////////////////////////////////
			// Draw bitmap of parent////////////////////////////////////////////////////
			viewBitmapData.lock( );
			viewBitmapData.fillRect( viewBitmapData.rect, 0x00 );
			viewBitmapData.unlock( );
		
			viewBitmapData.draw( stage );
		
			////////////////////////////////////////////////////////////////////////////
			// Apply vCam filters to bitmap ////////////////////////////////////////////
			viewBitmap.filters = this.filters;
			viewBitmap.transform.colorTransform = this.transform.colorTransform;
		
			parent.visible = false;
		}

		public function onUpdate(event:UpdateEvent):void
		{
			drawCameraView();
		}

		public function destroy():void
		{
			FrameUpdater.instance.removeEventListener( UpdateEvent.UPDATE, onUpdate );
			stagingHandler.destroy( );
			stagingHandler = null;
			
		
			stage.removeChild( viewBitmap );
			viewBitmapData.dispose( );
			viewBitmap = null;
		
			// Resets parent properties ////////////////////////////////////////////////
			parent.scaleX = 1;
			parent.scaleY = 1;
			parent.x = 0;
			parent.y = 0;
			parent.rotation = 0;
		
			parent.visible = true;
		}

		public function isDestroyed():Boolean
		{
			return null == stagingHandler;
		}

		function set x2(value:Number):void 
		{
			var p:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );
			parent.x += value - p.x;
		}

		function get x2():Number 
		{
			var p:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );
			return p.x;
		}

		function set y2(value:Number):void 
		{
			var p:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );
			parent.y += value - p.y;
		}

		function get y2():Number 
		{
			var p:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );
			return p.y;
		}

		function get scaleX2():Number 
		{
			return parent.scaleX;
		}

		function set scaleX2(value:Number):void 
		{
			setProperty2( "scaleX", value );
		}

		function get scaleY2():Number 
		{
			return parent.scaleY;
		}

		function set scaleY2(value:Number):void 
		{
			setProperty2( "scaleY", value );
		}

		function get rotation2():Number 
		{
			return parent.rotation;
		}

		function set rotation2(value:Number):void 
		{
			setProperty2( "rotation", value );
		}

		function setProperty2(prop:String,n:Number):void 
		{
			var a:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );

			parent[prop] = n;

			var b:Point = parent.parent.globalToLocal( parent.localToGlobal( registrationPoint ) );

			parent.x -= b.x - a.x;
			parent.y -= b.y - a.y;
		}
	}
}