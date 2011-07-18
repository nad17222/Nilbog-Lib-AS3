package com.nilbog.functional 
{
	import com.nilbog.assertions.checkArgument;
	import com.nilbog.assertions.fail;
	import com.nilbog.util.array.castVectorToArray;
    	
    /**
	 * Standard reduce function. 
	 * 
	 * @param	thisObj	Object to use as this in function (optional)
	 * @param	func	Function, takes two arguments
	 * @param	list	Array, of arguments to be applied to func
	 * @param	initial	Object (optional). The default return value, and used as
	 * 					the first argument to func if supplied.
	 * 					
	 * @return 	Object, the final result of func calls
	 */
    public function reduce( funcOrThisObj:Object, funcOrArray:Object, 
		arrayOrInitial:*=  null, init:*=  null ):Object
    {
        var thisObj:Object;
        var func:Function;
        var list:Array;
        var initial:Object;
		
        checkArgument( (funcOrThisObj is Function) || (funcOrThisObj is Function && funcOrArray === null) || (funcOrThisObj is Object && funcOrArray is Function ), "Bad arguments passed to reduce()." );
		
        if ( funcOrThisObj is Function )
        {
            thisObj = null;
            func = funcOrThisObj as Function;
            if (null == funcOrArray)
            {
            	list = null;
            }
            else if (funcOrArray is Array)
            {
            	list = funcOrArray as Array;
            }
            else
            {
            	list = castVectorToArray( funcOrArray );
            }
            initial = arrayOrInitial;
        }
		else if (funcOrArray is Function)
        {
            thisObj = funcOrThisObj;
            func = funcOrArray as Function;
            if (null == arrayOrInitial)
            {
            	list = null;
            }
            else if (arrayOrInitial is Array)
            {
            	list = arrayOrInitial as Array;
            }
            else
            {
            	list = castVectorToArray( funcOrArray );
            }
            initial = init;
        }
        else
        {
            fail( "Bad assertion in reduce: missed bad arguments." );
        }
		
        if (list == null)
        {
            // abandon ship if no list was sent
            return initial;
        }
		
        var allParameters:Object = list.slice( );
        if (initial != null)
        {
            allParameters.unshift( initial );
        }
		else
		{
			// ignore it
		}
		
        var result:* = allParameters.shift( );
		
        while( allParameters.length > 0 )
        {
            result = func.apply( thisObj, [ result, allParameters.shift( ) ] );
        }
        return result;
    }
}
