<#import "../common/spring.ftl" as spring/>
<div id="system_chart">
	<div class="page-header page-header">
		<h4><@spring.message "agent.info.systemData"/></h4>
		<input type="hidden" id="target_ip" value="${(targetIP)!}">
	</div>
	<h6>CPU</h6>

	<div class="chart" id="cpu_usage_chart"></div>
	<h6 style="margin-top: 20px">Memory</h6>

	<div class="chart" id="memory_usage_chart"></div>
</div>

<script src="${req.getContextPath()}/js/queue.js?${nGrinderVersion}"></script>
<script>
	function drawChart(id, data, yFormat, interval) {
		var result = new Chart(id, data, interval, {xAxisFormatter:yFormat});
		return result.plot();
	}
	var interval = 1;
	var timer;
	var cpuUsage = new Queue(60);
	var memoryUsage = new Queue(60);
	var cpuChart = drawChart('cpu_usage_chart', [cpuUsage.getArray()], formatPercentage, interval);
	var memoryChart = drawChart('memory_usage_chart', [memoryUsage.getArray()], formatMemory, interval);
	var errorCount = 0;
	$(document).ready(function () {
		if (getState()) {
			timer = window.setInterval("getState()", interval * 1000);
		}
	});

	function getState() {
		var result = false;
		var ajaxObj = new AjaxObj("/monitor/state");
		ajaxObj.params = {'ip': '${(targetIP)!}'};
		ajaxObj.async = false;
		ajaxObj.success = function (res) {
			cpuUsage.enQueue(res.cpuUsedPercentage);
			memoryUsage.enQueue(res.totalMemory - res.freeMemory);
			cpuChart.plot();
			memoryChart.plot();
			result = true;
			errorCount = 0;
		};
		ajaxObj.error = function () {
			errorCount = errorCount + 1;
			if (errorCount > 3) {
				showErrorMsg("Failed to get the monitoring data.");
				result = false;
				if (timer) {
					window.clearInterval(timer);
				}
			}
		};
		ajaxObj.call();
		return result;
	}

</script>