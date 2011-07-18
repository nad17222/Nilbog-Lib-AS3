package com.nilbog.sfx.nodes.model 
{
	import com.nilbog.datastructures.graph.Node;
	

	/**
	 * @author jmhnilbog
	 */
	public class GraphNodeEvent extends GraphEvent 
	{
		public static const NODE_ADDED:String = "node added";
		public static const NODE_REMOVED:String = "node removed";
		
		public var node:Node;
		
		public function GraphNodeEvent(type:String, node:Node)
		{
			super( type );
			
			this.node = node;
		}
	}
}
