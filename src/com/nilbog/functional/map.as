package com.nilbog.functional 
{
    import com.nilbog.assertions.checkArgument;
    import com.nilbog.assertions.fail;	
    
    /**
	 * Standard map function. Returns an empty Array if no lists 
	 * of parameters are passed to the call.
	 * 
	 * @param	funcOrthisObj	Function or Object
	 * @param	funcOrArray		Function or Array
	 * @param	...		variable number of Arrays to call func with.
	 * 
	 * @return 	Array	results of calls with the given arguments.
	 * 
	 * @throws	IllegalArgumentError if neither or the first two
	 * 			arguments are functions.
	 */
    public function map( funcOrThisObj:Object, funcOrArray:Object, ...rest ):Array
    {
        var thisObj:Object;
        var func:Function;
        var lists:Array;
		
        checkArgument( (funcOrThisObj is Function && funcOrArray is Array) || (funcOrThisObj is Object && funcOrArray is Function), "Bad arguments passed to map()." );
		
        for (var i:uint = 0; i < rest.length ; i++)
        {
            checkArgument( rest[i] is Array, "Non-Array passed to map." );
        }
		
        if (funcOrThisObj is Function)
        {
            thisObj = null;
            func = funcOrThisObj as Function;
            lists = rest.slice( );
            lists.unshift( funcOrArray );
        }
		else if (funcOrArray is Function)
        {
            thisObj = funcOrThisObj;
            func = funcOrArray as Function;
            lists = rest.slice( );
        }
        else
        {
            fail( "Bad assertion in map: missed bad arguments." );
        }
		
        var results:Array = []; 
		
        if (func == null && lists.length == 0)
        {
            results = null;
        }
        if (lists.length == 0)
        {
            results = []; 
        }
        else
        {
            // find the longest list of args
            var numberOfCalls:Number = 0;
            for (var listIndex:Number = 0; listIndex < lists.length ; listIndex++)
            {
                var list:Array = lists[ listIndex ];
                numberOfCalls = Math.max( numberOfCalls, list.length );
            }
            // call func that many times, with null values padded into other
            for (var callIndex:Number = 0; callIndex < numberOfCalls ; callIndex++) 
            {
                var argumentsToFunc:Array = [];
                for (var argIndex:Number = 0; argIndex < lists.length ; argIndex++) 
                {
                    //TODO: verify if this is necessary
                    var arg:*;
                    if (lists[argIndex][callIndex] == undefined)
                    {
                        arg = null;
                    }
                    else
                    {
                        arg = lists[argIndex][callIndex];
                    }
                    argumentsToFunc[argIndex] = arg;
                }
                results.push( func.apply( thisObj, argumentsToFunc ) );
            }
        }
        return results;
    }
}
