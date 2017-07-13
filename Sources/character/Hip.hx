package character;

import kha.Framebuffer;
import kha.math.Vector2;

class Hip {
	public var pos:Vector2;
	public var legA:Leg;
	public var legB:Leg;
	public var mHandle:MovementHandle;
	public var isFacingRight:Bool = true;

	public function new(pos:Vector2) {
		this.pos = pos;
		this.legA = new Leg(
			301,
			new Vector2(this.pos.x, this.pos.y),
			new Vector2(pos.x+75, pos.y+300),
			kha.Color.Green
		);
		this.legB = new Leg(
			301,
			new Vector2(this.pos.x, this.pos.y),
			new Vector2(pos.x-75, pos.y+300),
			kha.Color.Blue
		);
		this.mHandle = new MovementHandle(new Vector2(this.pos.x+150, this.pos.y), 220);
	}

	public function update() {
		this.legA.update();
		this.legB.update();
		var footATargetFromHandle:Vector2 = this.legA.footTargetFromHandle(this.mHandle.pos);
		var footBTargetFromHandle:Vector2 = this.legB.footTargetFromHandle(this.mHandle.pos);
		if (this.legAreUnbalanced()) {
			this.takeAStep(this.getLegBehind());
		} else {
			if (Math.abs(footATargetFromHandle.x) > 300) {
				this.takeAStep(this.legA);
			}
			if (Math.abs(footBTargetFromHandle.x) > 300) {
				this.takeAStep(this.legB);
			}
		}
	}

	public function takeAStep(leg:Leg) {
		var point:Vector2 = this.mHandle.getBottomPoint();
		leg.liftFoot();
		leg.orientFoot(point);
	}

	public function getLegBehind():Leg {
		var legAIsBehind:Bool = (this.legA.footPos.x < this.legB.footPos.x);
		var legBehind:Leg = this.legB;
		if (this.isFacingRight) {
			if (legAIsBehind) {
				legBehind = this.legA;
			}
		} else {
			if (!legAIsBehind) {
				legBehind = this.legA;
			}
		}
		return legBehind;
	}

	public function legAreUnbalanced():Bool {
		return (this.isFacingRight && this.legA.targetPos.x < this.pos.x && this.legB.targetPos.x < this.pos.x) ||
					(!this.isFacingRight && this.legA.targetPos.x > this.pos.x && this.legB.targetPos.x > this.pos.x);
	}

	public function getPoints() {
		var points:Array<Vector2> = new Array<Vector2>();
		points = points.concat(this.legA.getPoints());
		points = points.concat(this.legB.getPoints());
		return points;
	}

	public function draw(framebuffer: Framebuffer) {
		this.mHandle.draw(framebuffer);
		this.legA.draw(framebuffer);
		this.legB.draw(framebuffer);
	}

	public function moveFeetTargets(x:Float, y:Float) {
		this.legA.moveTarget(x, y);
		this.legB.moveTarget(x, y);
	}
}