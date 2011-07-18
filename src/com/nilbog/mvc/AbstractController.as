package com.nilbog.mvc 
{
	import com.nilbog.errors.AbstractMethodCallError;
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.util.instantiatedAs;

	/**
	 * Base controller class for physics-based simulations.
	 * 
	 * @author jmhnilbog
	 */
	public class AbstractController implements IController
	{
		protected var log:ILog;
		
		protected var model:IModel;
		protected var view:IView;
		
		/**
		 * Constructor.
		 * 
		 * @param	m	PhysicsModel
		 * @param	v	PhysicsView (defaults to null)
		 */
		public function AbstractController(m:IModel, v:IView)
		{
			super();
			
			if (instantiatedAs(this, AbstractController))
			{
				throw new AbstractMethodCallError("Cannot " +
					"instantiate Abstract class.");
			}
			
			log = getLog(this, LogLevel.WARN);
			log.trace("%s(%s)", "AbstractController", arguments.join(", "));
			
			setModel(m);
			setView(v);
		}
		
		public function getModel():IModel
		{
			log.trace("%s(%s)", "getModel", arguments.join(", "));
			
			return model;
		}
		
		public function setView(v:IView):void
		{
			log.trace("%s(%s)", "setView", arguments.join(", "));
			
			view = v;
		}
		
		public function getView():IView
		{
			log.trace("%s(%s)", "getView", arguments.join(", "));
			
			return view;
		}
		
		public function destroy():void
		{
			log = null;
			model = null;
			view = null;
		}
		
		public function isDestroyed():Boolean
		{
			return null == log;
		}
		
		public function setModel(m:IModel):void
		{
			log.trace("%s(%s)", "setModel", arguments.join(", "));
			
			var currentModel:IModel = getModel();
        	var pair:Object;
        	var pairs:Array = getExpectedModelEvents();
        	
        	if (null != currentModel)
        	{
        		for each (pair in pairs)
        		{
        			currentModel.removeEventListener(pair.name, pair.func);
        		}
        	}
        	model = m;
        	
        	if (null != m)
        	{
        		for each (pair in pairs)
        		{
        			model.addEventListener(pair.name, pair.func);
        		}
        	}
		}
		
		/**
		 * Returns a array of objects. Each object has a 'name' (the name of an
		 * event) and a 'func' (the method on the view that should be called on
		 * reciept of the event)
		 */
		protected function getExpectedModelEvents() :Array
		{
			return [];
		}
	}
}
