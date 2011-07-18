package com.nilbog.sfx.nodes.model 
{
	import com.nilbog.random.RNG;

	/**
	 * @author jmhnilbog
	 */
	public class NodeData 
	{
		private var data:Number = RNG.random();
		
		public function toString() :String
		{
			return "" + data;
		}
	}
}
