package com.nilbog.util {    /**	 * @author markhawley	 */	public interface IOrderable 	{		function next() :IOrderable;		function previous() :IOrderable;	}}