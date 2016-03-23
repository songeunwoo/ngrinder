package org.ngrinder.infra.plugin.finder;

import ro.fortsoft.pf4j.PluginClasspath;

public class NgrinderPluginClasspath extends PluginClasspath {

	@Override
	protected void addResources() {
		classesDirectories.add("");
		libDirectories.add("");
	}

}
