package com.nilbog.sfx.nodes.model 
{
	import com.nilbog.datastructures.graph.Edge;

	/**
	 * @author jmhnilbog
	 */
	public class GraphEdgeEvent extends GraphEvent 
	{
		public static const EDGE_ADDED:String = "edge added";
		public static const EDGE_REMOVED:String = "edge removed";
		
		public var edge:Edge;
		
		public function GraphEdgeEvent(type:String, edge:Edge)
		{
			super( type );
			
			edge = edge;
		}
	}
}
