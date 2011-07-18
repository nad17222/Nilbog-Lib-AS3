package com.nilbog.log 
{
	import com.nilbog.log.model.LogModel;
	import com.nilbog.log.view.ILogView;
	import com.nilbog.mvc.IView;

	/**
	 * @author jmhnilbog
	 */
	public class LogManager implements ILogManager
	{
		private var views:Vector.<ILogView>;
		
		private var model:LogModel;
		
		public function LogManager( ...views )
		{
			model = new LogModel();
			
			this.views = new Vector.<ILogView>();
			for each (var v:IView in views)
			{
				addView(v);
			}
		}
		public function addView(v:Object):void
		{
			views.push(v as IView);
			v.setModel(model);
		}
		
		public function removeView(v:Object):void
		{
			v.setModel(null);
			var i:uint = views.indexOf(v as IView);
			views.splice(i, 1);
		}
		
		public function getLog(logID:Object, logLevel:LogLevel = null):ILog
		{
			return model.getLog(logID, logLevel);
		}
	}
}
