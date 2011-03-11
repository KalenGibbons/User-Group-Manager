package com.ortusSolutions.userGroupManager.model.services{
	
	import com.ortusSolutions.userGroupManager.model.Presenter;
	import com.ortusSolutions.userGroupManager.model.dataAccess.PresenterDAO;
	
	public class PresenterService{
		
		[Inject]
		public var presenterDAO:PresenterDAO;
		
		public function PresenterService(){
		}// end constructor
		
		/* ***************************************************************************************
		**									PUBLIC FUNCTIONS
		*************************************************************************************** */
		
		[Init]
		public function initializeHandler():void{
			presenterDAO.createTables();
		}// end initializeHandler function
		
		public function getPresenters(meetingID:int):Array{
			var presenters:Array = [];
			var presenterRecords:Array = presenterDAO.getPresenters(meetingID);
			var presenter:Presenter;
			for(var i:int=0; i < presenterRecords.length; i++){
				presenter = new Presenter();
				presenter.populate(presenterRecords[i]);
				presenters.push(presenter);
			}
			return presenters;
		}// end getPresenters function
		
		public function addPresenters(meetingID:int, presenters:Array):void{
			for each(var presenter:Presenter in presenters){
				presenterDAO.addPresenter(meetingID, presenter.id);
			}
		}// end addPresenters function
		
		public function removeAllPresenters(meetingID:int):void{
			presenterDAO.removeAllPresenters(meetingID);
		}// end removeAllPresenters function
		
		
	}// end public class PresenterService
	
}// end package enclosure