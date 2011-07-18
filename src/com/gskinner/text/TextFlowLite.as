﻿/** * TextFlowLite by Grant Skinner. Sep 9, 2007 * Visit www.gskinner.com/blog for documentation, updates and more free code. * * * Copyright (c) 2007 Grant Skinner *  * Permission is hereby granted, free of charge, to any person * obtaining a copy of this software and associated documentation * files (the "Software"), to deal in the Software without * restriction, including without limitation the rights to use, * copy, modify, merge, publish, distribute, sublicense, and/or sell * copies of the Software, and to permit persons to whom the * Software is furnished to do so, subject to the following * conditions: *  * The above copyright notice and this permission notice shall be * included in all copies or substantial portions of the Software. *  * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR * OTHER DEALINGS IN THE SOFTWARE. **/package com.gskinner.text {	import flash.text.TextField;	public class TextFlowLite 	{		protected var flds:Array;		protected var _text:String;		public function TextFlowLite(textFields:Array, text:String = null) 		{			flds = textFields;			_text = text == null ? flds[0].text : text;			reflow( );		}		public function get text():String 		{			return _text;		}		public function set text(value:String):void 		{			_text = value;			reflow( );		}		public function reflow():void 		{			flds[0].text = _text;			var l:int = flds.length - 1;			for (var i:int = 0; i < l ;i++) 			{				flowField( flds[i], flds[i + 1] );			}		}		protected function flowField(fld1:TextField,fld2:TextField):void 		{			fld1.scrollV = 1;			fld2.text = "";			if (fld1.maxScrollV <= 1) 			{ 				return; 			}			try 			{ 				// this is to get around issues with Flash's reporting of maxScrollV.				var nextCharIndex:Number = fld1.getLineOffset( fld1.bottomScrollV );				fld2.text = fld1.text.substr( nextCharIndex ).replace( /^\s+/, '' );				fld1.text = fld1.text.substr( 0, nextCharIndex ).replace( /\s+$/, '' );			} catch (e:*) 			{			}		}	}}