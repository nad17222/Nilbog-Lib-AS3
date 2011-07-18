package com.nilbog.random 
{
	import com.nilbog.random.implementations.DefaultRNG;
	import com.nilbog.random.implementations.IRNGImplementation;

	/**
	 * @author markhawley
	 * 
	 * The RNG class can be used via static methods, or instantiated if you need
	 * different RNGs for different components of an app.
	 */
	public class RNG 
	{
		private static var _instance:RNG;
		
		/**
		 * Sets up the default static RNG implmentation.
		 * 
		 * @param	impl	IRNGImplementation=null
		 */
		public static function initialize( impl:IRNGImplementation=null ):void
		{
			_instance = new RNG( impl );
		}
		
		/**
		 * Gets a random number from the static RNG implmentation.
		 * 
		 * @return Number, (0, 1)
		 */
		public static function random() :Number
		{
			if( _instance ==  null )
			{
				_instance = new RNG( new DefaultRNG() );
			}
			return _instance.random();
		}
		
		/**
		 * Seeds the static RNG implementation.
		 * 
		 * @param s uint
		 */
		public static function seed( s:uint ) :void
		{
			if( _instance ==  null )
			{
				_instance = new RNG( new DefaultRNG() );
			}
			_instance.seed(s);
		}
		
		private var rng:IRNGImplementation;
        /**
		 * Constructor.
		 */
		public function RNG( impl:IRNGImplementation=null )
		{
			if (null == impl)
			{
				impl = new DefaultRNG();
			}
			rng = impl;
		}

        public function random() :Number
		{
			return rng.random();
		}
		
		public function seed( s:uint ) :void
		{
			rng.seed = s;
		}
	}
}
