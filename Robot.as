interface Robot
{
	public function motorAFd(power:Number);
	public function motorBFd(power:Number);
	public function motorCFd(power:Number);
	
	public function motorARe(power:Number);
	public function motorBRe(power:Number);
	public function motorCRe(power:Number);
	
	public function lampA(power:Number);
	public function lampB(power:Number);
	public function lampC(power:Number);
	
	public function stopA();
	public function stopB();
	public function stopC();
	public function stopABC();
} 
