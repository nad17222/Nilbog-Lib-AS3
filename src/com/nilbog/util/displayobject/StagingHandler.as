package com.nilbog.util.displayobject 
{
	import com.nilbog.util.IDestroyable;
	import com.nilbog.util.IStageListenable;

	import flash.events.Event;

	/**
	 * @author jmhnilbog
	 */
	public class StagingHandler implements IDestroyable
	{
		private var obj:IStageListenable;
		
		public function StagingHandler( obj:IStageListenable )
		{
			this.obj = obj;
			
			if (null == obj.stage)
			{
				obj.addEventListener( Event.ADDED_TO_STAGE, onAddedToStage);
			}
			else
			{
				onAddedToStage();
			}
		}
		
		public function destroy():void
		{
			obj.removeEventListener( Event.ADDED_TO_STAGE, onAddedToStage );
			obj.removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage );	
			
			obj = null;
		}
		
		public function isDestroyed():Boolean
		{
			return null == obj;
		}
		
		public function onAddedToStage( event:Event=null ) :void
		{
			obj.removeEventListener( Event.ADDED_TO_STAGE, obj.onAddedToStage );
			obj.addEventListener( Event.REMOVED_FROM_STAGE, obj.onRemovedFromStage );
			
			obj.onAddedToStage( event );	
		}
		
		public function onRemovedFromStage( event:Event=null ) :void
		{
			obj.removeEventListener( Event.REMOVED_FROM_STAGE, obj.onRemovedFromStage );
			obj.addEventListener( Event.ADDED_TO_STAGE, obj.onAddedToStage );
			
			obj.onRemovedFromStage( event );
		}
	}
}
