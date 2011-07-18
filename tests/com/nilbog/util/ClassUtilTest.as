package com.nilbog.util 
{
	import asunit.framework.TestCase;			

	/**
	 * @author mark hawley
	 */
	public class ClassUtilTest extends TestCase 
	{
		public function ClassUtilTest(testMethod:String = null)
		{
			super(testMethod);
		}
		
		protected override function setUp() :void
		{
		}
		
		protected override function tearDown() :void
		{
		}
		
		public function testClone() :void
		{
			var original:Object = { property: "value" };
			var copy:* = clone(original);
			
			var failed:Boolean = false;
			var asType:Object;
			try
			{
				asType = copy as Object;
			}
			catch( e:Object )
			{
				failed = true;
			}
			
			assertFalse("Did not fail.", failed);
			assertTrue("Copy has same values.", original.property == asType.property);
			assertTrue("Copy is different than original.", copy !== original );
		}
		
		public function testCloneArray() :void
		{
			var original:Array = [ {property: "ZERO"}, {property: "ONE"} ];
			var copy:* = clone(original);
			
			var failed:Boolean = false;
			var asType:Array;
			var element:Object;
			try
			{
				asType = copy as Array;
				element = asType[0] as Object;
				var prop:Object = element.property;
				element = asType[1] as Object;
			}
			catch( e:Object )
			{
				failed = true;
			}
			
			assertFalse("Did not fail.", failed);
			assertTrue("Copy has same values.", original[0].property == copy[0].property);
			assertTrue("Copy is different than original.", copy !== original );
			assertTrue("Stack traces match.", element.property == original[1].property);
			assertTrue("Elements are different.", element !== original[1]);
		}
		
		public function testInstantiatedAs() :void
		{
			var obj:Object = {};
			var arr:Object = [];
			
			assertTrue("obj instantiated as an Object.", instantiatedAs(obj, Object));
			assertTrue("arr instantiated as an Array.", instantiatedAs(arr, Array));
			assertFalse("arr not instantiated as an Object.", instantiatedAs(arr, Object));
		}
		
		public function testFlashVars() :void
		{
			var error:Boolean = false;
			var fv:FlashVars;
			
			fv = FlashVars.initialize(AsUnitTestRunner.STAGE, 
			{ 
				prop1: "valueA", 
				prop2: "valueB"
			});
			
			assertTrue("prop1 found.", fv.prop1 == "valueA");
			assertTrue("prop2 found.", fv.prop2 == "valueB");
		}
	}
}
