package com.ortusSolutions.userGroupManager.commands{
	import coldfusion.air.SessionToken;
	import coldfusion.air.SyncManager;
	
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	
	import mx.rpc.AsyncToken;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class FetchCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Inject]
		public var syncManager:SyncManager
		
		[Command (selector="fetchData")]
		public function execute(event:ModelEvent):AsyncToken{
			return syncManager.fetch("fetch");
		}// end execute method
		
		[CommandResult]
		public function resultHandler(event:ResultEvent):void{
			trace('afds');
		}// end resultHandler function
		
		[CommandFault]
		public function faultHandler(event:FaultEvent):void{
			trace('adsf');
		}// end faultHandler function
		
	}// end FetchCommand
	
}// end package enclosure