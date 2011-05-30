package com.ortusSolutions.userGroupManager.commands{
	import coldfusion.air.SessionToken;
	import coldfusion.air.SyncManager;
	import coldfusion.air.events.SyncFaultEvent;
	import coldfusion.air.events.SyncResultEvent;
	
	import com.ortusSolutions.userGroupManager.events.DataSyncEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.model.services.ConnectorService;
	
	import flash.events.Event;
	
	import mx.collections.ArrayCollection;
	import mx.rpc.AsyncToken;
	import mx.rpc.Responder;
	import mx.rpc.events.FaultEvent;
	import mx.rpc.events.ResultEvent;
	
	public class FetchCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		[Command (selector="fetchData")]
		public function execute(event:DataSyncEvent):void{
			var x:AsyncToken = ConnectorService.syncManager.fetch("fetch");
			x.addResponder( new Responder(resultHandler, faultHandler) );
		}// end execute method
		
		public function resultHandler(event:SyncResultEvent):void{
			ConnectorService.syncSession.saveUpdateCache( new ArrayCollection(event.result.PEOPLE) );
			ConnectorService.syncSession.saveUpdateCache( new ArrayCollection(event.result.MEETINGS) );
			ConnectorService.syncSession.saveUpdateCache( new ArrayCollection(event.result.RAFFLES) );
		}// end resultHandler function
		
		public function faultHandler(event:SyncFaultEvent):void{
			trace('no beuno');
		}// end faultHandler function
		
	}// end FetchCommand
	
}// end package enclosure