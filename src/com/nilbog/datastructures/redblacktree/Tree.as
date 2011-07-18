package com.nilbog.datastructures.redblacktree 
{

    /**
     * @author 'smack9' on flashkit, from http://web.mit.edu/~emin/www/source_code/cpp_trees/index.html
     */
    public class Tree 
    {
        public var root:Node;
        public var nil:Node;

        public function Tree() 
        {
            nil = new Node( );
            nil.left = nil;
            nil.right = nil;
            nil.parent = nil;
            nil.red = 0;

            root = new Node( );
            root.left = nil;
            root.right = nil;
            root.parent = nil;
            root.red = 0;
        }

        public function deleteNode( z:Node ):void 
        {
            var x:Node;
            var y:Node;

            y = ( (z.left == nil) || (z.right == nil) ) ? z : nextNode( z );
            x = (y.left == nil) ? y.right : y.left;

            if( root == (x.parent = y.parent) ) 
            {
                root.left = x;
            } 
            else 
            {
                if( y == y.parent.left ) 
                {
                    y.parent.left = x;
                } 
                else 
                {
                    y.parent.right = x;
                }
            }

            if( y != z ) 
            {
                y.left = z.left;
                y.right = z.right;
                y.parent = z.parent;
                z.left.parent = z.right.parent = y;
                if( z == z.parent.left ) 
                {
                    z.parent.left = y;
                } 
                else 
                {
                    z.parent.right = y;
                }
                if( y.red == 0 ) 
                {
                    y.red = z.red;
                    deleteFixUp( x );
                } 
                else 
                {
                    y.red = z.red;
                }
            } 
            else 
            {
                if( y.red == 0 ) deleteFixUp( x );
            }
        }

        public function insertNode( z:Node ):Node
        {
            var x:Node;
            var y:Node;

            z.left = z.right = nil;

            // ordinary binary tree insert
            y = root;
            x = root.left;
            while( x != nil ) 
            {
                y = x;
                if( x.key > z.key ) 
                {
                    x = x.left;
        /* Not sure what to do about duplicate keys
        } else if( x.key < z.key ) {
          x = x.right;
        */
                } 
                else 
                {
                    x = x.right;
                }
            }
            z.parent = y;
            if( ( y == root ) || ( y.key > z.key ) ) 
            {
                y.left = z;
            } 
            else 
            {
                y.right = z;
            }

            x = z;
            x.red = 1;
            while( x.parent.red ) 
            {
                if( x.parent == x.parent.parent.left ) 
                {
                    y = x.parent.parent.right;
                    if( y.red ) 
                    {
                        y.red = 0;
                        x.parent.red = 0;
                        x.parent.parent.red = 1;
                        x = x.parent.parent;
                    } 
                    else 
                    {
                        if( x == x.parent.right ) 
                        {
                            x = x.parent;
                            leftRotate( x );
                        }
                        x.parent.red = 0;
                        x.parent.parent.red = 1;
                        rightRotate( x.parent.parent );
                    }
                } 
                else 
                {
                    y = x.parent.parent.left;
                    if( y.red ) 
                    {
                        y.red = 0;
                        x.parent.red = 0;
                        x.parent.parent.red = 1;
                        x = x.parent.parent;
                    } 
                    else 
                    {
                        if( x == x.parent.left ) 
                        {
                            x = x.parent;
                            rightRotate( x );
                        }
                        x.parent.red = 0;
                        x.parent.parent.red = 1;
                        leftRotate( x.parent.parent );
                    }
                }
            }
            root.left.red = 0;
            return( z );
        } // Insert()

        public function nextNode( x:Node ):Node 
        {
            var y:Node = x.right;

            if( y != nil ) 
            {
                while( y.left != nil ) y = y.left;
                return( y );
            }
            // else
            y = x.parent;
            while( x == y.right ) 
            {
                x = y;
                y = y.parent;
            }
            if( y == root ) return( nil );
            return( y );
        }

        public function prevNode( x:Node ):Node 
        {
            var y:Node = x.left;
      
            if( y != nil ) 
            {
                while( y.right != nil ) y = y.right;
                return( y );
            }
            // else
            y = x.parent;
            while( x == y.left ) 
            {
                if( y == root ) return( nil );
                x = y;
                y = y.parent;
            }
            return( y );
        }

        public function find( key:int ):Node 
        {
            var x:Node = root.left;

            while( x != nil ) 
            {
                if( key < x.key ) x = x.left;
        else if( key > x.key ) x = x.right;
        else return( x );
            }
            return( null );
        }

        public function findRange( low:int, high:int ):Array 
        {
            var ret:Array = new Array( );
            var x:Node = root.left;
            var lastBest:Node = nil;

            while( x != nil ) 
            {
                if( x.key > high ) 
                {
                    x = x.left;
                } 
                else 
                {
                    lastBest = x;
                    x = x.right;
                }
            }
            while( (lastBest != nil) && (low <= lastBest.key) ) 
            {
                ret.push( lastBest );
                lastBest = prevNode( lastBest );
            }
            return( ret );
        }

        private function leftRotate( x:Node ):void 
        {
            var y:Node;

            y = x.right;
            x.right = y.left;

            if( y.left != nil ) y.left.parent = x;
            y.parent = x.parent;

            if( x == x.parent.left ) 
            {
                x.parent.left = y;
            } 
            else 
            {
                x.parent.right = y;
            }
            y.left = x;
            x.parent = y;
        }

        private function rightRotate( y:Node ):void 
        {
            var x:Node;

            x = y.left;
            y.left = x.right;

            if( x.right != nil ) x.right.parent = y;

            x.parent = y.parent;
            if( y == y.parent.left ) 
            {
                y.parent.left = x;
            } 
            else 
            {
                y.parent.right = x;
            }

            x.right = y;
            y.parent = x;
        }

        private function deleteFixUp( x:Node ):void 
        {
            var w:Node;
            var rootLeft:Node = root.left;

            while( (x.red == 0) && (x != rootLeft) ) 
            {
                if( x == x.parent.left ) 
                {
                    w = x.parent.right;
                    if( w.red ) 
                    {
                        w.red = 0;
                        x.parent.red = 1;
                        leftRotate( x.parent );
                        w = x.parent.right;
                    }
                    if( (w.right.red == 0) && (w.left.red == 0) ) 
                    {
                        w.red = 1;
                        x = x.parent;
                    } 
                    else 
                    {
                        if( w.right.red == 0 ) 
                        {
                            w.left.red = 0;
                            w.red = 1;
                            rightRotate( w );
                            w = x.parent.right;
                        }
                        w.red = x.parent.red;
                        x.parent.red = 0;
                        w.right.red = 0;
                        leftRotate( x.parent );
                        x = rootLeft; // this is to exit while loop
                    }
                } 
                else 
                {
                    // same as above but with left and right switched
                    w = x.parent.left;
                    if( w.red ) 
                    {
                        w.red = 0;
                        x.parent.red = 1;
                        rightRotate( x.parent );
                        w = x.parent.left;
                    }
                    if( (w.right.red == 0) && (w.left.red == 0) ) 
                    {
                        w.red = 1;
                        x = x.parent;
                    } 
                    else 
                    {
                        if( w.left.red == 0 ) 
                        {
                            w.right.red = 0;
                            w.red = 1;
                            leftRotate( w );
                            w = x.parent.left;
                        }
                        w.red = x.parent.red;
                        x.parent.red = 0;
                        w.left.red = 0;
                        rightRotate( x.parent );
                        x = rootLeft; // this is to exit while loop
                    }
                }
            }
            x.red = 0;
        } // DeleteFixUp
    }
}
