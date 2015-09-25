var mySound:Sound = new Laser();
var mySound1:Sound = new Explo();
var explos:Sound = new Expols();
var spacePressed:Boolean = false;
var leftPressed:Boolean = false;
var rightPressed:Boolean = false;
var shootCount:int = 0;
var enemyCount:int = 0;
var now:Date = new Date();
var gameOver = false;
var canFire = true;
var score:Number = 0;
var level:Number = 1;
var escaped:Number = 0;
var maxescaped:Number = 10;

var nexlevel:Number = 500;
nextlevelui.text = nexlevel.toString();
scoreui.text = score.toString();
levelui.text = level.toString();
escapedui.text = escaped.toString();
maxescapedui.text = maxescaped.toString();

info.text = "";
var game = true;

	
ship.addEventListener(Event.ENTER_FRAME, fl_MoveInDirectionOfKey);
stage.addEventListener(KeyboardEvent.KEY_DOWN, keyboard);
stage.addEventListener(KeyboardEvent.KEY_DOWN, fl_SetKeyPressed);
stage.addEventListener(KeyboardEvent.KEY_UP, fl_UnsetKeyPressed);
var vector:Vector.<Shoot> = new Vector.<Shoot>();
addEventListener(Event.ENTER_FRAME, loop);
var myTimer:Timer = new Timer(1300,60);
myTimer.addEventListener(TimerEvent.TIMER, timerListener);

var fireTimer = new Timer(300, 1);
fireTimer.addEventListener(TimerEvent.TIMER, fireTimerHandler, false, 0, true);

var shoots:Array = new Array();
var enemys:Array = new Array();

var mySound3:Sound = new Back();
playSound();

function playSound():void
{
    var channel:SoundChannel = mySound3.play();
    channel.addEventListener(Event.SOUND_COMPLETE, onComplete);
}

function onComplete(event:Event):void
{
    SoundChannel(event.target).removeEventListener(event.type, onComplete);
    playSound();
}

function timerListener (e:TimerEvent):void{

	createEnemy();	
	
}
myTimer.start();

function loop(event:Event):void{
	if(gameOver == false){
		
		if(escaped >= maxescaped){										
				gameOver = true;
				info.text = "Game over press N to new game";
				game = false;
				myTimer.stop();
				//mySound1.play();
		}
		if(score >= nexlevel){										
				gameOver = true;
				info.text = "Game Win press N to new game";
				game = false;
				myTimer.stop();
				//mySound1.play();
		}
		
	
	if(shoots.length != 0){
		for(var j:int=0;j<shoots.length;j++){
			shoots[j].update();	
			if(shoots[j].y <= 20){						
			parent.removeChild(shoots[j]);
			shoots.splice(j,1);
			}
			
			
		}
	}
	if(enemys.length != 0){
		
		for(var i:int=0;i<enemys.length;i++){
			
			enemys[i].update();
			if(enemys[i].y >= 460 ){						
			parent.removeChild(enemys[i]);
			enemys.splice(i,1);
			escaped += 1;
			escapedui.text = escaped.toString();
			}
			if(enemys[i].hitTestObject(ship)){						
				//stop();
				var explos1 = new Explosion();
				explos1.x = enemys[i].x ;
				explos1.y = enemys[i].y;
				parent.addChild(explos1);
				gameOver = true;
				info.text = "Game Over press N to new game";
				game = false;
				myTimer.stop();
				mySound1.play();
			}
			
		}
	}
	for(var k:int=0;k<shoots.length;k++){						
		if(shoots[k].parent == null){									
			shoots.splice(k,1);
						
		
		}
			
	}
	var control = 0;
	for(var c:int=0;c<enemys.length;c++){
		//enemys[c].update();
		control = 0;
		for(var d:int=0;d<shoots.length;d++){
			if(enemys[c].hitTestObject(shoots[d])){
				control = 1;
				parent.removeChild(shoots[d]);
				shoots.splice(d,1);
				explos.play();
				score += 10;
				scoreui.text = score.toString();
			}
		}
		if(control == 1){
			
			var explos = new Explosion();
			explos.x = enemys[c].x ;
			explos.y = enemys[c].y;
			parent.addChild(explos);
			parent.removeChild(enemys[c]);
			enemys.splice(c,1);
			//mySound1.play();
			
		}
	}
	}
}
function fl_MoveInDirectionOfKey(event:Event)
{
	if (spacePressed)
	{
			shoot();
	}	
	if (ship.x >= 505)
	{
		
	}
	else{		
		if (rightPressed)
		{
			ship.x += 8;
		}
	}
	if (ship.x <= 35)
	{
		
	}
	else{			
		if (leftPressed)
		{
			ship.x -= 8;
		}
	}
}

