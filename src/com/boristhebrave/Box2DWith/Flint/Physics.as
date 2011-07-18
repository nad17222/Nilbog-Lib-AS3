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
	import Box2D.Collision.b2AABB;
	import Box2D.Common.Math.b2Vec2;
	import Box2D.Dynamics.b2World;

	import org.flintparticles.common.activities.ActivityBase;
	import org.flintparticles.common.emitters.Emitter;

	import flash.geom.Point;
	import flash.utils.Dictionary;

	/**
	 * This activity creates a Box2D world, and manages the interaction between particles and the world.
	 * This class is mainly for convenience, providing a way to add true physics to an Emitter with the
	 * least fuss.
	 * 
	 * <p>It is still necessary to initialize particles with a body, using one of the provided initializers.</p>
	 */
	public class Physics extends ActivityBase
	{
		/** The physical world. You need this reference for initializers. */
		public var world:b2World;
		private var rendererPerEmitter:Dictionary = new Dictionary();
		private var collidePerEmitter:Dictionary = new Dictionary();
		private var scale:Number;
		private var time:Number;
		private var emitters:Array/*Emitter2D*/ = [];
		
		/** Stability parameter for position correction. @see Box2D.Dynamics.b2World#Step()*/
		public var positionIterations:int = 10;
		/** Stability parameter for velocity resolution. @see Box2D.Dynamics.b2World#Step()*/
		public var velocityIterations:int = 10;
		
		public function Physics(lowerBound:Point=null, upperBound:Point=null,scale:Number=NaN)
		{
			scale = isNaN(scale)?BodyRenderer.defaultScale:scale;
			if (!lowerBound)
				lowerBound = new Point( -1000*scale, -1000*scale);
			if (!upperBound)	
				upperBound = new Point( 1000*scale, 1000*scale);
			var aabb:b2AABB = new b2AABB();
			aabb.lowerBound.x = lowerBound.x/scale;
			aabb.lowerBound.y = lowerBound.y/scale;
			aabb.upperBound.x = upperBound.x/scale;
			aabb.upperBound.y = upperBound.y/scale;
			
			world = new b2World(aabb, new b2Vec2(), false);
			
			this.scale = scale;
		}
		
		/** @private */
		override public function addedToEmitter(emitter:Emitter):void 
		{
			super.initialize(emitter);
			var renderer:BodyRenderer = new BodyRenderer(world, scale);
			rendererPerEmitter[emitter] = renderer;
			renderer.addEmitter(emitter);
			var collide:Collide = new Collide(scale);
			collidePerEmitter[emitter] = collide;
			emitter.addAction(collide);
			emitters.push(emitter);
		}
		
		/** @private */
		override public function removedFromEmitter(emitter:Emitter):void 
		{
			super.removedFromEmitter(emitter);
			var renderer:BodyRenderer = rendererPerEmitter[emitter];
			renderer.removeEmitter(emitter);
			rendererPerEmitter[emitter] = null;
			var collide:Collide = collidePerEmitter[emitter];
			emitter.removeAction(collide);
			collidePerEmitter[emitter] = null;
			emitters.splice(emitters.indexOf(emitter), 1);
		}
		
		/** @private */
		override public function update(emitter:Emitter, time:Number):void 
		{
			super.update(emitter, time);
			//Only update for first emitter, or else we'll run too fast
			if (emitter != emitters[0])
				return;
			world.Step(time, velocityIterations);
		}
		
	}
	
}