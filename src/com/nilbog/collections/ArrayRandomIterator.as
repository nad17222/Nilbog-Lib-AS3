package com.nilbog.collections {    import com.nilbog.collections.AbstractArrayIterator;
    import com.nilbog.collections.AbstractCollection;
    import com.nilbog.collections.IIterator;
    import com.nilbog.collections.events.CollectionEvent;
    import com.nilbog.errors.NoSuchElementError;
    import com.nilbog.random.RNG;	
    /**	 * @author markhawley	 * 	 * Iterator that returns a random element each time next() is 	 * called.	 */	public class ArrayRandomIterator extends AbstractArrayIterator implements IIterator 	{			/**		 * Constructor.		 * 		 * @param	collection	ICollection		 * @param	implementation	Array		 */		public function ArrayRandomIterator( collection:AbstractCollection, implementation:Array )		{			super( collection, implementation );		}		/**		 * Returns true as long as the collection is not empty.		 * 		 * @return Boolean		 */		public function hasNext():Boolean		{			if (!collection.isEmpty())			{				return true;			}			else			{				return false;			}		}				/**		 * Returns a random element in the collection.		 * 		 * @return	*		 */		public function next():*		{			if (!hasNext())			{				throw new NoSuchElementError();			}			index = getRandomIndex();			return impl[index];			}				/**		 * Does nothing at all.		 */		public function reset():void		{			// do nothing		}				/**		 * Returns a random index within the implementation array's		 * bounds.		 * 		 * @return int		 */		protected function getRandomIndex() :int		{			return Math.floor(RNG.random() * impl.length);		}				/**		 * Handles CollectionEvent.CHANGE on iterated collection by completely		 * ignoring it -- random iterators don't mind the contents of the		 * collection rambling around.		 * 		 * @param	event	CollectionEvent		 */		override protected function onCollectionChange( event:CollectionEvent ) :void		{			// no problem, it's random anyway		}	}}