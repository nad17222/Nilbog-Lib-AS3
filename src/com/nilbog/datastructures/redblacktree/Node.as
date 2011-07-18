package com.nilbog.datastructures.redblacktree 
{

    /**
     * @author 'smack9' on flashkit, from http://web.mit.edu/~emin/www/source_code/cpp_trees/index.html
     */
    public class Node 
    {
        public var left:Node;
        public var right:Node;
        public var parent:Node;
        public var red:int;
        // setting the key to type '*' is twice as slow
        public var key:int;   
        public var data:*;

        public function Node( key:int = 0, data:*= null ) 
		{
			this.key = key;
			this.data = data;
		}
    }
}