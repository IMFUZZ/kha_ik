package character;

import kha.Framebuffer;
import kha.math.Vector2;
import kha.Color;

class Leg {
	public var color:Color;
	public var length:Float;
	public var rootPos:Vector2;
	public var kneePos:Vector2;
	public var footPos:Vector2;
	public var targetPos:Vector2;
	public var lift:Float;
	
	public function new(length:Float, rootPos:Vector2, footPos:Vector2, ?color:Color = Color.White) {
		this.color = color;
		this.length = length/2;
		this.rootPos = rootPos;
		this.footPos = footPos;
		this.kneePos = new Vector2(0.0, 0.0);
		this.targetPos = new Vector2(footPos.x, footPos.y);
		this.lift = 0;
	}

	public function orientFoot(newTargetPos:Vector2):Void {
		this.targetPos = newTargetPos;
	}

	public function liftFoot():Void {
		this.lift = 20;
	}

	public function update():Void {
		if (this.lift > 0) {
			this.lift -= 1;
			this.footPos.y -= this.lift;
		}
		var diffX:Float = this.targetPos.x - this.footPos.x;
		var diffY:Float = this.targetPos.y - this.footPos.y;
		if (diffX != 0) {
			this.footPos.x += diffX/5;
		}
		if (diffY != 0) {
			this.footPos.y += diffY/5;
		}
	}

	public function draw(framebuffer: Framebuffer):Void {
		var points:Array<Vector2> = this.getPoints();
		var graphics:kha.graphics2.Graphics = framebuffer.g2;
		graphics.color = this.color;
		for (x in 0...points.length-1) {
			graphics.drawLine(points[x].x, points[x].y, points[x+1].x, points[x+1].y, 3);
		}
		graphics.drawRect(this.targetPos.x, this.targetPos.y, 2, 2, 2);
		graphics.color = Color.White;
	}

	public function getPoints():Array<Vector2> {
		var newTargetPos:Vector2 = new Vector2(this.footPos.x - this.rootPos.x, this.footPos.y - this.rootPos.y);
		var points:Array<Vector2> = [new Vector2(this.rootPos.x, this.rootPos.y)].concat(IK.getIKPositions(rootPos, newTargetPos, this.length, this.length));
		return points;
	}

	public function footTargetFromHandle(handlePos:Vector2):Vector2 {
		return new Vector2(handlePos.x-this.targetPos.x, handlePos.y-this.targetPos.y);
	}

	public function moveTargetX(valPerFrame:Float):Void {
		 this.targetPos.x += valPerFrame;
	}

	public function moveTarget(x:Float, y:Float):Void {
		 this.targetPos.x += x;
		 this.targetPos.y += y;
	}
}