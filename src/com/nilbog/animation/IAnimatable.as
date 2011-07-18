package com.nilbog.animation 
{

	/**
     * Interface for things that are animatable.
     * 
     * @author markhawley
     */
    public interface IAnimatable 
    {
    	/**
    	 * Animates an object towards a set of values.
    	 * 
    	 * @param 	duration Number, in seconds
    	 * @param	obj	Object, a hash of names and values
    	 */
        function animateTo( duration:Number, obj:* ):void;
        /**
    	 * Animates an object away from a set of values (to the values it
    	 * currently has.)
    	 * 
    	 * @param 	duration Number, in seconds
    	 * @param	obj	Object, a hash of names and values
    	 */
        function animateFrom( duration:Number, obj:* ):void;
    }
}
