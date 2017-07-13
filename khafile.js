let project = new Project('New Project');
project.addAssets('Assets/**');
project.addSources('Sources');
project.addLibrary('nape');
project.addLibrary('zui');
resolve(project);