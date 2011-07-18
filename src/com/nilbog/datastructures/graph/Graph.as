package com.nilbog.datastructures.graph
{
	import com.nilbog.sfx.nodes.model.GraphEdgeEvent;
	import com.nilbog.util.IDestroyable;

	/**
	 * A basic graph structure implementation.
	 */
	public class Graph implements IDestroyable
	{
		public var nodes:Vector.<Node> = new Vector.<Node>();
		public var edges:Vector.<Edge> = new Vector.<Edge>();
		
		/**
		 * Constructor.
		 */	
		public function Graph()
		{
		}
		
		/**
		 * Adds a node to the graph.
		 * 
		 * @param	n	Node
		 */
		public function addNode(n:Node) :void
		{
			nodes.push(n);
		}
		
		/**
		 * Adds an edge to the graph.
		 * 
		 * @param	e	Edge
		 */
		public function addEdge(e:Edge) :void
		{
			edges.push(e);
		}
		
		/**
		 * Returns true if two nodes are directly connected.
		 * 
		 * @param 	n1	Node
		 * @param	n2	Node
		 * 
		 * @return Boolean
		 */
		public function areConnected(n1:Node, n2:Node) :Boolean
		{
			return edges.some( function (edge:Edge, index:uint, list:Vector.<Edge>) :Boolean
			{
				return edge.from === n1 && edge.to === n2;
			});
		}
		
		/**
		 * Returns a list of all nodes directly connected to a given node.
		 * 
		 * @param	n	Node
		 * 
		 * @return	Vector of Node
		 */
		public function getConnectedNodes(n:Node) :Vector.<Node>
		{
			var connections:Vector.<Node> = new Vector.<Node>();
			for each (var edge:Edge in getEdges(n)) 
			{
				var node:Node;
				if (edge.to === edge.from)
				{
					node = edge.to;
				}
				else if (edge.to != n)
				{
					node = edge.to;
				}
				else if (edge.from != n)
				{
					node = edge.from;
				}
				if (-1 == connections.indexOf(node))
				{
					connections.push(node);
				}
			}
			return connections;
		}
		
		public function getEdge(from:Node, to:Node) :Edge
		{
			for each (var e:Edge in edges)
			{
				if (e.from == from && e.to == to)
				{
					return e;
				}
			}
			return null;
		}
		
		public function getNode( data:* ) :Node
		{
			for each (var node:Node in nodes)
			{
				if (data == node.data)
				{
					return node;
				}
			}
			return null;
		}
		
		public function removeNode( n:Node ) :void
		{
			trace("removing node: " + n);
			// remove all incoming edges
			for each (var i:Edge in getIncomingEdges(n))
			{
				trace("removing edge");
				removeEdge(i);
			}
			// remove all outgoing edges
			for each (var o:Edge in getOutgoingEdges(n))
			{
				trace("removing edge");
				removeEdge(o);
			}
			// remove node
			var at:int = nodes.indexOf(n);
			trace("node found at: " + at);
			nodes.splice(at, 1);
			trace("nodes: " + nodes);
		}
		
		public function removeEdge(e:Edge) :void
		{
			e.to = null;
			e.from = null;
			var i:uint = edges.indexOf(e);
			edges.splice(i, 1);
		}
		
		/**
		 * Returns a list of outgoing edges from a given node.
		 * 
		 * @param	n	Node
		 * 
		 * @return Vector of Edge
		 */
		public function getOutgoingEdges(n:Node) :Vector.<Edge>
		{
			var out:Vector.<Edge> = edges.filter(function (edge:Edge, index:uint, list:Vector.<Edge>) :Boolean
			{
				return edge.from === n; 
			});
			return out;
		}
		
		/**
		 * Returns a list of incoming edges to a given node.
		 * 
		 * @param	n	Node
		 * 
		 * @return	Vector of Edge
		 */
		public function getIncomingEdges(n:Node) :Vector.<Edge>
		{
			var incoming:Vector.<Edge> = edges.filter(function (edge:Edge, index:uint, list:Vector.<Edge>) :Boolean
			{
				return edge.to === n; 
			});
			return incoming;
		}
		
		/**
		 * Returns a list of all edges to and from a given node.
		 * 
		 * @param	n	Node
		 * 
		 * @return 	Vector of Edge
		 */
		public function getEdges(n:Node) :Vector.<Edge>
		{
			var outgoing:Vector.<Edge> = getOutgoingEdges(n);
			var all:Vector.<Edge> = Vector.<Edge>(outgoing);
			var incoming:Vector.<Edge> = getIncomingEdges(n);
			for (var i:uint=0; i < incoming.length; i++)
			{
				all.push(incoming[i]);
			}
			return all;
		}
		
		/**
		 * Destroys the graph.
		 */
		public function destroy() :void
		{
			edges.forEach(function (edge:Edge, index:uint, list:Vector.<Edge>) :void
			{
				edge.destroy();
			});
			edges = null;
			nodes = null;
		}
		
		/**
		 * Returns true if the graph is destroyed and invalid.
		 * 
		 * @return Boolean
		 */
		public function isDestroyed() :Boolean
		{
			return null == nodes;
		}
		
		/**
		 * Simple string dump.
		 * 
		 * @return	String
		 */
		public function toString() :String
		{
			var s:String = "[ Graph: ";
			for each (var n:Node in nodes) 
			{
				s += n.toString();	
			}
			s += "]";
			return s;
		}
	}
}