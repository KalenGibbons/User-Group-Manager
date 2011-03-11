package com.ortusSolutions.userGroupManager.events{
	
	import com.ortusSolutions.userGroupManager.model.Raffle;
	
	import flash.events.Event;
	
	public class RaffleEvent extends Event{
		
		public static const SAVE:String =	"saveRaffle";
		public static const DELETE:String = "deleteRaffle";
		
		public var raffle:Raffle
		
		public function RaffleEvent(type:String, raffle:Raffle=null, bubbles:Boolean=false, cancelable:Boolean=false){
			this.raffle = raffle;
			super(type, bubbles, cancelable);
		}// end constructor
	
		override public function clone():Event{
			return new RaffleEvent(this.type, this.raffle, this.bubbles, this.cancelable);
		}// end clone override function
		
	}// end RaffleEvent class
	
}// end package enclosure