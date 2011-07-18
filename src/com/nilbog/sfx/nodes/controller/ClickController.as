package com.nilbog.sfx.nodes.controller 
{
	import com.nilbog.datastructures.graph.Node;
	import com.nilbog.log.LogLevel;
	import com.nilbog.mvc.AbstractController;
	import com.nilbog.mvc.IModel;
	import com.nilbog.mvc.IView;
	import com.nilbog.random.RNG;
	import com.nilbog.sfx.nodes.model.GraphModel;
	import com.nilbog.sfx.nodes.model.NodeData;
	import com.nilbog.sfx.nodes.view.NodeSprite;

	import flash.events.Event;
	import flash.events.EventPhase;
	import flash.events.MouseEvent;

	/**
	 * @author jmhnilbog
	 */
	public class ClickController extends AbstractController
	{
		public function ClickController(m:IModel, v:IView)
		{
			super( m, v );
			
			log.minimumLevel = LogLevel.WARN;
			log.trace("%s(%s)", "ClickController", arguments.join(", "));
			
			initialize();
		}
		
		public function initialize() :void
		{
			var v:IView = getView();
			if (null == v.stage)
			{
				v.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			}
			else
			{
				onAddedToStage();
			}
		}
		
		private function onAddedToStage(event:Event=null) :void
		{
			var v:IView = getView();
			v.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			v.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);			
			v.stage.addEventListener(MouseEvent.CLICK, onClick);
			v.stage.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
		}
		
		override public function destroy() :void
		{
			var v:IView = getView();
			v.removeEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			v.removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			v.stage.removeEventListener(MouseEvent.CLICK, onClick);
			v.stage.removeEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			
			super.destroy();
		}
		
		private function onRemovedFromStage(event:Event=null) :void
		{
			var v:IView = getView();
			v.removeEventListener( Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			v.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onClick(event:MouseEvent) :void
		{
			//log.trace("%s(%s)", "onClick", arguments.join(", "));
		}
		
		private function onMouseDown(event:MouseEvent) :void
		{
			log.trace("%s(%s)", "onMouseDown", arguments.join(", "));
			
			var m:GraphModel = getModel() as GraphModel;
			
			switch( event.eventPhase)
			{
				case EventPhase.AT_TARGET:
					// clicked empty space, add a node
					var nd:NodeData = new NodeData();
					
					m.addNode(nd);

					// add some edges
					var edges:uint = uint(RNG.random() * 3);
					for (var i:uint = 0; i < edges; i++)
					{
						var rnd:uint = uint(RNG.random() * m.graph.nodes.length);
						var en:Node = m.graph.nodes[rnd];
						var from:Node;
						var to:Node;
						if (RNG.random() > .5)
						{
							from = en;
							to = m.graph.getNode(nd);
						}
						else
						{
							from = m.graph.getNode(nd);
							to = en;
						}
						m.addConnection(from, to);
					}
					break;
					
				case EventPhase.BUBBLING_PHASE:
					// clicked a node, remove it
					var ns:NodeSprite = event.target as NodeSprite;
					log.info("Clicked: " + ns.node.data);
					m.removeNode(ns.node.data);
					break;
					
				default:
					break;
			}
		}
	}
}
