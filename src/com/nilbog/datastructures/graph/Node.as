package com.nilbog.datastructures.graph
{
	/**
	 * A node on a basic graph.
	 */
	public class Node
	{
		// the data payload of the graph node
		public var data:*;

		/**
		 * Constructor.
		 * 
		 * @param	data	* the data payload
		 */
		public function Node(data:*)
		{
			this.data = data;
		}
		
		/**
		 * String dump.
		 * 
		 * @return String
		 */
		public function toString() :String
		{
			return "[Node: " + data + "]";
		}
	}
}