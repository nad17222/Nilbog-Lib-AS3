package com.nilbog.log.controller 
{
	import com.nilbog.mvc.AbstractController;
	import com.nilbog.mvc.IModel;
	import com.nilbog.mvc.IView;

	/**
	 * A do-nothing Log controller.
	 * 
	 * @author jmhnilbog
	 */
	public class LogController extends AbstractController 
	{
		/**
		 * Constructor.
		 * 
		 * @param	m	IModel
		 * @param	v	IView
		 */
		public function LogController(m:IModel, v:IView)
		{
			super( m, v );
		}
	}
}
