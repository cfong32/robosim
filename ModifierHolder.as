class ModifierHolder extends FnHolder {
	
	public function lineUp() {
		var gridSize:Number = 40;
		var j:Number = 0;
		
		for (var i in children) {
			if (children[i] != front) {
				children[i]._x = gridSize * (j%6);
				children[i]._y = gridSize * Math.floor(j/6) + gridSize;
			}
			j++;
		}
		
		this.showAll();
		state = 1;
	}
	
	private function newAllChildren() {
		children = [];
		var childrenName = new Array("fn_Empty", "fn_Power1", "fn_Power2", "fn_Power3", "fn_Power4", "fn_Power5", "fn_Value1", "fn_Value2", "fn_Value3", "fn_Value4", "fn_Value5");
		for (var i in childrenName) {
			this.attachMovie(childrenName[i], childrenName[i], this.getNextHighestDepth());
			children.push(this[childrenName[i]]);
		}
		front = this[childrenName[0]];
	}
	
}
