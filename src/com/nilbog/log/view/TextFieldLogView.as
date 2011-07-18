package com.nilbog.log.view 
{
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.model.LogEvent;
	import com.nilbog.mvc.IController;
	import com.nilbog.mvc.IModel;

	import flash.text.TextField;

	/**
	 * @author jmhnilbog
	 */
	public class TextFieldLogView extends TextField implements ILogView
	{
		protected var m:IModel;
		protected var c:IController;
		
		protected var _minimumLevel:LogLevel = LogLevel.INFO;
		
		public function TextFieldLogView(level:LogLevel=null)
		{	
			if (null != level)
			{
				_minimumLevel = level;
			}
		}
		
		public function onMessage(event:LogEvent):void
		{
			if (event.message.level >= _minimumLevel)
			{
				text = event.message as String;
			}
		}
		
		public function get minimumLevel():LogLevel
		{
			return _minimumLevel;
		}
		public function set minimumLevel(v:LogLevel) :void
		{
			_minimumLevel = v;
		}
		
		public function setModel(m:IModel):void
		{
			this.m = m;
		}
		
		public function getModel():IModel
		{
			return m;
		}
		
		public function setController(c:IController):void
		{
			this.c = c;
		}
		
		public function getController():IController
		{
			return c;
		}
		
		public function defaultController(model:IModel):IController
		{
			return null;
		}
		
		public function destroy():void
		{
			_minimumLevel = null;
			m = null;
			c = null;
		}
		
		public function isDestroyed():Boolean
		{
			return null == _minimumLevel;
		}
	}
}
