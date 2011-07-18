package com.nilbog.functional 
{
    import com.nilbog.functional.map;        	
	/**
	 * Just like map, but returns nothing.
	 * 
	 * @param	funcOrthisObj	Function or Object
	 * @param	funcOrArray		Function or Array
	 * @param	...		variable number of Arrays to call func with.
	 * 
	 * @throws	IllegalArgumentError if neither or the first two
	 * 			arguments are functions.
	 */
    public function forEach( funcOrThisObj:Object, funcOrArray:Object, ...rest ):void
    {
        var args:Array = [ funcOrThisObj, funcOrArray ];
        for (var i:uint = 0; i < rest.length ; i++)
        {
            args.push( rest[i] );
        }
        map.apply( null, args );
    }
}
