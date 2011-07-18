package com.nilbog.application
{
	import br.com.stimuli.loading.BulkLoader;

	import com.greensock.TweenLite;
	import com.nilbog.log.ILogManager;
	import com.nilbog.log.Logger;
	import com.nilbog.random.implementations.IRNGImplementation;

	/**
	 * A value object used to configure an application.
     */
    public dynamic class ApplicationDescription
    {
    	public var logger:ILogManager = Logger.logManager;
        public var animationPackage:* = TweenLite;
        public var defaultFlashVars:Object = {};
        public var preloadedFiles:BulkLoader = null;
        public var RNGImplementation:IRNGImplementation = null;
    }
}

