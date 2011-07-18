package com.nilbog.util.array 
{	import com.nilbog.dbc.precondition;

	import flash.utils.describeType;
	public function castVectorToArray( v:* ) :Array
	{
		var matches:Array = describeType(v).@name.match(/^__AS3__.vec::Vector./);
		precondition( null != matches && matches.length == 1, "Casting a Vector.");
		
		var a:Array = [];
		for (var i:uint=0; i < v.length; i++)
		{
			a[i] = v[i];
		}
		return a;
	}}