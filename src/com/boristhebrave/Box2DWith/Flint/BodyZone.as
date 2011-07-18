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
	import Box2D.Common.*;
	import Box2D.Dynamics.b2Body;
	import org.flintparticles.common.utils.FastWeightedArray;
	import org.flintparticles.twoD.zones.Zone2D;
	import flash.geom.Point;
	
	/**
	 * A BodyZone allows 2D particles to be picked randomly from inside a body.
	 */
	public class BodyZone implements Zone2D
	{
		/** The body to pick points from. */
		public var body:b2Body;
		/** Are points randomly weighted by mass, or by volume. */
		public var byMass:Boolean;
		/** Is the returned point in local or world co-ordinates. */
		public var local:Boolean;
		/** The scale factor between Flint pixels and Box2D units, in pixels/unit. */
		public var scale:Number;
		
		/**
		 * Basic constructor
		 * @param	body	The body get shapes from.
		 * @param	scale	Scaling factor between Flint pixels and Box2D units in pixels/unit.
		 * @param	byMass	Should random locations be weighted by mass or by area.
		 * @param	local	If true, points are considered in the bodies local co-ordinates, not world co-ordinates.
		 */
		public function BodyZone(body:b2Body, byMass:Boolean=true, local:Boolean = true, scale:Number=NaN) 
		{
			this.body = body;
			this.byMass = byMass;
			this.local = local;
			this.scale = isNaN(scale)?BodyRenderer.defaultScale:scale;
		}
		
		/**
		 * The contains method determines whether a point is inside the zone.
		 * 
		 * @param x The x coordinate of the location to test for.
		 * @param y The y coordinate of the location to test for.
		 * @return true if point is inside the zone, false if it is outside.
		 */
		public function contains( x:Number, y:Number ):Boolean
		{
			var vec:b2Vec2 = new b2Vec2(x/scale, y/scale);
			var xf:b2XForm = local?new b2XForm():body.GetXForm();
			for (var shape:b2Shape = body.GetShapeList(); shape; shape = shape.GetNext())
			{
				if (shape.TestPoint(xf, vec))
				{
					return true;
				}
			}
			return false;
		}
		
		/**
		 * The getLocation method returns a random point inside the zone.
		 * 
		 * @return a random point inside the zone.
		 */
		public function getLocation():Point
		{
			var shape:b2Shape = getShapeWeights().getRandomValue() as b2Shape;
			var xf:b2XForm = local?new b2XForm():body.GetXForm();
			var vec:b2Vec2 = new b2Vec2();
			if (shape is b2CircleShape)
			{
				var circle:b2CircleShape = shape as b2CircleShape;
				var theta:Number = Math.PI * 2 * Math.random();
				vec.SetV(circle.GetLocalPosition());
				vec.x += circle.GetRadius() * Math.sin(theta);
				vec.y += circle.GetRadius() * Math.cos(theta);
				vec = b2Math.b2MulX(xf, vec);
				return new Point(vec.x, vec.y);
			}
			if (shape is b2PolygonShape)
			{
				var poly:b2PolygonShape = shape as b2PolygonShape;
				var vertices:Array = poly.GetVertices();
				var n:int = poly.GetVertexCount();
				var a:FastWeightedArray = new FastWeightedArray();
				var x:Number = vertices[0].x;
				var y:Number = vertices[0].y;
				var i:int;
				for (i = 1; i < n - 1; i++)
				{
					a.add(i, (vertices[i].x - x) * (vertices[i + 1].y - y) - (vertices[i + 1].x - x) * (vertices[i].y - y));
				}
				i = a.getRandomValue();
				var p:Number = Math.random();
				var q:Number = Math.random();
				if (p + q > 1)
				{
					p = 1 - p;
					q = 1 - q;
				}
				var r:Number = 1 - p - q;
				vec.x = vertices[i].x * p + vertices[i + 1].x * q + x * r;
				vec.y = vertices[i].y * p + vertices[i + 1].y * q + y * r;
				vec = b2Math.b2MulX(xf, vec);
				return new Point(vec.x*scale, vec.y*scale);
			}
			throw "Unrecognized shape: " + shape;
		}
		

		/**
		 * The getArea method returns the size of the zone.
		 * It's used by the MultiZone class to manage the balancing between the
		 * different zones.
		 * 
		 * @return the size of the zone.
		 */
		public function getArea():Number
		{
			return getShapeWeights().totalRatios*scale*scale;
		}
		
		/**
		 * Returns a FastWeightedArray with an entry for each shape in the body,
		 * and weightings according to mass or volume.
		 * @return
		 */
		public function getShapeWeights():FastWeightedArray
		{
			var a:FastWeightedArray = new FastWeightedArray();
			var md:b2MassData = new b2MassData();
			for (var shape:b2Shape = body.GetShapeList(); shape; shape = shape.GetNext())
			{
				if (byMass)
				{
					shape.ComputeMass(md);
					a.add(shape, md.mass);
				}
				else
				{
					var density:Number = shape.m_density;
					shape.m_density = 1;
					shape.ComputeMass(md);
					a.add(shape, md.mass);
					shape.m_density = density;
				}
			}
			return a;
		}
		
	}
	
}