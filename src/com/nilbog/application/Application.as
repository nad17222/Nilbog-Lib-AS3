﻿package com.nilbog.application {	import com.nilbog.animation.Animation;	import com.nilbog.dbc.precondition;	import com.nilbog.errors.AbstractMethodCallError;	import com.nilbog.log.ILog;	import com.nilbog.log.LogLevel;	import com.nilbog.log.Logger;	import com.nilbog.random.RNG;	import com.nilbog.util.FlashVars;	import com.nilbog.util.IDestroyable;	import com.nilbog.util.IStageListenable;	import com.nilbog.util.contextmenu.versionStamp;	import com.nilbog.util.displayobject.StagingHandler;	import flash.display.MovieClip;	import flash.events.Event;	/**	 * Base class for application-level projects. Handles logging, flash vars,     * blah blah blah. Applications do not run until placed on a stage (as they     * expect to be a document class, usually). Removing an application from     * the stage should only be done if the entire app is being destroyed and     * disposed of. A new instance should be used if it is to be added to the     * stage once more.     *      * @author mark hawley     */    public class Application extends MovieClip implements IDestroyable, IStageListenable    {	        protected var log:ILog;        protected var flashVars:FlashVars;        protected var stagingHandler:StagingHandler;        /**         * Constructor.         *          * @param	description	ApplicationDescription         */        public function Application( description:ApplicationDescription = null )        {        	if (null == description)            {                description = new ApplicationDescription( );            }                        // set up logging			Logger.logManager = description.logger;            log = getLog( this, LogLevel.INFO );            log.info( "%s(%s)", "initialize", arguments );			            Animation.animator = description.animationPackage;            log.info( "Default animation package set: '%s'", description.animationPackage );			            flashVars = FlashVars.initialize( this, description.defaultFlashVars );            log.info( "FlashVars read: '%s'", flashVars );                        if (description.RNGImplementation != null)            {            	RNG.initialize(description.RNGImplementation );            	log.info("RNG initialized.");			}			            // place the build version/date into the right-click menu            versionStamp( this );            log.info( "Application initialized: '%s'", this );						 stagingHandler = new StagingHandler(this);        }                public function onAddedToStage(event:Event) :void        {        	run();        }        /**         * Cleans up. Should be called before removing all references to the          * application.         */        public function destroy():void        {            precondition( !isDestroyed( ) );                        log = null;            flashVars = null;            stagingHandler.destroy();            stagingHandler = null;        }        /**         * Returns true if this instance is still 'good'.         *          * @return Boolean         */        public function isDestroyed():Boolean        {            return null == stagingHandler;        }                public function onRemovedFromStage(event:Event):void		{			// do nothing special		}                /**         * Applications do not run until they are placed on a stage.         */        protected function run() :void        {        	var e:Error = new AbstractMethodCallError();        	log.error(e);        	throw e;		}	}}