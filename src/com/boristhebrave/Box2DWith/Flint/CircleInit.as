/*
 * Copyright (c) 2009 Adam Newgas http://www.boristhebrave.com
 *
 * This software is provided 'as-is', without any express or implied
 * warranty.  In no event will the authors be held liable for any damages
 * arising from the use of this software.
 * Permission is granted to anyone to use this software for any purpose,
 * including commercial applications, and to alter it and redistribute it
 * freely, subject to the following restrictions:
 * 1. The origin of this software must not be misrepresented; you must not
 * claim that you wrote the original software. If you use this software
 * in a product, an acknowledgment in the product documentation would be
 * appreciated but is not required.
 * 2. Altered source versions must be plainly marked as such, and must not be
 * misrepresented as being the original software.
 * 3. This notice may not be removed or altered from any source distribution.
 */

package com.boristhebrave.Box2DWith.Flint 
{
	import Box2D.Collision.Shapes.b2CircleDef;
	import Box2D.Collision.Shapes.b2MassData;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2BodyDef;
	import Box2D.Dynamics.b2World;

	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.initializers.InitializerBase;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.particles.Particle2D;

	/**
	 * This initializer creates bodies with a single circle shape inside,
	 * and then attaches them to particles. You need to set the particles radius
	 * with CollisionRadiusInit.
	 */
	public class CircleInit extends InitializerBase
	{
		private var scale:Number;
		private var world:b2World;

		/**
		 * Construct a new CircleInit
		 * @param	world The world attached to. 
		 * @param	scale The scaling factor to use in pixels/unit for initializing the position and velocity of the body given the particle properties. 
		 */
		public function CircleInit(world:b2World, scale:Number = NaN)
		{
			_priority = -1;
			this.scale = isNaN( scale ) ? BodyRenderer.defaultScale : scale;
			this.world = world;
		}

		/** @private */
		override public function initialize(emitter:Emitter, particle:Particle):void 
		{
			super.initialize( emitter, particle );
			if (particle.dictionary[BodyRenderer.BODY_KEY])
				return;
			var bodyDef:b2BodyDef = new b2BodyDef( );
			var body:b2Body = world.CreateBody( bodyDef );
			var cd:b2CircleDef = new b2CircleDef( );
			cd.radius = particle.collisionRadius / scale;
			body.CreateShape( cd );
			var md:b2MassData = new b2MassData( );
			md.mass = particle.mass;
			md.I = 0.5 * cd.radius * cd.radius * md.mass;
			body.SetMass( md );
			var particle2D:Particle2D = particle as Particle2D;
			body.SetXForm( new b2Vec2( particle2D.x / scale, particle2D.y / scale ), particle2D.rotation );
			body.SetLinearVelocity( new b2Vec2( particle2D.velX / scale, particle2D.velY / scale ) );
			body.SetAngularVelocity( particle2D.angVelocity );
			particle.dictionary[BodyRenderer.BODY_KEY] = body;
			particle.dictionary[BodyRenderer.OWNSBODY_KEY] = true;
		}
	}
}