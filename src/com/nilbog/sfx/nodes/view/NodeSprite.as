package com.nilbog.sfx.nodes.view 
{
	import com.nilbog.datastructures.graph.Node;
	import com.nilbog.util.IDestroyable;
	import com.nilbog.util.geometry.Vector2D;

	import flash.display.Sprite;

	/**
	 * @author jmhnilbog
	 */
	public class NodeSprite extends Sprite implements IDestroyable
	{
		public var node:Node;
		public var speed:Vector2D = new Vector2D();
		public var target:Vector2D = new Vector2D();
		
		public function NodeSprite( node:Node )
		{
			this.node = node;
			
			with(graphics)
			{
				beginFill(0xff0000);
				lineStyle(1, 0xffff00);
				drawCircle(0, 0, 5);
				endFill();
			}
		}
		
		public function destroy():void
		{
			node = null;
		}
		
		public function isDestroyed():Boolean
		{
			return null == node;
		}
	}
}
