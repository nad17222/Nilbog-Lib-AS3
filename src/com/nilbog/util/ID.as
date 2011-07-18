package com.nilbog.util {    import flash.utils.Dictionary;    import flash.utils.getQualifiedClassName;        /**     * @author jmhnilbog     */    public class ID     {    	private static const COUNTERS:Dictionary = new Dictionary();    	private var value:uint;    	private var name:String;    	    	public function ID( name:String=null, number:uint=0 )    	{    		var instanceClassName:String = getQualifiedClassName( this );    		    		if (COUNTERS[instanceClassName] == undefined)    		{    			COUNTERS[instanceClassName] = 0;    		}    		    		if (number != 0)    		{    			this.value = number;    		}    		else    		{    			this.value = COUNTERS[instanceClassName]++;    		}    		this.name = name;    	}    	    	public function valueOf() :Object    	{    		return value;    	}    	    	public function toString() :String    	{    		return name;    	}    }}