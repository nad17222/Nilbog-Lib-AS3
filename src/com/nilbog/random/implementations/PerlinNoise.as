package com.nilbog.random.implementations 
{
	import com.nilbog.random.RNG;

	import flash.display.BitmapData;

	/**
	 * @author markhawley
     * 
     * Adapted from nl.ronvalstar.OptimizedPerlin.as. A very slow RNG 
     * implementation that can also be used to generate 3D perlin noise.
     */
    public class PerlinNoise implements IRNGImplementation
    {
        private static const p:Array = 
		[ 
					151,160,137,91,90,15,131,13,201,95,
					96,53,194,233,7,225,140,36,103,30,69,
					142,8,99,37,240,21,10,23,190,6,148,
					247,120,234,75,0,26,197,62,94,252,
					219,203,117,35,11,32,57,177,33,88,
					237,149,56,87,174,20,125,136,171,
					168,68,175,74,165,71,134,139,48,27,
					166,77,146,158,231,83,111,229,122,
					60,211,133,230,220,105,92,41,55,46,
					245,40,244,102,143,54,65,25,63,161,
					1,216,80,73,209,76,132,187,208,89,
					18,169,200,196,135,130,116,188,159,
					86,164,100,109,198,173,186,3,64,52,
					217,226,250,124,123,5,202,38,147,118,
					126,255,82,85,212,207,206,59,227,47,
					16,58,17,182,189,28,42,223,183,170,
					213,119,248,152,2,44,154,163,70,221,
					153,101,155,167,43,172,9,129,22,39,
					253,19,98,108,110,79,113,224,232,
					178,185,112,104,218,246,97,228,251,
					34,242,193,238,210,144,12,191,179,
					162,241,81,51,145,235,249,14,239,
					107,49,192,214,31,181,199,106,157,
					184,84,204,176,115,121,50,45,127,4,
					150,254,138,236,205,93,222,114,67,29,
					24,72,243,141,128,195,78,66,215,61,
					156,180,151,160,137,91,90,15,131,13,
					201,95,96,53,194,233,7,225,140,36,
					103,30,69,142,8,99,37,240,21,10,23,
					190,6,148,247,120,234,75,0,26,197,
					62,94,252,219,203,117,35,11,32,57,
					177,33,88,237,149,56,87,174,20,125,
					136,171,168,68,175,74,165,71,134,139,
					48,27,166,77,146,158,231,83,111,229,
					122,60,211,133,230,220,105,92,41,55,
					46,245,40,244,102,143,54,65,25,63,
					161,1,216,80,73,209,76,132,187,208,
					89,18,169,200,196,135,130,116,188,
					159,86,164,100,109,198,173,186,3,64,
					52,217,226,250,124,123,5,202,38,147,
					118,126,255,82,85,212,207,206,59,
					227,47,16,58,17,182,189,28,42,223,
					183,170,213,119,248,152,2,44,154,
					163,70,221,153,101,155,167,43,172,9,
					129,22,39,253,19,98,108,110,79,113,
					224,232,178,185,112,104,218,246,97,
					228,251,34,242,193,238,210,144,12,
					191,179,162,241,81,51,145,235,249,
					14,239,107,49,192,214,31,181,199,
					106,157,184,84,204,176,115,121,50,
					45,127,4,150,254,138,236,205,93,
					222,114,67,29,24,72,243,141,128,
					195,78,66,215,61,156,180 ];
					
		private var iOctaves:int = 4;
		private var fPersistence:Number = .5;
		//
		private var aOctFreq:Array; // frequency per octave
		private var aOctPers:Array; // persistence per octave
		private var fPersMax:Number;// 1 / max persistence

		private var iXoffset:Number;
		private var iYoffset:Number;
		private var iZoffset:Number;
		private const baseFactor:Number = 1 / 64;
		
		private var _seed:uint;

		/**
		 * Constructor.
		 * 
		 * @param	s	uint, a seed (optional -- random if not present)
		 */
        public function PerlinNoise(s:int=-1) 
        {   
            // no seed provided? generate a random one
            if (s < 0)
            {
            	s = Math.floor(RNG.random() * uint.MAX_VALUE );
            }
            seed = s;
            
			octFreqPers( );
        }
		
		/**
		 * Fills a bitmap with a representation of the given area of 3D space.
		 * 
		 * @param	bitmap	BitmapData
		 * @param	x	Number
		 * @param	x	Number
		 * @param	z	Number
		 */
		public function fill( bitmap:BitmapData, $x:Number = 0, $y:Number = 0, $z:Number = 0 ):void 
		{
			var s:Number = 0;
			var fFreq:Number, fPers:Number, x:Number, y:Number, z:Number;
			var xf:Number, yf:Number, zf:Number, u:Number, v:Number, w:Number;
			var x1:Number, y1:Number, z1:Number, baseX:Number, px:int, py:int;
			var i:int, X:int, Y:int, Z:int, A:int, B:int, AA:int, AB:int, BA:int, BB:int, hash:int;
			var g1:Number, g2:Number, g3:Number, g4:Number, g5:Number, g6:Number, g7:Number, g8:Number;
			var color:int;
			
			baseX = $x * baseFactor + iXoffset;
			$y = $y * baseFactor + iYoffset;
			$z = $z * baseFactor + iZoffset;
			
			var width:int = bitmap.width;
			var height:int = bitmap.height;
			
			for ( py = 0; py < height ; py++ )
			{
				$x = baseX;
				
				for ( px = 0; px < width ; px++ )
				{
					s = 0;
					
					for ( i = 0 ; i < iOctaves ;i++) 
					{
						fFreq = Number( aOctFreq[i] );
						fPers = Number( aOctPers[i] );
						
						x = $x * fFreq;
						y = $y * fFreq;
						z = $z * fFreq;
						
						xf = Math.floor( x );
						yf = Math.floor( y );
						zf = Math.floor( z );
					
						X = xf & 255;
						Y = yf & 255;
						Z = zf & 255;
					
						x -= xf;
						y -= yf;
						z -= zf;
					
						u = x * x * x * (x * (x * 6 - 15) + 10);
						v = y * y * y * (y * (y * 6 - 15) + 10);
						w = z * z * z * (z * (z * 6 - 15) + 10);
					
						A = int( p[X] ) + Y; 
						AA = int( p[A] ) + Z;
						AB = int( p[int( A + 1 )] ) + Z;
						B = int( p[int( X + 1 )] ) + Y;
						BA = int( p[B] ) + Z;
						BB = int( p[int( B + 1 )] ) + Z;
					
						x1 = x - 1;
						y1 = y - 1;
						z1 = z - 1;
					
						hash = int( p[int( BB + 1 )] ) & 15;
						g1 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y1) : (hash < 8 ? -x1 : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x1 : z1 ) : hash < 4 ? -y1 : ( hash == 14 ? -x1 : -z1 ));
					
						hash = int( p[int( AB + 1 )] ) & 15;
						g2 = ((hash & 1) == 0 ? (hash < 8 ? x : y1) : (hash < 8 ? -x : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x : z1 ) : hash < 4 ? -y1 : ( hash == 14 ? -x : -z1 ));
					
						hash = int( p[int( BA + 1 )] ) & 15;
						g3 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y ) : (hash < 8 ? -x1 : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x1 : z1 ) : hash < 4 ? -y : ( hash == 14 ? -x1 : -z1 ));
					
						hash = int( p[int( AA + 1 )] ) & 15;
						g4 = ((hash & 1) == 0 ? (hash < 8 ? x : y ) : (hash < 8 ? -x : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x : z1 ) : hash < 4 ? -y : ( hash == 14 ? -x : -z1 ));
					
						hash = int( p[BB] ) & 15;
						g5 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y1) : (hash < 8 ? -x1 : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x1 : z  ) : hash < 4 ? -y1 : ( hash == 14 ? -x1 : -z  ));
					
						hash = int( p[AB] ) & 15;
						g6 = ((hash & 1) == 0 ? (hash < 8 ? x : y1) : (hash < 8 ? -x : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x : z  ) : hash < 4 ? -y1 : ( hash == 14 ? -x : -z  ));
					
						hash = int( p[BA] ) & 15;
						g7 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y ) : (hash < 8 ? -x1 : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x1 : z  ) : hash < 4 ? -y : ( hash == 14 ? -x1 : -z  ));
					
						hash = int( p[AA] ) & 15;
						g8 = ((hash & 1) == 0 ? (hash < 8 ? x : y ) : (hash < 8 ? -x : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x : z  ) : hash < 4 ? -y : ( hash == 14 ? -x : -z  ));
				
						g2 += u * (g1 - g2);
						g4 += u * (g3 - g4);
						g6 += u * (g5 - g6);
						g8 += u * (g7 - g8);
						
						g4 += v * (g2 - g4);
						g8 += v * (g6 - g8);
					
						s += ( g8 + w * (g4 - g8)) * fPers;
					}
					
					color = int( ( s * fPersMax + 1 ) * 128 );
					bitmap.setPixel32( px, py, 0xff000000 | color << 16 | color << 8 | color );
					
					$x += baseFactor;
				}
				
				$y += baseFactor;
			}
		}
		
		/**
		 * Returns the value at a certain part of the current 3D perlin noise 
		 * space.
		 * 
		 * @param	x	Number
		 * @param	x	Number
		 * @param	z	Number
		 * 
		 * @return Number
		 */
		public function noise( $x:Number, $y:Number = 1, $z:Number = 1 ):Number 
		{	
			var s:Number = 0;
			var fFreq:Number, fPers:Number, x:Number, y:Number, z:Number;
			var xf:Number, yf:Number, zf:Number, u:Number, v:Number, w:Number;
			var x1:Number, y1:Number, z1:Number;
			var X:int, Y:int, Z:int, A:int, B:int, AA:int, AB:int, BA:int, BB:int, hash:int;
			var g1:Number, g2:Number, g3:Number, g4:Number, g5:Number, g6:Number, g7:Number, g8:Number;
			
			$x += iXoffset;
			$y += iYoffset;
			$z += iZoffset;
			
			for (var i:int; i < iOctaves ;i++) 
			{
				fFreq = Number( aOctFreq[i] );
				fPers = Number( aOctPers[i] );
				
				x = $x * fFreq;
				y = $y * fFreq;
				z = $z * fFreq;
				
				xf = Math.floor( x );
				yf = Math.floor( y );
				zf = Math.floor( z );
			
				X = xf & 255;
				Y = yf & 255;
				Z = zf & 255;
			
				x -= xf;
				y -= yf;
				z -= zf;
			
				u = x * x * x * (x * (x * 6 - 15) + 10);
				v = y * y * y * (y * (y * 6 - 15) + 10);
				w = z * z * z * (z * (z * 6 - 15) + 10);
			
				A = int( p[X] ) + Y; 
				AA = int( p[A] ) + Z;
				AB = int( p[int( A + 1 )] ) + Z;
				B = int( p[int( X + 1 )] ) + Y;
				BA = int( p[B] ) + Z;
				BB = int( p[int( B + 1 )] ) + Z;
			
				x1 = x - 1;
				y1 = y - 1;
				z1 = z - 1;
			
				hash = int( p[int( BB + 1 )] ) & 15;
				g1 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y1) : (hash < 8 ? -x1 : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x1 : z1 ) : hash < 4 ? -y1 : ( hash == 14 ? -x1 : -z1 ));
			
				hash = int( p[int( AB + 1 )] ) & 15;
				g2 = ((hash & 1) == 0 ? (hash < 8 ? x : y1) : (hash < 8 ? -x : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x : z1 ) : hash < 4 ? -y1 : ( hash == 14 ? -x : -z1 ));
			
				hash = int( p[int( BA + 1 )] ) & 15;
				g3 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y ) : (hash < 8 ? -x1 : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x1 : z1 ) : hash < 4 ? -y : ( hash == 14 ? -x1 : -z1 ));
			
				hash = int( p[int( AA + 1 )] ) & 15;
				g4 = ((hash & 1) == 0 ? (hash < 8 ? x : y ) : (hash < 8 ? -x : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x : z1 ) : hash < 4 ? -y : ( hash == 14 ? -x : -z1 ));
			
				hash = int( p[BB] ) & 15;
				g5 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y1) : (hash < 8 ? -x1 : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x1 : z  ) : hash < 4 ? -y1 : ( hash == 14 ? -x1 : -z  ));
			
				hash = int( p[AB] ) & 15;
				g6 = ((hash & 1) == 0 ? (hash < 8 ? x : y1) : (hash < 8 ? -x : -y1)) + ((hash & 2) == 0 ? hash < 4 ? y1 : ( hash == 12 ? x : z  ) : hash < 4 ? -y1 : ( hash == 14 ? -x : -z  ));
			
				hash = int( p[BA] ) & 15;
				g7 = ((hash & 1) == 0 ? (hash < 8 ? x1 : y ) : (hash < 8 ? -x1 : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x1 : z  ) : hash < 4 ? -y : ( hash == 14 ? -x1 : -z  ));
			
				hash = int( p[AA] ) & 15;
				g8 = ((hash & 1) == 0 ? (hash < 8 ? x : y ) : (hash < 8 ? -x : -y )) + ((hash & 2) == 0 ? hash < 4 ? y : ( hash == 12 ? x : z  ) : hash < 4 ? -y : ( hash == 14 ? -x : -z  ));
				
				g2 += u * (g1 - g2);
				g4 += u * (g3 - g4);
				g6 += u * (g5 - g6);
				g8 += u * (g7 - g8);
				
				g4 += v * (g2 - g4);
				g8 += v * (g6 - g8);
			
				s += ( g8 + w * (g4 - g8)) * fPers;
			}
			
			return ( s * fPersMax + 1 ) * .5;
		}

		/**
		 * Seed mutator.
		 * 
		 * @param	s	uint
		 */
        public function set seed(s:uint):void 
        {
        	_seed = s;
        	
           	iXoffset = _seed = (_seed * 16807) % 2147483647;
			iYoffset = _seed = (_seed * 16807) % 2147483647;
			iZoffset = _seed = (_seed * 16807) % 2147483647;
        }
        /**
         * Returns the current seed.
         * 
         * @return int
         */
        public function get seed() :uint
        {
        	return _seed;
        }

        /**
         * Returns a random number within [0, 1)
         * 
         * @return Number
         */
        public function random():Number 
        {
            return noise(RNG.random(), RNG.random(), RNG.random());
        }
        
        /**
         * Gets the perlin octaves.
         * 
         * @return int
         */
        public function get octaves():int 
		{
			return iOctaves;
		}
		/**
		 * Sets the perlin octaves.
		 * 
		 * @param	_iOctaves	int
		 */
		public function set octaves(_iOctaves:int):void 
		{
			iOctaves = _iOctaves;
			octFreqPers( );
		}

		/**
		 * Gets the perlin falloff.
		 * 
		 * @return Number
		 */
		public function get falloff():Number 
		{
			return fPersistence;
		}
		/**
		 * Sets the perlin falloff.
		 * 
		 * @param	_fPersistence	Number
		 */
		public function set falloff(_fPersistence:Number):void 
		{
			fPersistence = _fPersistence;
			octFreqPers( );
		}
		
		/**
		 * Corrects values after a change in falloff or number of octaves.
		 */
		private function octFreqPers():void 
		{
			var fFreq:Number, fPers:Number;
			
			aOctFreq = [];
			aOctPers = [];
			fPersMax = 0;
			
			for (var i:int; i < iOctaves ;i++) 
			{
				fFreq = Math.pow( 2, i );
				fPers = Math.pow( fPersistence, i );
				fPersMax += fPers;
				aOctFreq.push( fFreq );
				aOctPers.push( fPers );
			}
			
			fPersMax = 1 / fPersMax;
		}
    }
}
