class FnHolder extends MovieClip {
	
	private var state:Number; // 0: shrunk, 1: lined-up
	public var front:Fn;
	private var children:Array;
	public var next:FnHolder;
	public var modifier:ModifierHolder;
	
	//constructor
	public function FnHolder() {
		state = 0;
		this.newAllChildren();
		this.shrink();
	}
	
	private function newAllChildren() {
		children = [];
		var childrenName = new Array("fn_Link", /*"fn_Begin", "fn_End",*/ "fn_LampB", "fn_MotorA_Fd", "fn_MotorA_Re", "fn_MotorC_Fd", "fn_MotorC_Re", "fn_StopA", "fn_StopB", "fn_StopC", "fn_StopABC", "fn_Wait_1s", "fn_Wait_2s", "fn_Wait_4s", "fn_Loop_Begin", "fn_Loop_End");
		for (var i in childrenName) {
			this.attachMovie(childrenName[i], childrenName[i], this.getNextHighestDepth());
			children.push(this[childrenName[i]]);
		}
		front = this[childrenName[0]];
	}
	
	//isXXX
	public function isShrunk() :Boolean {
		if (state == 0) { return true; }
		else { return false; }
	}
	
	public function isLinedUp() :Boolean {
		if (state == 1) { return true; }
		else { return false; }
	}
	
	public function isReady() :Boolean {
		if (front._name != "fn_Empty" && front._name != "") { return true; }
		else { return false; }
	}
	
	//rearrangement 
	public function rearrange(front:Fn) {
		if (state == 0) {
			this.lineUp();
		}
		else {
			this.shrink(front);
		}
	}
	
	public function lineUp() {
		var gridSize:Number = 40;
		var j:Number = 0;
		
		for (var i in children) {
			if (children[i] != front) {
				children[i]._x = gridSize * (j%4);
				children[i]._y = gridSize * Math.floor(j/4) - 4 * gridSize;
			}
			j++;
		}
		
		this.showAll();
		state = 1;
	}
	
	public function shrink(front:Fn) {
		if (typeof(front) == "movieclip") {
			this.front = front;
		}
		
		for (var i in children) {
			children[i]._x = 0;
			children[i]._y = 0;
		}
		this.hideAllExcept(this.front);
		this.state = 0;
	}
	
	//show and hide
	public function showAll() {
		for (var i in children) {
			children[i]._visible = 1;
		}
	}
	
	public function hideAll() {
		for (var i in children) {
			children[i]._visible = 0;
		}
	}
	
	public function hideAllExcept(mc:MovieClip) {
		this.hideAll();
		if (mc != null) { mc._visible = true; }
	}
	
	public function lock() {
		for (var i in children) {
			children[i].lock();
		}
	}
	
	public function unlock() {
		for (var i in children) {
			children[i].unlock();
		}
	}
	
	//mouse down handler
	public function onMouseDown() {
		var hit:Boolean = false;
		for (var i in children) {
			if (children[i].highlight._visible == 1) {
				hit = true;
			}
		}
		if (!hit) { this.shrink(); }
	}
	
}
