package com.nilbog.collections {	import com.nilbog.collections.AbstractCollection;	import com.nilbog.dbc.precondition;	import com.nilbog.errors.AbstractMethodCallError;	import com.nilbog.util.instantiatedAs;		/**	 * @author markhawley	 * 	 * Base vector-based collection iterator.	 */	internal class AbstractVectorIterator extends AbstractIterator	{		protected var impl:Vector.<*>;		protected var index:int = -1;				/**		 * Constructor.		 * 		 * @param	collection	ICollection		 * @param	implementation	Classs		 * 		 * @throws	AbstractMethodCallError		 */		public function AbstractVectorIterator( collection:AbstractCollection, implementation:Vector.<*> )		{			precondition(collection != null);			precondition(implementation != null);						super( collection );						if (instantiatedAs(this, AbstractVectorIterator))			{				throw new AbstractMethodCallError("Cannot " +					"instantiate Abstract class.");			}						impl = implementation;		}	}}