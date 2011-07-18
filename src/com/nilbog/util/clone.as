package com.nilbog.util 
{
	import flash.display.DisplayObject;
	import flash.geom.Rectangle;
	import flash.net.registerClassAlias;
	import flash.utils.ByteArray;
	import flash.utils.getDefinitionByName;
	import flash.utils.getQualifiedClassName;
	
	/**
	 * Attempts to clone any object.
	 * 
	 * @param	source	*
	 * 
	 * @return *
	 */
	public function clone( source:* ) :*
	{
		var output:* = null;
		
		if (source is IClonable)
		{
			var c:IClonable = source as IClonable;
			return c.clone();
		}
		else if (source is DisplayObject)
		{
			var cls:Class = source.constructor;
			var ds:DisplayObject = source as DisplayObject;
			output = new cls();
			output.transform = ds.transform;
			output.filters = ds.filters;
			output.cacheAsBitmap = ds.cacheAsBitmap;
			output.opaqueBackground = ds.opaqueBackground;
			if (ds.scale9Grid)
			{
				var rect:Rectangle = ds.scale9Grid;
				output.scale9Grid = rect;
			}
			output.x = ds.x;
			output.y = ds.y;
			output.z = ds.z;
			output.rotation = ds.rotation;
			output.blendMode = ds.blendMode;
		}
		else if (source is Array)
		{
			output = [];
			for (var i:uint=0; i < source.length; i++)
			{
				output[i] = clone(source[i]);
			}
		}
		else
		{
			// allow type checking
			var name:String = getQualifiedClassName( source );
			registerClassAlias(name, getDefinitionByName(name) as Class);
			
			// perform copy
			var copier:ByteArray = new ByteArray();
		    copier.writeObject(source);
		    copier.position = 0;
		   	output = copier.readObject();
		}
		
		return output;
	}
}
