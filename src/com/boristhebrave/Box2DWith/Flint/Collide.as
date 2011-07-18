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

	import org.flintparticles.common.actions.ActionBase;
	import org.flintparticles.common.emitters.Emitter;
	import org.flintparticles.common.particles.Particle;
	import org.flintparticles.twoD.particles.Particle2D;

	/**
	 * Collide method updates particles containing bodies with the position and
	 * velocities of the body. In other words, the inverse action to BodyRenderer.
	 * 
	 * <p>By applying this action, particles will move according to the underlying bodies.
	 * If you have both the action and BodyRenderer, then particles will move according
	 * to both Box2D collision resolution and other particle actions.</p>
	 */
	public class Collide extends ActionBase
	{
		private var scale:Number;
		public function Collide(scale:Number=NaN)
		{
			_priority = 11;
			this.scale = isNaN(scale)?BodyRenderer.defaultScale:scale;
		}
		
		/** @private */
		override public function update(emitter:Emitter, particle:Particle, time:Number):void 
		{
			var particle2D:Particle2D = particle  as Particle2D;
			var body:b2Body = particle.dictionary[BodyRenderer.BODY_KEY];
			if (body)
			{
				particle2D.x = body.GetPosition().x*scale;
				particle2D.y = body.GetPosition().y*scale;
				particle2D.rotation = body.GetAngle();
				particle2D.velX = body.GetLinearVelocity().x*scale;
				particle2D.velY = body.GetLinearVelocity().y*scale;
				particle2D.angVelocity = body.GetAngularVelocity();
				//particle2D.mass = body.GetMass();
				//particle2D.inertia = body.GetInertia();
			}
		}
		
	}
	
}