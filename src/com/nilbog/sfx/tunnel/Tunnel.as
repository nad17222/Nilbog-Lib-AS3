package com.nilbog.sfx.tunnel 
{
    import com.nilbog.sfx.tunnel.TunnelSegment;
    
    import org.flintparticles.common.actions.Age;
    import org.flintparticles.common.actions.ScaleImage;
    import org.flintparticles.common.counters.Steady;
    import org.flintparticles.common.initializers.ImageClass;
    import org.flintparticles.common.initializers.Lifetime;
    import org.flintparticles.twoD.actions.Rotate;
    import org.flintparticles.twoD.emitters.Emitter2D;
    import org.flintparticles.twoD.initializers.Position;
    import org.flintparticles.twoD.initializers.RotateVelocity;
    import org.flintparticles.twoD.initializers.Velocity;
    import org.flintparticles.twoD.zones.PointZone;
    
    import flash.geom.Point;    

    /**
     * @author markhawley
     */
    public class Tunnel extends Emitter2D
    {
        public function Tunnel()
        {
            counter = new Steady( 10 );
			
            addInitializer( new ImageClass( TunnelSegment ) );
            addInitializer( new Position( new PointZone( new Point( 0, 0 ) ) ) );
            addInitializer( new Velocity( new PointZone( new Point( 0, 0 ) ) ) );
            addInitializer( new Lifetime( 5 ) );
            addInitializer( new RotateVelocity( 1 ) );
			
            //addAction(new Accelerate(1, 1));
            addAction( new ScaleImage( .005, 10 ) );
            //addAction(new Move());
            addAction( new Age( ) );
            addAction( new Rotate( ) );
			//addAction( new DeathZone( new RectangleZone( 0, 0, 550, 400), true));
        }
    }
}
