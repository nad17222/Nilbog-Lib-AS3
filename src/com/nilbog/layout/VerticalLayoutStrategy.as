package com.nilbog.layout 
{
	import com.nilbog.layout.ILayoutStrategy;
	import com.nilbog.util.displayobject.align;

	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;

	/**
     * @author mark hawley
     * 
     * Layout strategy that lays out the children of a 
     * DisplayObjectContainer on top of each other.
     */
    public class VerticalLayoutStrategy implements ILayoutStrategy 
    {
        private var padding:Number;
		private var alignment:uint;
		
        /**
         * Constructor.
         * 
         * @param	padding	Number (optional, defaults to 0.) Pixels
         * 					to space the children out.
         */
        public function VerticalLayoutStrategy( padding:Number=0, alignment:uint=0 )
        {
            this.padding = padding;
            this.alignment = alignment;
        }

        /**
         * Performs the strategy's layout.
         * 
         * @param	obj	DisplayObjectContainer
         */
        public function layout(obj:DisplayObjectContainer):void
        {
        	var child:DisplayObject;
        	
        	if (obj.numChildren == 0)
        	{
        		return;
        	}
        	else if (obj.numChildren == 1)
        	{
        		child = obj.getChildAt( i );
        		child.y = 0;
        		return;
        	}
        	else
        	{
	        	var y:Number = 0;
	        	var i:int;
	        	for (i = 0; i < obj.numChildren ; i++)
	            {
	                child = obj.getChildAt( i );
	                child.y = y;
	                y = child.y + child.height + padding;
	                if (i > 0)
	                {
	                	var previousChild:DisplayObject = obj.getChildAt( i-1 );
	                	align(child, previousChild.getBounds(obj), alignment);
	                }
	            }
	            
	            // now keep 0,0 at the top left
	            var min:Number = Number.POSITIVE_INFINITY;
				for (i = 0; i < obj.numChildren; i++)
            	{
            		min = Math.min( min, obj.getChildAt(i).x);
            	}
            	
            	for (i = 0; i < obj.numChildren; i++)
            	{
            		obj.getChildAt(i).x -= min;
            	}	        
        	}
        }
    }
}