function fl_SetKeyPressed(event:KeyboardEvent):void
{
	switch (event.keyCode)
	{
		case Keyboard.SPACE:
		{
			spacePressed = true;
			break;
		}
		case Keyboard.LEFT:
		{
			leftPressed = true;
			break;
		}
		case Keyboard.RIGHT:
		{
			rightPressed = true;
			break;
		}
	}
}
function keyboard(event:KeyboardEvent):void
{
	switch (event.keyCode)
	{
		
		case Keyboard.N:
		{
			if(gameOver == true){
			clearScene();
			gameOver = false;
			game == true;
			myTimer.reset();
			myTimer.start();
			info.text = "";
			break;
		}
	}
}
}

function fl_UnsetKeyPressed(event:KeyboardEvent):void
{
	switch (event.keyCode)
	{
		case Keyboard.SPACE:
		{
			spacePressed = false;
			break;
		}
		case Keyboard.LEFT:
		{
			leftPressed = false;
			break;
		}
		case Keyboard.RIGHT:
		{
			rightPressed = false;
			break;
		}
	}
}
function shoot():void{
	
	
	if(gameOver == false){
		if (canFire)
		{
		var obj:Shoot= new Shoot();		
		obj.x=ship.x; 
		obj.y=ship.y;	
		parent.addChild(obj);
		mySound.play();
		shoots.push(obj);	
		trace(shoots.length);
		canFire = false;
		fireTimer.start();
		
		}
	}
}
function createEnemy():void{
	if(gameOver == false){
		
	
	var rn:Number = randRange(1,5);	
	var px:Number = 50;

	switch (rn)
	{
		case 1:
		{
			px = 50;
			break;
		}
		case 2:
		{
			px = 160;
			break;
		}
		case 3:
		{
			px = 270;
			break;
		}
		case 4:
		{
			px = 380;
			break;
		}
		case 5:
		{
			px = 490;
			break;
		}
	}
		
		var enemy = new Enemy2();
		enemy.x = px;
		enemy.y = 50;
		parent.addChild(enemy);
		enemys.push(enemy);	
		trace(enemys.length);
		
	}
	trace("New eneny time");
}
function randRange(minNum:Number, maxNum:Number):Number
{
    return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
}
function fireTimerHandler(e:TimerEvent) : void
{
			
			canFire = true;
}
function clearScene():void{
	
	trace(enemys.length);

	for(var l:int=0;l<shoots.length;l++){
				
		parent.removeChild(shoots[l]);
		//shoots.splice(l,1);
						
	}
		
	for(var i:int=0;i<enemys.length;i++){			
								
		parent.removeChild(enemys[i]);
		//enemys.splice(i,1);		
			
	}
	shoots.splice(0,shoots.length);
	enemys.splice(0,enemys.length);
	ship.x = 270;
	ship.y = 412;
	score = 0;
	level = 1;
	escaped = 0;
	maxescaped = 10;
	scoreui.text = score.toString();
	levelui.text = level.toString();
	escapedui.text = escaped.toString();
	maxescapedui.text = maxescaped.toString();
	
}

