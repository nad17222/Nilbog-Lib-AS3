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
	import Box2D.Collision.Shapes.*;
	import Box2D.Common.Math.*;
	import Box2D.Dynamics.*;

	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.initializers.InitializerBase;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.particles.*;

	/**
	 * This initializer creates bodies with the given body and shape def,
	 * and then attaches them to particles for later use with BodyRenderer.
	 * The particles velocity and position are copied over, allowing you to use
	 * Flint's usual suite of initializers as well as rigid bodies.
	 * 
	 * <p>If you wish to do further initialization, create a new initializer,
	 * and ensure it has lower default priority than BodyInitializer.</p>
	 */
	public class BodyInit extends InitializerBase
	{
		/** The world which bodies will be created for. */
		public var world:b2World;
		/** The body definition used to create bodies. SetMassFromShapes is always used to define the body mass. */
		public var bodyDef:b2BodyDef;
		/** An array of b2ShapeDef used to fill the body with shapes. */
		public var shapeDefs:Array/*b2ShapeDef*/;
		/** The scaling factor to use when initialzing body properties from particle properties. */
		public var scale:Number;

		/**
		 * Creates a new initializer, attached to the given world.
		 * @param	world The world attached to.
		 * @param	bodyDef	The definition used to create bodies for each particle
		 * @param	shapes An array of b2ShapeDef to create inside the body.
		 * @param	scale The scaling factor to use in pixels/unit for initializing the position and velocity of the body given the particle properties.
		 */
		public function BodyInit(world:b2World, bodyDef:b2BodyDef, shapeDefs:Array/*b2ShapeDef*/,scale:Number = NaN)
		{
			_priority = -10;
			this.world = world;
			this.bodyDef = bodyDef;
			this.shapeDefs = shapeDefs;
			this.scale = scale;
		}

		/** @private */
		override public function initialize(emitter:Emitter, particle:Particle):void 
		{
			super.initialize( emitter, particle );
			if (particle.dictionary[BodyRenderer.BODY_KEY])
				return;
			var body:b2Body = world.CreateBody( bodyDef );
			for each(var shapeDef:b2ShapeDef in shapeDefs)
			{
				body.CreateShape( shapeDef );
			}
			body.SetMassFromShapes( );
			var particle2D:Particle2D = particle as Particle2D;
			body.SetXForm( new b2Vec2( particle2D.x / scale, particle2D.y / scale ), particle2D.rotation );
			body.SetLinearVelocity( new b2Vec2( particle2D.velX / scale, particle2D.velY / scale ) );
			body.SetAngularVelocity( particle2D.angVelocity );
			particle.dictionary[BodyRenderer.BODY_KEY] = body;
			particle.dictionary[BodyRenderer.OWNSBODY_KEY] = true;
		}
	}
}