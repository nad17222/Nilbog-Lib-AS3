package com.nilbog.collections 
{	import com.nilbog.util.IComparable;
	
	/**	 * @author markhawley	 */	public class ExampleComparable implements IComparable 
	{
		public var value:int;
		
		public function ExampleComparable( v:int )
		{
			value = v;		}
		
		public function equals(obj:IComparable):Boolean
		{			return value == obj.valueOf();
		}
		
		public function lessThan(obj:IComparable):Boolean
		{			return value < obj.valueOf();
		}
		
		public function greaterThan(obj:IComparable):Boolean
		{			return value > obj.valueOf();
		}
		
		public function valueOf() :Object
		{
			return value;
		}
	}}