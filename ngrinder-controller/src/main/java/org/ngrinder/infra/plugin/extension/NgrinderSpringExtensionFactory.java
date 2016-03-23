package org.ngrinder.infra.plugin.extension;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import ro.fortsoft.pf4j.Plugin;
import ro.fortsoft.pf4j.PluginManager;
import ro.fortsoft.pf4j.PluginWrapper;
import ro.fortsoft.pf4j.spring.SpringExtensionFactory;
import ro.fortsoft.pf4j.spring.SpringPlugin;

@Component
public class NgrinderSpringExtensionFactory extends SpringExtensionFactory {

	private final PluginManager pluginManager;

	@Autowired
	private ApplicationContext applicationContext;

	@Autowired
	public NgrinderSpringExtensionFactory(PluginManager pluginManager) {
		super(pluginManager);
		this.pluginManager = pluginManager;
	}

	protected void setApplicationContext(ApplicationContext applicationContext) {
		this.applicationContext = applicationContext;
	}

	@Override
	public Object create(Class<?> extensionClass) {
		Object extension = createWithoutSpring(extensionClass);
		if (extension != null) {
			PluginWrapper pluginWrapper = pluginManager.whichPlugin(extensionClass);
			if (pluginWrapper != null) {
				Plugin plugin = pluginWrapper.getPlugin();
				if (plugin instanceof SpringPlugin) {
					applicationContext.getAutowireCapableBeanFactory().autowireBean(extension);
				}
			}
		}
		return extension;
	}

}
