package com.nilbog.layout 
{
	import com.nilbog.dbc.precondition;
	import com.nilbog.util.IDestroyable;

	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.EventPhase;
	com.nilbog.layout.ILayoutStrategy;

    /**
     * @author mark hawley
     * 
     * A basic sprite that performs layout of its children as they
     * are added or removed.
     */
    public class Box extends Sprite implements IDestroyable
    {
        private var layoutManager:ILayoutStrategy;
        private var _isDestroyed:Boolean = false;

        /**
         * Constructor.
         * 
         * @param layout	ILayoutStrategy
         */
        public function Box( layout:ILayoutStrategy )
        {
            layoutManager = layout;
            addEventListener( Event.ADDED, onAdded );
            addEventListener( Event.REMOVED, onRemoved);
        }

        public function destroy():void
        {
            precondition( !isDestroyed( ) );
			
            layoutManager = null;
            removeEventListener( Event.ADDED, onAdded);
            removeEventListener( Event.REMOVED, onRemoved);
			
            _isDestroyed = true;
        }

        /**
         * Discards all children of the box.
         */
        public function empty():void
        {
            precondition( !isDestroyed( ) );
			
            while ( numChildren > 0 )
            {
                removeChildAt( numChildren - 1 );
            }
        }

        public function performLayout():void
        {
            precondition( !isDestroyed( ) );
			
			layoutManager.layout( this );
        }

        /**
         * 
         */
        private function onAdded(event:Event):void
        {
        	if (event.eventPhase != EventPhase.AT_TARGET)
            {
                performLayout( );
            }
        }

        /**
         * 
         */
        private function onRemoved(event:Event):void
        {
        	if (event.eventPhase != EventPhase.AT_TARGET)
            {
                performLayout( );
            }
        }
        public function isDestroyed():Boolean
        {
            return _isDestroyed;
        }
    }
}
