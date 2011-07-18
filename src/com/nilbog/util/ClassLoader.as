package com.nilbog.util
{
	import flash.display.Loader;
	import flash.errors.IllegalOperationError;
	import flash.events.ErrorEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.events.SecurityErrorEvent;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;

	public class ClassLoader extends EventDispatcher implements IEventDispatcher
	{
		private var loader:Loader;
		private var url:String;
		private var request:URLRequest;
		private var loadedClass:Class;

		public function ClassLoader( libraryURL:String ) 
		{
			loader = new Loader( );
			loader.contentLoaderInfo.addEventListener( Event.COMPLETE, completeHandler );
			loader.contentLoaderInfo.addEventListener( IOErrorEvent.IO_ERROR, ioErrorHandler );
			loader.contentLoaderInfo.addEventListener( SecurityErrorEvent.SECURITY_ERROR, securityErrorHandler );
			
			url = libraryURL;
		}

		public function load():void 
		{
			request = new URLRequest( url );
			var context:LoaderContext = new LoaderContext( );
			context.applicationDomain = ApplicationDomain.currentDomain;
			loader.load( request, context );
		}

		public function getClass(className:String):Class 
		{
			try 
			{
				return loader.contentLoaderInfo.applicationDomain.getDefinition( className ) as Class;
			} 
			catch (e:Error) 
			{
				throw new IllegalOperationError( className + " definition not found in " + url );
			}
			return null;
		}

		private function completeHandler(e:Event):void 
		{
			dispatchEvent( new Event( Event.COMPLETE ) );
		}

		private function ioErrorHandler(e:Event):void 
		{
			dispatchEvent( new ErrorEvent( ErrorEvent.ERROR ) );
		}

		private function securityErrorHandler(e:Event):void 
		{
			dispatchEvent( new ErrorEvent( ErrorEvent.ERROR ) );
		}
	}
}