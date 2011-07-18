package com.nilbog.util.geometry 
{
	import flash.geom.Rectangle;
	
	public function setFromRectangle(obj:*, rect:Rectangle):void
	{
		if (obj.width && obj.height)
		{
			obj.width = rect.width;
			obj.height = rect.height;
		}
		if (obj.x && obj.y)
		{
			obj.x = rect.x;
			obj.y = rect.y;
		}
	}
}
