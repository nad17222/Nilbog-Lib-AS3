package com.nilbog.events 
{
	import com.nilbog.mvc.ModelEvent;
	import com.nilbog.util.string.sprintf;

	import flash.display.Stage;
	import flash.events.Event;

	/**
	 * @author jmhnilbog
	 */
	public class ResizeEvent extends ModelEvent 
	{
		public static const RESIZE:String = "resize";
		
		public var resized:*;
		public var oldWidth:Number;
		public var oldHeight:Number;
		public var newWidth:Number;
		public var newHeight:Number;
		
		public function ResizeEvent(type:String, obj:*, oldWidth:Number, oldHeight:Number )
		{
			super( type );
			
			resized = obj;
			
			newWidth = resized.width;
			newHeight = resized.height;
			
			if (resized is Stage)
			{
				var s:Stage = resized as Stage;
				newWidth = s.stageWidth;
				newHeight = s.stageHeight;
			}
			
			this.oldWidth = oldWidth;
			this.oldHeight = oldHeight;
		}
		
		override public function clone() :Event
		{
			return new ResizeEvent(type, resized, oldWidth, oldHeight);
		}
		
		override public function toString() :String
		{
			return sprintf("[ResizeEvent (%s) { resized: %s, original size: %s x %s, current size: %s x %s }]", type, resized, oldWidth, oldHeight, newWidth, newHeight);
		}
	}
}
