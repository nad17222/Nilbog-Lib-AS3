package com.nilbog.random 
{
    import com.nilbog.random.implementations.IRNGImplementation;    
    import com.nilbog.random.implementations.MersenneTwister;    
    
    import asunit.framework.TestCase;
    
    import com.nilbog.functional.map;
    import com.nilbog.util.array.wrapArrayCallback;
    
    import flash.utils.getTimer;    	

    /**
	 * @author mark hawley
	 */
	public class RNGTest extends TestCase 
	{	
		public function RNGTest(testMethod:String = null)
		{
			super(testMethod);
		}

        public function testRange() :void
		{
            var mt:IRNGImplementation = new MersenneTwister();
            RNG.initialize( mt );
            var results:Array = [];
			for (var i:uint=0; i < 1000; i++)
			{
				results.push( RNG.random() );	
			}
			
			assertTrue("Results are 0 < result < 1", results.every(wrapArrayCallback(function (item:Number) :Boolean
			{
				if ( 0 <= item && item <= 1 )
				{
					return true;
				}
				else
				{
					return false;
				}
			})));
		}
		
		public function testSeeded() :void
		{
			var a:Array = [];
			var b:Array = [];
			
            var mt:IRNGImplementation = new MersenneTwister(0);
            RNG.initialize(mt);
			for (var i:uint=0; i < 100; i++)
			{
				a.push( RNG.random() );	
			}
			RNG.seed(0);
			for (var j:uint=0; j < 100; j++)
			{
				b.push( RNG.random() );	
			}
			
			// a and b should be in lockstep
			var sames:Array = map(function (a:Number, b:Number) :Boolean
			{
				return a == b;
			}, a, b);
			
			assertTrue("All match from same seed.", sames.every(wrapArrayCallback(function (item:Boolean) :Boolean
			{
				return item;
			})));
			
			var z:Array = [];
			
			RNG.seed(getTimer());
			for (var k:uint=0; k < 100; k++)
			{
				z.push( RNG.random() );	
			}
			
			// z should be different
			var differences:Array = map(function (a:Number, b:Number) :Boolean
			{
				return a != b;
			}, a, z);
			
			assertTrue("All different from different seed..", differences.every(wrapArrayCallback(function (item:Boolean) :Boolean
			{
				return item;
			})));
		}
	}
}
