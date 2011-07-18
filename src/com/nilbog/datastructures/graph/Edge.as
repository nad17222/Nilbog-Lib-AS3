package com.nilbog.datastructures.graph
{
	import com.nilbog.util.IDestroyable;

	/**
	 * Defines a one-way link between two graph nodes.
	 */
	public class Edge implements IDestroyable
	{
		public var to:Node;
		public var from:Node;
		
		/**
		 * Constructor.
		 * 
		 * @param	from	Node, the originating node.
		 * @param	to		Node, the node pointed to.
		 */
		public function Edge(from:Node, to:Node)
		{
			this.to = to;
			this.from = from;
		}
		
		/**
		 * Destroys the edge.
		 */
		public function destroy() :void
		{
			to = null;
			from = null;
		}
		
		/**
		 * Tells whether the edge is destroyed or valid.
		 * 
		 * @return Noolean
		 */
		public function isDestroyed() :Boolean
		{
			return null == from || null == to;
		}
	}
}