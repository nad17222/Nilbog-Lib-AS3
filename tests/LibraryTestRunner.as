package  
{
	import getLog;
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.LogManager;
	import com.nilbog.log.Logger;
	import com.nilbog.log.view.XRayLogView;
	import com.nilbog.util.contextmenu.versionStamp;

	/**
	 * @author mark hawley
	 */
	public class LibraryTestRunner extends AsUnitTestRunner 
	{
		public function LibraryTestRunner()
		{
			Logger.logManager = new LogManager
			(
				new XRayLogView(LogLevel.INFO)
			);
			
			// place the build version/date into the right-click menu
			versionStamp(this);
			
			var log:ILog = getLog(this, LogLevel.INFO);
			log.info("Logging.");
			//super();
		}
	}
}
