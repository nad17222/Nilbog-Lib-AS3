package com.nilbog.physics.materials 
{

	/**
	 * Defines the physical properties of a material. Contains constants defining
	 * various common materials.
	 * 
	 * @author jmhnilbog
	 */
	public class Material 
	{
		public static const NULL_MATERIAL:Material = new Material(0, 1, 0);
		
		// air
		public static const AIR:Material = new Material(0, 1, .001);
		
		// human flesh
		public static const FLESH:Material = new Material(1.15, .3, .2);
		
		// glass
		public static const GLASS:Material = new Material(2.52, .658, .4);
		
		// granite
		public static const GRANITE:Material = new Material(2.6, .1, .85);
		
		// hard wood
		public static const HARD_WOOD:Material = new Material(.63, .603, .2);
		
		// soft wood
		public static const SOFT_WOOD:Material = new Material(.45, .3, .4);
		
		// steel
		// public static const STEEL:Material = new Material(7.82, .597, .7);
		public static const STEEL:Material = new Material(7.82, .1, .7);
		
		// density in g/cm^3 (kg/cm^2)
		public var density:Number = 0;
		
		// coefficient of restitution
		public var restitution:Number = 1;
		
		// default coefficient of friction
		public var friction:Number = 0;
		
		/**
		 * Constructor.
		 * 
		 * @param	density	Number (defaults to 0, meaning a static body)
		 * @param	restitution	Number (defaults to 1, meaning it bounces perfectly)
		 * @param	friction	Number (defaults to 0, a frictionless surface)
		 */
		public function Material(density:Number, restitution:Number, friction:Number)
		{
			this.density = density;
			this.restitution = restitution;
			this.friction = friction;
		}
	}
}
