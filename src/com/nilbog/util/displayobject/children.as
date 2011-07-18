package com.nilbog.util.displayobject 
{
	import flash.display.DisplayObjectContainer;
	
	public function children(parent:DisplayObjectContainer):Array
	{	
		var a:Array = [];
		for (var i:uint = 0; i < parent.numChildren; i++)
		{
			a[i] = parent.getChildAt(i);
		}
		return a;
	}}