package com.nilbog.util.array 
{
	import com.nilbog.random.RNG;
	
	public function shuffle( array:Array ):void
	{
		// fisher-yates shuffle
		var i:uint = array.length;
		if ( i == 0 ) 
		{
			return;
		}
		while ( --i ) 
		{
			var j:Number = Math.floor(RNG.random() * ( i + 1 ));
			var tempi:Object = array[i];
			var tempj:Object = array[j];
			array[i] = tempj;
			array[j] = tempi;
		}
		return;
	}
}
