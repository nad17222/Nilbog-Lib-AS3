package com.nilbog.sfx.boids 
{
    import com.nilbog.sfx.boids.Obstacle;
    
    import flash.display.MovieClip;    

    public class BoidSystem extends MovieClip
    {
        private var boids:Array = [];
        private var obstacles:Array = [];

        public function BoidSystem() 
        {
        }

        public function run():void 
        {
            getAverages( );
            moveBoids( );
        }

        public function addObstacle(tx:Number, ty:Number, radius:Number):void 
        {
            var obs:Obstacle = new Obstacle( );
            obs.x = tx;
            obs.y = ty;
            obstacles.push( obs );
            addChild( obs );
        }

        public function moveBoids():void 
        {
            var b:Boid;
            for (var i:int = 0; i < boids.length ;++i) 
            {
                b = boids[i];
                rule1( b );
                rule2( b );
                rule3( b );
                rule4( b );
                b.run( );
            }
        }

        private function rule1(b:Boid):void 
        {
            var k:Number = .015;
            //var com:Object = centerOfMass;
            var com:Object = b.centerOfMass;
            var xm:Number = (com.x - b.x) * k;
            var ym:Number = (com.y - b.y) * k;
            b.xvelocity += xm;
            b.yvelocity += ym;
        }

        private function rule2(b:Boid):void 
        {
            var minDis:Number = 30;
            var k:Number = 1;
			
            for (var i:int = 0; i < b.getNeighbors( ).length ;++i) 
            {
                var b2:Boid = b.getNeighbors( )[i];
                var dis:Number = getDistance( b, b2 );
                if (dis < minDis) 
                {
                    var f:Number = 1 - dis / minDis;
                    f = Math.min( 1, f );
                    var ang:Number = Math.atan2( b2.y - b.y, b2.x - b.x );
                    var maxNudge:Number = 5;
                    var nudge:Number = f * maxNudge;
                    var xn:Number = nudge * Math.cos( ang );
                    var yn:Number = nudge * Math.sin( ang );
                    b.xvelocity += -xn;
                    b.yvelocity += -yn;
                }
            }
        }

        private function rule3(b:Boid):void 
        {
            var k:Number = 1 / 10;
            for each (var boid:Boid in boids) 
            {
                var xv:Number = (boid.averageVelocity.xvelocity - boid.xvelocity) * k;
                var yv:Number = (boid.averageVelocity.yvelocity - boid.yvelocity) * k;
                boid.xvelocity += xv;
                boid.yvelocity += yv;
            }
        }

        private function rule4(b:Boid):void 
        {
            for (var i:int = 0; i < obstacles.length ;++i) 
            {
                var obs:Obstacle = obstacles[i];
                var dis:Number = getObstacleDistance( b, obs );
                if (dis < 75) 
                {
                    var m:Number = Math.PI / 2;
					
                    var bAng:Number = b.getAngle( );
                    var leftAng:Number = bAng - m;
                    var rightAng:Number = bAng + m;
                    var b2Ang:Number = Math.atan2( obs.y - b.y, obs.x - b.x );
                    if (isBetween( leftAng, rightAng, b2Ang )) 
                    {
                        var dir:Number = b2Ang < bAng ? 1 : -1;
                        var amt:Number = 2;
                        var sp:Number = 1;
                        bAng += dir * amt;
                        b.xvelocity += sp * Math.cos( bAng );
                        b.yvelocity += sp * Math.sin( bAng );
                        if (b.y > obs.y && getChildIndex( b ) < getChildIndex( obs )) 
                        {
                            swapChildren( b, obs );
                        } else if (b.y < obs.y && getChildIndex( b ) > getChildIndex( obs )) 
                        {
                            swapChildren( b, obs );
                        }
                    }
                }
            }
        }

        private function getDistance(b1:Boid, b2:Boid):Number 
        {
            return Math.sqrt( Math.pow( b1.x - b2.x, 2 ) + Math.pow( b1.y - b2.y, 2 ) );
        }

        private function getObstacleDistance(b1:Boid, b2:Obstacle):Number 
        {
            return Math.sqrt( Math.pow( b1.x - b2.x, 2 ) + Math.pow( b1.y - b2.y, 2 ) );
        }

        public function checkCone(b:Boid, b2:Boid):void 
        {
            //b.addNeighbor(b2);
            var m:Number = Math.PI / 2;
			
            var bAng:Number = b.getAngle( );
            var leftAng:Number = bAng - m;
            var rightAng:Number = bAng + m;
			
            var b2Ang:Number = Math.atan2( b2.y - b.y, b2.x - b.x );
            if (isBetween( leftAng, rightAng, b2Ang )) 
            {
                b.addNeighbor( b2 );
            }
        }

        private function isBetween(leftAng:Number, rightAng:Number, ang:Number):Boolean 
        {
            var between:Boolean = false;
            while(leftAng < 0) 
            {
                leftAng += Math.PI * 2;
            }
            while(rightAng < 0) 
            {
                rightAng += Math.PI * 2;
            }
            while(ang < 0) 
            {
                ang += Math.PI * 2;
            }
            if (ang > leftAng && ang < rightAng) 
            {
                between = true;
            }
            if (leftAng > Math.PI && rightAng < Math.PI && ((ang > leftAng) || (ang < rightAng))) 
            {
                between = true;
            }
            return between;
        }

        public function getBoids():Array 
        {
            return boids;
        }

        private function getAverages():void 
        {
            //get averages
            var b:Boid;
            var minDis:Number = 100;
            for (var i:int = 0; i < boids.length ;++i) 
            {
                b = boids[i];
                b.reset( );
            }
            for (i = 0; i < boids.length ;++i) 
            {
                b = boids[i];
                for (var j:int = i + 1; j < boids.length ;++j) 
                {
                    var b2:Boid = boids[j];
                    if (getDistance( b, b2 ) < minDis) 
                    {
                        checkCone( b, b2 );
                        checkCone( b2, b );
                    }
                }
            }
            for (i = 0; i < boids.length ;++i) 
            {
                b = boids[i];
                b.determineAverages( );
            }
        }

        public function addBoid(b:Boid):Boid 
        {
            boids.push( b );
            addChild( b );
            return b;
        }
    }
}