class Fn extends MovieClip {
	
	private var locked:Boolean;
	
	public function Fn() {
		this.attachMovie("mc_Highlight", "highlight", this.getNextHighestDepth());
		this["highlight"]._visible = 0;
		this.attachMovie("mc_BrightUp", "spot", this.getNextHighestDepth());
		this["spot"]._visible = 0;
		locked = false;
	}
	
	function lock() { locked = true; }
	function unlock() { locked = false; }
	
	function onRollOver() {
		if (!locked) { this["highlight"]._visible = 1; }
	}
	
	function onRollOut() {
		this["highlight"]._visible = 0;
	}
	
	function onPress() {
		if (!locked) {
			_parent.rearrange(this);
			this["highlight"]._visible = 0;
		}
	}
	
	public function brightUp() {
		if (locked) {
			this["spot"]._visible = 1;
		}
	}
	
	public function dimDown() {
		if (locked) {
			this["spot"]._visible = 0;
		}
	}
	
}
