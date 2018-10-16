class SimpleRobot extends MovieClip implements Robot {
	
	private var motorAPower:Number;
	private var motorCPower:Number;
	private var lampBPower:Number;
	
	public function SimpleRobot() {
		motorAPower = 0;
		motorCPower = 0;
		lampBPower = 0;
	}
	
	public function motorAFd(power:Number) { motorAPower = validate(power,5); }
	public function motorBFd(power:Number) { lampBPower = validate(power,5); }
	public function motorCFd(power:Number) { motorCPower = validate(power,5); }
	
	public function motorARe(power:Number) { motorAPower = -validate(power,5); }
	public function motorBRe(power:Number) { lampBPower = validate(power,5); }
	public function motorCRe(power:Number) { motorCPower = -validate(power,5); }
	
	public function lampA(power:Number) { motorAPower = validate(power,5); }
	public function lampB(power:Number) { lampBPower = validate(power,5); }
	public function lampC(power:Number) { motorCPower = validate(power,5); }
	
	public function stopA() { motorAPower = 0; }
	public function stopB() { lampBPower = 0; }
	public function stopC() { motorCPower = 0; }
	public function stopABC() {	stopA(); stopB(); stopC(); }
	
	public function onEnterFrame() {
		this.move(motorAPower, motorCPower);
		this["lamp"].gotoAndStop(lampBPower+1);
	}
	
	private function validate(g, d) :Number {		//g:given, d:default
		if (g == null || g < 0 || g > 5 || Math.floor(g)-g != 0) {
			return d;
		} else {
			return g;
		}
	}
	
	private function move(left:Number, right:Number) {
		var speed = 10;
		left = left / 100 * speed;
		right = right /100 * speed;
		var D = 50;
		var r = D/2*(left+right)/(left-right);
		if ((left-right)==0) { r = 10000; }
		
		var T = (left+right)/2/r*100;
		if ((left+right)==0) {	T = left/D*2*100; }
		
		var cosT = Math.cos(T/180*Math.PI);
		var sinT = Math.sin(T/180*Math.PI);
		var cosRot = Math.cos(_root.robot1._rotation/180*Math.PI);
		var sinRot = Math.sin(_root.robot1._rotation/180*Math.PI);
		
		var localX = r-r*cosT;
		var localY = -r*sinT;
		var globalX = localX;
		var globalY = localY;
		var globalX = cosRot*localX-sinRot*localY;
		var globalY = sinRot*localX+cosRot*localY;
		
		this._x = this._x+globalX;
		this._y = this._y+globalY;
		this._rotation = this._rotation+T;
	}

}

