package com.nilbog.graph 
{
	import asunit.framework.TestCase;

	import com.nilbog.datastructures.graph.Edge;
	import com.nilbog.datastructures.graph.Graph;
	import com.nilbog.datastructures.graph.Node;

	/**
	 * @author mark hawley
	 */
	public class GraphTest extends TestCase 
	{
		private var instance:Error;
		
		public function GraphTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		public function testGraph() :void
		{
			var g:Graph = new Graph();
			
			var n1:Node = new Node("n1");
			var n2:Node = new Node("n2");
			var n3:Node = new Node("n3");
			
			var e12:Edge = new Edge(n1, n2);
			var e21:Edge = new Edge(n2, n1);
			var e23:Edge = new Edge(n2, n3);
			var e13:Edge = new Edge(n1, n3);
			var e22:Edge = new Edge(n2, n2);
			var e31:Edge = new Edge(n3, n1);
			
			//			
			//	n1---------------->n2--------|
			//	-n1<---------------n2<-------|
			//	\\                  /
			//	 \\			       /
			//	  \\              /
			//	   \\----->n3<----    
			//		\------n3
			// 
			// several points point to n3. n1 and n2 point at each other. 
			// n1 and n3 point to each other. n2 points one-way
			// to n3. n2 points to itself and one-way to n3.
			
			g.addNode(n1);
			g.addNode(n2);
			g.addNode(n3);
			g.addEdge(e12);
			g.addEdge(e21);
			g.addEdge(e23);
			g.addEdge(e13);
			g.addEdge(e22);
			g.addEdge(e31);
			
			assertTrue("1->2", g.areConnected(n1, n2));
			assertTrue("2->1", g.areConnected(n2, n1));
			assertTrue("2->3", g.areConnected(n2, n3));
			assertTrue("1->3", g.areConnected(n1, n3));
			assertTrue("2->2", g.areConnected(n2, n2));
			assertTrue("3->1", g.areConnected(n3, n1));
			
			assertFalse("NO! 3->2", g.areConnected(n3, n2));
			assertFalse("NO! 3->3", g.areConnected(n3, n3));
			
			var n3Out:Vector.<Edge> = g.getOutgoingEdges(n3);
			assertTrue("1 outgoing edge from n3.", n3Out.length == 1);
			
			var n2Out:Vector.<Edge> = g.getOutgoingEdges(n2);
			assertTrue("3 outgoing edges from n2.", n2Out.length == 3);
			
			var n2In:Vector.<Edge> = g.getIncomingEdges(n2);
			assertTrue("2 incoming edges to n2", n2In.length == 2);
			
			var n2Con:Vector.<Node> = g.getConnectedNodes(n2);
			assertTrue("3 nodes are connected to n2.(" + n2Con + ")", n2Con.length == 3);
		}
	}
}
