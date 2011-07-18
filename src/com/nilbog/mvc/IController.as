package com.nilbog.mvc 
{
	import com.nilbog.util.IDestroyable;

	/**
	 * @author jmhnilbog
	 */
	public interface IController extends IDestroyable
	{
		function setModel(m:IModel):void;
		function getModel():IModel;
	
		function setView(v:IView):void;
		function getView():IView;
	}
}
