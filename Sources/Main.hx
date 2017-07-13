package;

import kha.System;
import kha.Scheduler;
import kha.System;
import kha.Assets;

class Main {
	public static function main() {
		System.init({title: "Project", width: 1920, height: 1080}, function () {
			Assets.loadEverything(function () {
				var game:Project = new Project();
				System.notifyOnRender(game.render);
				Scheduler.addTimeTask(game.update, 0, 1/60);
			});
		});
	}
}
