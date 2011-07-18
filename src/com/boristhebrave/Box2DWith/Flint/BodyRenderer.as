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
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2Body;
	import Box2D.Dynamics.b2World;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.common.renderers.RendererBase;
	import org.flintparticles.twoD.particles.Particle2D;
	
	/**
	 * Kinematic controller sets b2Body objects according to the motion of
	 * Particles. Particles need to have a body defined by an appropriate initializer, and must be
	 * 2D particles.
	 */
	public class BodyRenderer extends RendererBase
	{
		/** Use this key to look up the corresponding body of a particle in its dictionary.*/
		public static var BODY_KEY:* = "com.boristhebrave.Box2DWith.Flint::body";
		/**
		 * Use this key to look up the owns body value of a particle in its dictionary.
		 * The actual value is a boolean determing if the body should be destroyed when the particle is.
		 */
		public static var OWNSBODY_KEY:* = "com.boristhebrave.Box2DWith.Flint::ownsBody";
		
		/**
		 * Setting this value saves the effort of specifying the scale parameter in a lot of constructors.
		 */
		public static var defaultScale:Number = 30;
		
		/** The world to be "rendered" to. */
		private var world:b2World;
		/** The scaling factor between Flint's pixel co-ordinates and Box2D's units, in pixels/unit. */
		private var scale:Number;
		
		/**
		 * Constructs a BodyRenderer.
		 * @param	world The world to be "rendered" to.
		 * @param	scale A scaling factor between Flint's pixel co-ordinates and Box2D's units, in pixels/unit.
		 */
		public function BodyRenderer(world:b2World, scale:Number=NaN) 
		{
			this.world = world;
			this.scale = isNaN(scale)?BodyRenderer.defaultScale:scale;
		}
		
		/** @inheritDoc */
		override protected function removeParticle(particle:Particle):void 
		{
			if (particle.dictionary[OWNSBODY_KEY])
			{
				world.DestroyBody(particle.dictionary[BODY_KEY]);
			}
			super.removeParticle(particle);
		}
		
		/** @inheritDoc */
		override protected function renderParticles(particles:Array):void 
		{
			super.renderParticles(particles);
			for each(var particle:Particle2D in particles)
			{
				var body:b2Body = particle.dictionary[BODY_KEY];
				if (!body)
					continue;
				body.SetXForm(new b2Vec2(particle.x/scale, particle.y/scale), particle.rotation);
				body.SetLinearVelocity(new b2Vec2(particle.velX/scale, particle.velY/scale));
				body.SetAngularVelocity(particle.angVelocity);
			}
		}
	}
	
}