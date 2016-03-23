package org.ngrinder.infra.plugin.finder;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import ro.fortsoft.pf4j.DefaultExtensionFinder;
import ro.fortsoft.pf4j.PluginManager;

@Component
public class NgrinderDefaultExtensionFinder extends DefaultExtensionFinder{

	@Autowired
	public NgrinderDefaultExtensionFinder(PluginManager pluginManager) {
		super(pluginManager);
		addMyFinder(pluginManager);
	}

	@Override
	protected void addDefaults(PluginManager pluginManager) {
	}

	private void addMyFinder(PluginManager pluginManager) {
		finders.add(new NgrinderServiceProviderExtensionFinder(pluginManager));
	}

}
