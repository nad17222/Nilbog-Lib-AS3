package com.nilbog.sfx.nodes.model 
{
	import com.nilbog.datastructures.graph.Edge;
	import com.nilbog.datastructures.graph.Graph;
	import com.nilbog.datastructures.graph.Node;
	import com.nilbog.log.LogLevel;
	import com.nilbog.mvc.AbstractModel;

	/**
	 * @author jmhnilbog
	 */
	public class GraphModel extends AbstractModel 
	{
		public var graph:Graph;
		
		/**
		 * Constructor.
		 */	
		public function GraphModel()
		{
			super( );
			
			log.minimumLevel = LogLevel.INFO;
			log.trace("%s(%s)", "GraphModel", arguments.join(", "));
			
			graph = new Graph();
		}
		
		/**
		 * Adds a node.
		 * 
		 * @param	data	NodeData
		 */
		public function addNode( data:NodeData ) :void
		{
			log.trace("%s(%s)", "addNode", arguments.join(", "));
			
			var n:Node = new Node(data);
			graph.addNode(n);
			dispatchEvent(new GraphNodeEvent(GraphNodeEvent.NODE_ADDED, n ) );
		}
		
		public function removeNode( data:NodeData ) :void
		{
			log.trace("%s(%s)", "removeNode", arguments.join(", "));
			
			log.info("nodes: " + graph.nodes);
			var n:Node = graph.getNode(data);
			log.info("Found node: " + n);
			graph.removeNode(n);
			dispatchEvent(new GraphNodeEvent(GraphNodeEvent.NODE_REMOVED , n) );
		}
		
		public function addConnection(from:Node, to:Node) :void
		{
			log.trace("%s(%s)", "addConnection", arguments.join(", "));
			
			var e:Edge = new Edge(from, to);
			graph.addEdge(e);
			dispatchEvent(new GraphEdgeEvent(GraphEdgeEvent.EDGE_ADDED, e));
		}
		
		public function removeConnection(from:Node, to:Node) :void
		{
			log.trace("%s(%s)", "removeConnection", arguments.join(", "));
			
			var e:Edge = graph.getEdge(from, to);
			dispatchEvent(new GraphEdgeEvent(GraphEdgeEvent.EDGE_REMOVED, e));
			graph.removeEdge(e);
		}
	}
}
