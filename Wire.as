class Wire extends MovieClip {
	
	public var left:FnHolder;
	public var right:FnHolder;
	
	public function Wire(left:FnHolder, right:FnHolder) {
		this.left = left;
		this.right = right;
		this.onMouseUp();
	}
	
	function onMouseUp() {
		if (this.left.isReady() && this.right.isReady()) {
			this._alpha = 100;
		} else {
			this._alpha = 25;
		}
	}
	
}