package com.nilbog.util.number 
{
	import com.greensock.easing.Linear;
	public function interpolate(t:Number, start:Number, end:Number, ease:Function = null):Number
	{
		var easeFunction:Function = ease || Linear.easeNone;
		var diff:Number = end - start;
		return easeFunction( t, 0, diff, 1 ) + start;
	}}