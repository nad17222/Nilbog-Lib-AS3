package com.nilbog.sfx.lensflare 
{
    import com.nilbog.dbc.precondition;
    import com.nilbog.util.IDestroyable;
    
    import flash.display.BlendMode;
    import flash.display.Sprite;
    import flash.geom.Rectangle;    

    /**
     * @author markhawley
     * 
     * Adapted from code adapted from http://blog.zupko.info/?p=99=1
     */
    public class LensFlare extends Sprite implements IDestroyable
    {	
        private var bounds:Rectangle;
        private var lightSource:Object;
        private var _destroyed:Boolean = false;

        /**
         * Constructor
         * 
         * @param	bounds	Rectangle, describing the area of the parent clip
         * 					to draw the lens flare within.
         * @param	flareElements	an arbitrary number of LensFlareElements
         * 			to use to make the lens flare. Unless you're experimenting
         * 			with effects, try using 8 of them. (The default LensFlare
         * 			usage assumes 8.)
         */
        public function LensFlare( bounds:Rectangle, ...flareElements)
        {
            this.bounds = bounds;
			
            var i:uint = 0;
            for each (var element:LensFlareElement in flareElements) 
            {
                if (isNaN( element.relativeValues.distance ))
                {
                    var defaults:Object = DEFAULT_ELEMENT_VALUES[i];
                    for (var k:String in defaults)
                    {
                        element.relativeValues[k] = defaults[k];
                    }
                }
                element.blendMode = BlendMode.ADD;
                addChild( element );
                i++;
            }
            x = bounds.width / 2;
            y = bounds.height / 2;
			
            visible = false;
        }

        /**
         * Assigns the light source this lens flare should be originating from.
         * Immediately updates the lens flare and draws it.
         * 
         * @param	lightSource	*, anything with an x, y, and optional alpha.
         */
        public function setLightSource( lightSource:* ):void
        {
            precondition( !isDestroyed( ) );
            precondition( lightSource.x != null || lightSource.y != null );
			
            this.lightSource = lightSource;
			
            visible = true;
			
            draw( );
        }

        /**
         * Draws the lens flare according to the current state of the 
         * light source.
         */
        public function draw():void
        {
            precondition( !isDestroyed( ) );
            precondition( lightSource.x != null && lightSource.y != null );
			
            var w:Number = bounds.width * 0.5;
            var h:Number = bounds.height * 0.5;
            var lx:Number = lightSource.x - bounds.width / 2;
            var ly:Number = lightSource.y - bounds.height / 2;
			
            var alx:Number = Math.abs( lx );
            var aly:Number = Math.abs( ly );
			
            var distance:Number = Math.sqrt( lx * lx + ly * ly );
            var angle:Number = Math.atan2( ly, lx );
			
            var f:LensFlareElement;
            var dx:Number;
            var dy:Number;
            var scaleX:Number;
            var scaleY:Number;
            var scale:Number;
			
            if (lightSource.alpha == undefined)
            {
                lightSource.alpha = 1;
            }
            alpha = lightSource.alpha;
			
            for(var i:Number = 0; i < numChildren ;i++)
            {
                f = getChildAt( i ) as LensFlareElement;
				
                dx = Math.cos( angle ) * f.relativeValues.distance * distance;
                dy = Math.sin( angle ) * f.relativeValues.distance * distance;
				
                scaleX = scaleY = f.relativeValues.scale;
			
                if(f.relativeValues.dScale != 0 && !isNaN( f.relativeValues.dScale ))
                {
                    scaleX += ((Math.abs( dx )) / w) * f.relativeValues.dScale;
                    scaleY += ((Math.abs( dy )) / h) * f.relativeValues.dScale;
                }
				
                scale = Math.max( scaleX, scaleY );
				
                f.scaleX = f.scaleY = scale;
				
                if(f.relativeValues.rotate)
                {
                    f.rotation = angle * (180 / Math.PI) - 180;
                }
				
                f.x = dx;
                f.y = dy;
				
                if(f.relativeValues.alpha)
                {
                    f.alpha = 1 - Math.max( alx / w, aly / h ) * f.relativeValues.alpha;
                }
            }
        }

        /**
         * Cleans up.
         */
        public function destroy():void
        {
            precondition( !isDestroyed( ) );
			
            visible = false;
            lightSource = null;
            bounds = null;
            while(numChildren > 0)
            {
                removeChildAt( 0 );
            }
            _destroyed = true;
        }

        public function isDestroyed():Boolean
        {
            return _destroyed;
        }

        /**
         * Default data for a default lens flare, assuming 8 flareElements
         * were passed in.
         */
        internal static const DEFAULT_ELEMENT_VALUES:Array = [ {distance:.7, scale:1, dScale:0, alpha:.1},
			{distance:.5, scale:0.55, dScale:0, alpha:0.5},
			{distance:.5, scale:0.5, dScale:0, alpha:0.5},
			{distance:0.1, scale:0.25, dScale:0, alpha:0.8},
			{distance:-.1, scale:1, dScale:0, alpha:.8}, //{distance:0.125, 	scale:1, 	dScale:0, 	alpha:0.8},
			{distance:.25, scale:1, dScale:0, alpha:.5},
			{distance:.2, scale:0.45, dScale:0, alpha:.5},
			{distance:-.2, scale:0.1, dScale:1.1, alpha:0.25} ];
    }
}
