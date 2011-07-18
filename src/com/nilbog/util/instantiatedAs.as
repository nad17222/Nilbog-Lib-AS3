package com.nilbog.util 
{
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;	
		
	/**
    * Adapted from as3lib.
    * 
    * Checks the class of <code>instance</code> against the <code>compareClass</code> for strict
    * equality. If the classes are exactly the same, returns true. If
    * the classes are different even if the <code>instance</code>'s class is a subclass
	* of <code>compareClass</code>, it returns false.
	* Does not work with interfaces. The compareClass must be a class.
	* 
	* @author Mims Wright
	* 
	* @example <listing version="3.0">
	* 	var myBase:BaseClass = new BaseClass();
	*    var mySub:SubClass = new SubClass();
	*    trace(instantiatedAs(myBase, BaseClass)); // true
	*    trace(instantiatedAs(mySub, SubClass));   // true
	*    trace(instantiatedAs(mySub, BaseClass));  // false
	* </listing>
	* 
	* @param instance - the object whos class you want to check.
	* @param compareClass - the class to compare your object against.
	* 
	* @return true if instance is strictly of type compareClass.
	*/
	public function instantiatedAs( obj:Object, testClass:Class ):Boolean
	{
		//trace("obj: " + obj);
		var name:String = getQualifiedClassName( obj );
		//trace("name: " + name);
		var def:Class;
		try
		{
			def = getDefinitionByName( name ) as Class;
		}
		catch (e:Error)
		{
			trace("Caught error: " + e);
		}
		
		return def == testClass;
	}
}
