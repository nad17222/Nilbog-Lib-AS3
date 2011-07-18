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
	import org.flintparticles.common.utils.FastWeightedArray;
	import org.flintparticles.twoD.particles.*;

	/**
	 * This initializer creates bodies with a random choice of body and shape definition,
	 * and then attaches them to particles for later use with BodyRenderer.
	 * The particles velocity and position are copied over, allowing you to use
	 * Flint's usual suite of initializers as well as rigid bodies.
	 * 
	 * <p>If you wish to do further initialization, create a new initializer,
	 * and ensure it has lower default priority than BodyInitializer.</p>
	 */
	public class BodiesInit extends InitializerBase
	{
		/** The world which bodies will be created for. */
		private var _world:b2World;
		/** The array or FastWeightedArray to choose body defs from. SetMassFromShapes is always used to define the body mass. */
		public var bodyDefs:*;
		/** An array or FastWeightedArray of arrays of b2ShapeDef to create inside the body. */
		public var shapeDefs:*;
		/** The scaling factor to use when initialzing body properties from particle properties. */
		public var scale:Number;
		
		/**
		 * Creates a new initializer, attached to the given world.
		 * @param	world The world attached to. 
		 * @param	bodyDef	The array or FastWeightedArray to choose body defs from. 
		 * @param	shapes An array or FastWeightedArray of arrays of b2ShapeDef to create inside the body.
		 * @param	scale The scaling factor to use in pixels/unit for initializing the position and velocity of the body given the particle properties. 
		 * @see org.flintparticles.common.utils.FastWeightedArray
		 */
		public function BodiesInit(world:b2World, bodyDefs:*, shapeDefs:*,scale:Number = NaN)
		{
			_priority = -10;
			this._world = world;
			this.bodyDefs = bodyDefs;
			this.shapeDefs = shapeDefs;
			this.scale = isNaN(scale)?BodyRenderer.defaultScale:scale;
		}
		
		private function randomFrom(o:*):*
		{
			if (o is Array)
				return o[int(Math.random() * o.length)];
			if (o is FastWeightedArray)
				return (o as FastWeightedArray).getRandomValue();
			return null;
		}

		/** @private */
		override public function initialize(emitter:Emitter, particle:Particle):void 
		{
			super.initialize(emitter, particle);
			if (particle.dictionary[BodyRenderer.BODY_KEY])
				return;
			var world:b2World = _world;
			var body:b2Body = world.CreateBody(randomFrom(bodyDefs));
			for each(var shapeDef:b2ShapeDef in randomFrom(shapeDefs))
			{
				body.CreateShape(shapeDef);
			}
			body.SetMassFromShapes();
			var particle2D:Particle2D = particle as Particle2D;
			body.SetXForm(new b2Vec2(particle2D.x/scale, particle2D.y/scale), particle2D.rotation);
			body.SetLinearVelocity(new b2Vec2(particle2D.velX/scale, particle2D.velY/scale));
			body.SetAngularVelocity(particle2D.angVelocity);
			particle.dictionary[BodyRenderer.BODY_KEY] = body;
			particle.dictionary[BodyRenderer.OWNSBODY_KEY] = true;
		}
		
	}
	
}