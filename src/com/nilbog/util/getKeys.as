package com.nilbog.util 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	public function getKeys(obj:*) :Array
	{
		var a:Array = [];
		for (var key:String in obj)
		{
			trace("puhing " + key);
			a.push(key);
		}
		return a;
	}
}
