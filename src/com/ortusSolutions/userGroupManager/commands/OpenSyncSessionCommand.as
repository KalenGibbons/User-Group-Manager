package com.ortusSolutions.userGroupManager.commands{
	
	import coldfusion.air.SessionToken;
	import coldfusion.air.events.SessionFaultEvent;
	import coldfusion.air.events.SessionResultEvent;
	
	import com.ortusSolutions.userGroupManager.events.DataSyncEvent;
	import com.ortusSolutions.userGroupManager.events.ModelEvent;
	import com.ortusSolutions.userGroupManager.model.services.ConnectorService;
	
	import mx.rpc.Responder;
	
	public class OpenSyncSessionCommand{
		
		[MessageDispatcher]
		public var messageDispatcher:Function;
		
		private var sessionId:int;
		
		public function OpenSyncSessionCommand(sessionId:int){
			this.sessionId = sessionId;
		}// end constructor
		
		[Command (selector="startSyncSession")]
		public function execute(event:DataSyncEvent):void{
			// TODO : remove hard-coded id
			var sessionToken:SessionToken = ConnectorService.syncManager.openSession(ConnectorService.databaseFile, sessionId);
			sessionToken.addResponder( new Responder(result, fault) );
		}// end execute function
		
		public function result(event:SessionResultEvent):void{
			ConnectorService.syncSession = event.sessionToken.session;
			// TODO : figure out where to put this - this is temp
			messageDispatcher( new ModelEvent(ModelEvent.PRELOAD_ALL) );
		}// end result function
		
		public function fault(event:SessionFaultEvent):void{
			// TODO : DO SOMETHING HERE, disable sync 
			trace('no bueno');
		}// end fault function
		
	}// end OpenSyncSessionCommand class
	
}// end package enclosure