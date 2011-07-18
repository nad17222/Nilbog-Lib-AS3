package com.nilbog.util.string
{
	public function chomp(s:String) :String
	{
		var r:RegExp = /\n$/;
		s.replace(r, "");
		return s;
	}
}