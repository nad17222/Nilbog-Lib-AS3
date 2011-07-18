package
{
	import com.nilbog.log.ILog;
	import com.nilbog.log.LogLevel;
	import com.nilbog.log.Logger;
	
	public function getLog( logID:Object, logLevel:LogLevel=null) :ILog
	{
		return Logger.logManager.getLog( logID, logLevel );
	}
}
