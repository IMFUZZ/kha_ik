package character;

import kha.Framebuffer;
import kha.math.Vector2;

class MovementHandle {
	public var pos:Vector2;
	public var length:Float;

	public function new(pos:Vector2, length:Float) {
		this.pos = pos;
		this.length = length;
	}

	public function move(x:Float, y:Float):Void {
		this.pos.x += x;
		this.pos.y += y;
	}
	
	public function setPos(newPos:Vector2):Void {
		this.pos = newPos;
	}

	public function draw(framebuffer:Framebuffer):Void {
		var graphics:kha.graphics2.Graphics = framebuffer.g2;
		graphics.drawLine(this.pos.x, this.pos.y, this.pos.x, this.pos.y+this.length, 3);
	}

	public function getBottomPoint():Vector2 {
		return new Vector2(this.pos.x, this.pos.y+this.length);
	}
}