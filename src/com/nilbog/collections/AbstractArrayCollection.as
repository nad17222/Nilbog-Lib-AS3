package com.nilbog.collections {	import com.nilbog.assertions.assert;	import com.nilbog.dbc.postcondition;	import com.nilbog.dbc.precondition;	import com.nilbog.errors.AbstractMethodCallError;	import com.nilbog.util.array.wrapArrayCallback;	import com.nilbog.util.instantiatedAs;	import flash.events.IEventDispatcher;	/**	 * @author markhawley	 * 	 * Defines methods of a basic array-based collection. Not to	 * be directly instantiated.	 */	internal class AbstractArrayCollection extends AbstractCollection implements ICollection, IEventDispatcher	{		// internal for iterator access		internal var impl:Array;		/**		 * Constructor.		 * 		 * @param array	Array	(optional) to populate collection with		 * @param type	Class	(optional) for typed collection		 * 		 * @throws AbstractMethodCallError if directly instantiated.		 */		public function AbstractArrayCollection( array:Array=null, type:Class=null)		{				impl = [];						super( array, type );						if (instantiatedAs(this, AbstractArrayCollection))			{				throw new AbstractMethodCallError("Cannot " +					"instantiate Abstract class.");			}						postcondition( impl.length >= 0 );		}		/**		 * Returns the number of items in the collection.		 * 		 * @return uint		 */		override public function size() :uint		{			precondition(impl != null, "Implementation must exist.");						return impl.length;		}				/**		 * Returns true if the collection is empty.		 * 		 * @return Boolean		 */		override public function isEmpty():Boolean		{			precondition(impl != null, "Implementation must exist.");						return size() == 0;		}				/**		 * Returns true if the collection contains the given item.		 * 		 * @param obj *		 * 		 * @return Boolean		 */		override public function contains(obj:*):Boolean		{			precondition(impl != null, "Implementation must exist.");						return impl.indexOf(obj) != -1;		}				/**		 * Adds an item to the collection. Returns true if successful.		 * 		 * @param	obj	*		 * 		 * @return	Boolean		 */		override public function add(obj:*):Boolean		{			precondition(impl != null, "Implementation must exist.");						if (valueType != null && !(obj is valueType))			{				throw new TypeError("Can't add '" + obj + "' to typed " +					"collection.");			}						impl.push( obj );			onChange();			onAdd([ obj ]);						postcondition(size() >= 1);						return true;		}				override public function clear() :void		{			precondition(impl != null, "Implementation must exist.");						impl.forEach(wrapArrayCallback(function (item:*) :void 			{				remove(item);			}), this);						onRefresh();		}				/**		 * Removes an item from the collection. Returns true if the		 * object can be found and removed.		 * 		 * @param	obj *		 * 		 * @return Boolean		 */		override public function remove(obj:*):Boolean		{			precondition(impl != null, "Implementation must exist.");						var index:int = impl.indexOf(obj);			var removedItem:Boolean = false;			if (index > -1)			{				impl.splice( index, 1 );				if (valueType != null)				{					assert(obj is valueType);				}								onChange();				onRemove([obj]);				removedItem = true;			}			else			{				removedItem = false;			}						postcondition(impl.length >= 0);						return removedItem;		}				/**		 * Returns an iterator for the collection. The default		 * iterator for Lists is ordered.		 * 		 * @param	type	IterationType		 * 		 * @return	IIterator		 */		override public function getIterator( type:IterationType=null ) :IIterator		{			throw new AbstractMethodCallError();			return null;		}				override public function toString() :String		{			return "[Collection: " + impl.join(", ") + "]";		}	}}