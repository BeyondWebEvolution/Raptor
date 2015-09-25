package  {
	
	import flash.display.MovieClip;
	import flash.utils.Timer;
	import flash.events.*;
	
	
	public class Explosion extends MovieClip {
		
		var fireTimer = new Timer(180, 1);
		
		public function Explosion() {
			
			
			fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler);
			fireTimer.start();
			// constructor code
		}
		function fireTimerHandler(e:TimerEvent) : void
		{
			//timer ran, we can fire again.
			//canFire = true;
			fireTimer.removeEventListener(TimerEvent.TIMER, fireTimerHandler);
			parent.removeChild(this);
		}
	}
	
}
