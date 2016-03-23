package org.ngrinder.infra.plugin.extension;

import java.net.MalformedURLException;

import org.ngrinder.infra.config.Config;
import org.ngrinder.infra.plugin.finder.NgrinderPluginClasspath;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.stereotype.Component;

import ro.fortsoft.pf4j.DefaultPluginManager;
import ro.fortsoft.pf4j.DefaultPluginRepository;
import ro.fortsoft.pf4j.DevelopmentPluginClasspath;
import ro.fortsoft.pf4j.ExtensionFactory;
import ro.fortsoft.pf4j.ExtensionFinder;
import ro.fortsoft.pf4j.PluginClasspath;
import ro.fortsoft.pf4j.RuntimeMode;
import ro.fortsoft.pf4j.spring.SpringExtensionFactory;
import ro.fortsoft.pf4j.util.JarFileFilter;

@Component
public class NgrinderDefaultPluginManager extends DefaultPluginManager {

	@Autowired
	public NgrinderDefaultPluginManager(Config config, ApplicationContext applicationContext) throws MalformedURLException {
		super(config.getHome().getPluginsDirectory());
		super.pluginRepository = new DefaultPluginRepository(pluginsDirectory, new JarFileFilter());
	}

	@Autowired
	public void setExtensionFinder(ExtensionFinder extensionFinder) {
		super.extensionFinder = extensionFinder;
	}

	@Autowired
	public void setSpringExtensionFactory(SpringExtensionFactory extensionFactory) {
		super.extensionFactory = extensionFactory;
	}

	@Override
	protected PluginClasspath createPluginClasspath() {
    	if (RuntimeMode.DEVELOPMENT.equals(getRuntimeMode())) {
    		return new DevelopmentPluginClasspath();
    	}

    	return new NgrinderPluginClasspath();
    }

	@Override
    protected ExtensionFactory createExtensionFactory() {
        return null;
    }

	@Override
	protected ExtensionFinder createExtensionFinder() {
        return null;
    }

}
