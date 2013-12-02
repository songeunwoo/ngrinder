package org.ngrinder.monitor.agent.collector;

import static org.hamcrest.Matchers.not;
import static org.junit.Assert.assertThat;

import java.io.File;

import org.apache.commons.lang.StringUtils;
import org.hyperic.jni.ArchLoaderException;
import org.hyperic.jni.ArchNotSupportedException;
import org.junit.Before;
import org.junit.Test;
import org.ngrinder.common.util.ThreadUtils;
import org.ngrinder.infra.AgentConfig;
import org.ngrinder.infra.ArchLoaderInit;
import org.ngrinder.monitor.share.domain.BandWidth;
import org.ngrinder.monitor.share.domain.SystemInfo;

public class MonitorCollectorTest {
	@Before
	public void before() throws ArchNotSupportedException, ArchLoaderException {
		AgentConfig agentConfig = new AgentConfig.NullAgentConfig(1).init();
		new ArchLoaderInit().init(agentConfig.getHome().getNativeDirectory());
	}

	@Test
	public void test() throws InterruptedException {
		AgentSystemDataCollector collector = new AgentSystemDataCollector();
		collector.refresh();
		int i = 0;
		while (i++ < 5) {
			SystemInfo execute = collector.execute();
			ThreadUtils.sleep(1000);
			BandWidth bandWidth = execute.getBandWidth();

			if (i != 1) {
				assertThat(bandWidth.getReceivedPerSec(), not(0L));
				assertThat(bandWidth.getSentPerSec(), not(0L));
			}
			ThreadUtils.sleep(1000);
		}
	}
}
