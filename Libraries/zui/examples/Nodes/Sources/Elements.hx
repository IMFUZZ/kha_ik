package;
import kha.Framebuffer;
import kha.Assets;
import zui.*;
import zui.Nodes;

class Elements {
	var ui: Zui;
	var nodes: Nodes;
	var initialized = false;

	public function new() {
		Assets.loadEverything(loadingFinished);
	}

	function loadingFinished() {
		initialized = true;
		ui = new Zui({font: Assets.fonts.DroidSans});
		nodes = new Nodes();
	}

	var canvas:TNodeCanvas = {
		nodes: [
			{
				id: 0,
				name: "Node 1",
				type: "VALUE",
				x: 100,
				y: 100,
				color: 0xffaa4444,
				inputs: [],
				outputs: [
					{
						id: 0,
						node_id: 0,
						name: "Output",
						type: "VALUE",
						default_value: 0.0,
						color: 0xff44aa44
					}
				],
				buttons: []
			},
			{
				id: 1,
				name: "Node 2",
				type: "VALUE",
				x: 300,
				y: 100,
				color: 0xff4444aa,
				inputs: [
					{
						id: 0,
						node_id: 1,
						name: "Input",
						type: "VALUE",
						default_value: 0.0,
						color: 0xff44aa44
					}
				],
				outputs: [],
				buttons: []
			}
		],
		links: [
			{
				id: 0,
				from_id: 0,
				from_socket: 0,
				to_id: 1,
				to_socket: 0
			}
		]
	};

	public function render(framebuffer: Framebuffer): Void {
		if (!initialized) return;
		var g = framebuffer.g2;

		g.begin();
		g.end();

		ui.begin(g);
		if (ui.window(Id.handle(), 0, 0, 800, 600)) {
			nodes.nodeCanvas(ui, canvas);
		}
		ui.end();
	}

	public function update(): Void {
		if (!initialized) return;
	}
}
