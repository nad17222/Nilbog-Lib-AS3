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
	import Box2D.Dynamics.b2Body;

	import org.flintparticles.common.particles.ParticleFactory;
	import org.flintparticles.twoD.particles.Particle2D;
	import org.flintparticles.twoD.particles.ParticleCreator2D;
	
	
	
	
	
	/**
	 * Wraps each body in a Particle2D.
	 * @param   bodies	An array of b2Body.
	 * @param   ownsBody If true, the body is destroyed when the particle dies.
	 * @param   factory	An optional particle factory to use to generate the particles.
	 * @return	An array of Particle2D.
	 */
	public function createParticles2DFromBodies(bodies:Array, ownsBody:Boolean = false, factory:ParticleFactory = null):Array
	{
		if (!factory)
			factory = new ParticleCreator2D();
		var out:Array = [];
		for each(var body:b2Body in bodies)
		{
			var particle:Particle2D = factory.createParticle() as Particle2D;
			particle.dictionary[BodyRenderer.BODY_KEY] = body;
			particle.dictionary[BodyRenderer.OWNSBODY_KEY] = ownsBody;
		}
		return out;
	}
	
}