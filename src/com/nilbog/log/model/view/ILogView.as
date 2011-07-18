package com.nilbog.log.view 
{
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.model.LogEvent;
	import com.nilbog.mvc.IView;

	/**
	 * LogView interface. Allows for setting the minimum level that a view will 
	 * respond to and allows for listening to log messages.
	 * 
	 * @author jmhnilbog
	 */
	public interface ILogView extends IView
	{
		function onMessage(event:LogEvent) :void;
		function get minimumLevel() :LogLevel;
		function set minimumLevel(v:LogLevel) :void;
	}
}
