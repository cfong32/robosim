class Runner extends MovieClip {
	
	public var firstFn:FnHolder;
	public var robot:Robot;
	
	private var currentFn:FnHolder;
	private var prevFn:FnHolder;
	private var running:Boolean;
	private var waiting:Boolean;
	private var iid;
	private var stack;
	
	public function Runner() {
		running = false;
		waiting = false;
		stack = [];
	}
	
	public function onPress() {
		if (validSyntax()) {                               //----------------------
			startToRun();
		}
		else {
			this.gotoAndPlay(2);
		}
		
	}
	
	public function startToRun() {
		prevFn = null;
		currentFn = firstFn;
		running = true;
		waiting = false;
		lockAllClips();
	}
	
	public function stopToRun() {
		running = false;
		waiting = false;
		unlockAllClips();
	}
	
	public function onEnterFrame() {
		if (currentFn == null) {
			prevFn.front.dimDown();
			stopToRun();
		}
		else if (running && !waiting) {
			//bright up currentFn
			prevFn.front.dimDown();	//trace(prevFn._name + ".dimDown()");
			currentFn.front.brightUp(); //trace(currentFn._name + ".brightUp()");
			
			//determine power level
			var mvalue:Number;
			switch (currentFn.modifier.front._name) {
				case "fn_Power1":
				case "fn_Power2":
				case "fn_Power3":
				case "fn_Power4":
				case "fn_Power5":
				case "fn_Value1":
				case "fn_Value2":
				case "fn_Value3":
				case "fn_Value4":
				case "fn_Value5":
					mvalue = currentFn.modifier.front._name.charCodeAt(currentFn.modifier.front._name.length-1) - 48;
					break;
				default:
			}
			
			//perform currentFn
			switch (currentFn.front._name) {
				case "fn_LampB":
					robot.lampB(mvalue);
					break;
				case "fn_MotorA_Fd":
					robot.motorARe(mvalue);
					break;
				case "fn_MotorA_Re":
					robot.motorAFd(mvalue);
					break;
				case "fn_MotorC_Fd":
					robot.motorCRe(mvalue);
					break;
				case "fn_MotorC_Re":
					robot.motorCFd(mvalue);
					break;
				case "fn_StopA":
					robot.stopA();
					break;
				case "fn_StopB":
					robot.stopB();
					break;
				case "fn_StopC":
					robot.stopC();
					break;
				case "fn_StopABC":
					robot.stopABC();
					break;
				case "fn_Wait_1s":
					waiting = true;
					iid = setInterval(this, "run", 1000);
					break;
				case "fn_Wait_2s":
					waiting = true;
					iid = setInterval(this, "run", 2000);
					break;
				case "fn_Wait_4s":
					waiting = true;
					iid = setInterval(this, "run", 4000);
					break;
				default:
			}
			
			//advance currentFn to next
			switch (currentFn.front._name) {
				case "fn_Loop_End":
					var poppedFn =  stack.pop();
					if (poppedFn != null) {	
						prevFn = currentFn;
						currentFn = poppedFn.next;
						break;
					}
					
				case "fn_Loop_Begin":
					if (mvalue == null) {mvalue = 2};
					for (var i = 1; i<mvalue; i++) {
						stack.push(currentFn);
					}
										
				default:
					//advance currentFn to next
					prevFn = currentFn;
					trace ("prevFn <= " + currentFn._name);
					trace ("currentFn <= " + currentFn.next._name);
					currentFn = currentFn.next;
			}
		}
	}

	private function validSyntax() : Boolean {
		var nOpenLoop : Number = 0;

		currentFn = firstFn;
		while (currentFn != null) {
			if (currentFn.front._name == "fn_Loop_Begin") {
				nOpenLoop++;
			}
			else if (currentFn.front._name == "fn_Loop_End") {
				nOpenLoop--;
			}
			currentFn = currentFn.next;
			
			if (nOpenLoop <0) { return false; }
		}
		
		if (nOpenLoop > 0) { return false; }
		else { return true; }
		
	}	

	public function lock() {
		this._alpha = 50;
	}
	
	public function unlock() {
		this._alpha = 100;
	}
	
	private function run() {
		trace("run");
		waiting = false;
		clearInterval(iid);
	}
	
	private function lockAllClips() {
		for (var i in _root) {
			_root[i].lock();
		}
	}
	
	private function unlockAllClips() {
		for (var i in _root) {
			_root[i].unlock();
		}
	}
}