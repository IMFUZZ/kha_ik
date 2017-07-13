package;

import kha.Framebuffer;
import kha.Assets;
import kha.math.Vector2;
import character.Hip;
import kha.input.Mouse;
import zui.Zui;
import zui.Id;

class Project {
	public var hip:Hip;
	public var mouse:Mouse;
	public var ui:Zui;
	public var handleX:Float = 500;
	public var handleY:Float = 500;
	public var feetTargetX:Float = 0;
	public var feetTargetY:Float = 0;

	public function new() {
		this.hip = new Hip(new Vector2(400, 300));
		this.mouse = kha.input.Mouse.get(0);
		this.mouse.notify(this.onMouseDown, this.onMouseUp, this.onMouseMove, null);
		this.ui = new Zui({
			font:Assets.fonts.AbelRegular,
			khaWindowId: 0,
			scaleFactor: 1.0
		});
	}

	public function update():Void {
		this.hip.mHandle.setPos(
			new Vector2(
				400 + this.handleX,
				300 + this.handleY
			));
		this.hip.moveFeetTargets(this.feetTargetX, this.feetTargetY);
		this.hip.update();
	}

	public function onMouseDown(buttonId:Int, x:Int, y:Int):Void {}

	public function onMouseUp(x:Int, y:Int, z:Int):Void {}

	public function onMouseMove(x:Int, y:Int, cx:Int, cy:Int):Void {}

	public function render(framebuffer: Framebuffer):Void {		
		var graphics:kha.graphics2.Graphics = framebuffer.g2;
		graphics.begin();
		graphics.font = Assets.fonts.AbelRegular;
		graphics.clear(kha.Color.Black);
		this.hip.draw(framebuffer);
		graphics.end();

		ui.begin(graphics);
		if (ui.window(Id.handle(), 10, 10, 200, 200, false)) {
			this.handleX = this.ui.slider(Id.handle(), "Handle X", -150, 150, false, 100, true);
			this.handleY = this.ui.slider(Id.handle(), "Handle Y", -150, 150, false, 100, true);
			this.feetTargetX = this.ui.slider(Id.handle(), "Feet targets X", -30, 30, false, 100, true);
			this.feetTargetY = this.ui.slider(Id.handle(), "Feet targets Y", -30, 30, false, 100, true);
		}
		ui.end();
	}
}
