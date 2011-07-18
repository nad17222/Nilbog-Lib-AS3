package com.nilbog.util 
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.util.IDestroyable;

	import flash.display.DisplayObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;

	/**
	 * Keeps track of the mouse's state.
	 * 
	 * @author jmhnilbog
	 */
	public class MouseManager implements IDestroyable
	{
		// track mouse status
		public var mouseDown:Boolean = false;
		
		public const dragRegion:Rectangle = new Rectangle();
		
		public const mouseDownPoint:Point = new Point();
		public const mouseLocation:Point = new Point();

		private var sprite:DisplayObject;
		
		protected var log:ILog;
		
		public function MouseManager( s:DisplayObject=null )
		{
			log = getLog(this, LogLevel.WARN );
			log.trace("%s(%s)", "MouseManager", arguments.join(", "));
			
			sprite = s;
			if (null == sprite.stage)
			{
				sprite.addEventListener(Event.ADDED_TO_STAGE, onStaged);
			}
			else
			{
				onStaged();
			}
		}
		
		/**
		 * Detects mouse down.
		 * 
		 * @param	e	MouseEvent
		 */
		private function onMousePress(e:MouseEvent):void
		{
			log.trace("%s(%s)", "onMousePress", arguments.join(", "));
			
			mouseDown = true;
			
			mouseDownPoint.x = mouseLocation.x = sprite.mouseX;
			mouseDownPoint.y = mouseLocation.y = sprite.mouseY;
			
			updateDragRegion();
		}

		/**
		 * Detects mouse up.
		 * 
		 * @param	e	MouseEvent
		 */
		private function onMouseRelease(e:MouseEvent):void
		{
			log.trace("%s(%s)", "onMouseRelease", arguments.join(", "));
			
			mouseDown = false;
			
			mouseLocation.x = sprite.mouseX;
			mouseLocation.y = sprite.mouseY;
			
			updateDragRegion();
		}

		/**
		 * Detects mouse leaving movie.
		 * 
		 * @param	e	Event
		 */
		private function onMouseLeave(e:Event):void
		{	
			log.trace("%s(%s)", "onMouseLeave", arguments.join(", "));
			
			mouseLocation.x = sprite.mouseX;
			mouseLocation.y = sprite.mouseY;
	
			mouseDown = false;
			
			updateDragRegion();
		}

		/**
		 * Detects mouse movement. (Handles mouse release bug as well.)
		 * 
		 * @param	e	MouseEvent
		 */
		private function onMouseMove(e:MouseEvent):void
		{
			log.trace("%s(%s)", "onMouseMove", arguments.join(", "));
			
			mouseLocation.x = sprite.mouseX;
			mouseLocation.y = sprite.mouseY;
			
			//trace("MOUSE MOVE TO: " + mouseLocation + "(" + sprite + ")");
			
			// Fix mouse release not being registered from mouse going off stage
			mouseDown = e.buttonDown;
			
			if (mouseDown)
			{
				updateDragRegion();
			}
		}

		/**
		 * Listens to various events once its view is on the stage.
		 * 
		 * @param	event	Event (defaults to null)
		 */
		protected function onStaged(event:Event=null):void
		{
			log.trace("%s(%s)", "onStaged", arguments.join(", "));
			
			var t:DisplayObject = sprite;	
			t.removeEventListener( Event.ADDED_TO_STAGE, onStaged );
			t.addEventListener( Event.REMOVED_FROM_STAGE, onUnStaged);
				
			t.stage.addEventListener( MouseEvent.MOUSE_DOWN, onMousePress, false, 0, true );
			t.stage.addEventListener( MouseEvent.CLICK, onMouseRelease, false, 0, true );
			t.stage.addEventListener( MouseEvent.MOUSE_UP, onMouseRelease, false, 0, true );
			t.stage.addEventListener( MouseEvent.MOUSE_MOVE, onMouseMove, false, 0, true );
			t.stage.addEventListener( Event.MOUSE_LEAVE, onMouseLeave, false, 0, true );
			
		}
		
		protected function onUnStaged(event:Event=null) :void
		{
			log.trace("%s(%s)", "onUnStaged", arguments.join(", "));
			
			var t:DisplayObject = sprite as DisplayObject;
			t.removeEventListener( Event.REMOVED_FROM_STAGE, onUnStaged);
			t.addEventListener( Event.ADDED_TO_STAGE, onStaged);
				
			t.stage.removeEventListener( MouseEvent.MOUSE_DOWN, onMousePress );
			t.stage.removeEventListener( MouseEvent.CLICK, onMouseRelease );
			t.stage.removeEventListener( MouseEvent.MOUSE_UP, onMouseRelease );
			t.stage.removeEventListener( MouseEvent.MOUSE_MOVE, onMouseMove );
			t.stage.removeEventListener( Event.MOUSE_LEAVE, onMouseLeave );
			
		}

		public function destroy():void
		{
			log.trace("%s(%s)", "destroy", arguments.join(", "));
			
			onUnStaged();
			sprite.removeEventListener( Event.ADDED_TO_STAGE, onStaged );
			
			sprite = null;
		}

		public function isDestroyed():Boolean
		{
			log.trace("%s(%s)", "isDestroyed", arguments.join(", "));
			
			return sprite == null;
		}
		
		private function updateDragRegion() :void
		{
			log.trace("%s(%s)", "updateDragRegion", arguments.join(", "));
			
			if (mouseDownPoint.x < mouseLocation.x)
			{
				dragRegion.x = mouseDownPoint.x;
			}
			else
			{
				dragRegion.x = mouseLocation.x;
			}
			if (mouseDownPoint.y < mouseLocation.y)
			{
				dragRegion.y = mouseDownPoint.y;
			}
			else
			{
				dragRegion.y = mouseLocation.y;
			}
			dragRegion.width = Math.abs( mouseDownPoint.x - mouseLocation.x );
			dragRegion.height = Math.abs( mouseDownPoint.y - mouseLocation.y);
		}
	}
}
