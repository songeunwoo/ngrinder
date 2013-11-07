
    <div class="page-header page-header">
        <h4>System Monitoring</h4>
    </div>
    <h6>CPU</h6>
    <div class="chart" id="cpu_usage_chart"></div>
    <h6>Used Memory</h6>
    <div class="chart" id="mem_usage_chart"></div>
    <h6 id="recevied_byte_per_sec_header">Received Byte Per Second</h6>
    <div class="chart" id="recevied_byte_per_sec_chart"></div>
    <h6 id="sent_byte_per_sec_header">Sent Per Second</h6>
    <div class="chart" id="sent_byte_per_sec_chart"></div>
    <h6 id="custom_monitor_header_1">Custom Monitor Chart 1</h6>
    <div class="chart" id="custom_monitor_chart_1"></div>
    <h6 id="custom_monitor_header_2">Custom Monitor Chart 2</h6>
    <div class="chart" id="custom_monitor_chart_2"></div>
    <h6 id="custom_monitor_header_3">Custom Monitor Chart 3</h6>
    <div class="chart" id="custom_monitor_chart_3"></div>
    <h6 id="custom_monitor_header_4">Custom Monitor Chart 4</h6>
    <div class="chart" id="custom_monitor_chart_4"></div>
    <h6 id="custom_monitor_header_5">Custom Monitor Chart 5</h6>
    <div class="chart" id="custom_monitor_chart_5"></div>

    <script>
        var currentTestId = 0;
        $(document).ready(function() {

        });

        function getTargetMonitorDataAndDraw(testId, ip) {
            currentTestId = testId;
            $.ajax({
                url: "${req.getContextPath()}/perftest/"+testId+"/monitor",
                dataType:'json',
                cache: true,
                data: {'monitorIP': ip, 'imgWidth': 700}
            }).done(function(result) {
                targetMonitorData[ip] = result.SystemData;
                drawMonitorChart(result.SystemData);
            }).fail(function() {
                showErrorMsg("Get monitor data failed!");
            });
        }

        function drawMonitorChart(currMonitorData) {
            drawChart('cpu_usage_chart', currMonitorData.cpu, formatPercentage, currMonitorData.interval);
            drawChart('mem_usage_chart', currMonitorData.memory, formatMemory, currMonitorData.interval);
            drawExtMonitorData(currMonitorData);
            generateImg(imgBtnLabel, imgTitle);
        }

        function drawExtMonitorData(systemData) {
            drawChart("recevied_byte_per_sec_chart", systemData.received, formatNetwork, systemData.interval);
            drawChart("sent_byte_per_sec_chart", systemData.sent, formatNetwork, systemData.interval);
            drawChart("custom_monitor_chart_1", systemData.customData1, formatNetwork, systemData.interval);
            drawChart("custom_monitor_chart_2", systemData.customData2, formatNetwork, systemData.interval);
            drawChart("custom_monitor_chart_3", systemData.customData3, formatNetwork, systemData.interval);
            drawChart("custom_monitor_chart_4", systemData.customData4, formatNetwork, systemData.interval);
            drawChart("custom_monitor_chart_5", systemData.customData5, formatNetwork, systemData.interval);

            drawChartForMonitor(systemData.customData1, "custom_monitor_chart_1", "custom_monitor_header_1", systemData.interval, formatNetwork);
            drawChartForMonitor(systemData.customData2, "custom_monitor_chart_2", "custom_monitor_header_2", systemData.interval, formatNetwork);
            drawChartForMonitor(systemData.customData3, "custom_monitor_chart_3", "custom_monitor_header_3", systemData.interval, formatNetwork);
            drawChartForMonitor(systemData.customData4, "custom_monitor_chart_4", "custom_monitor_header_4", systemData.interval, formatNetwork);
            drawChartForMonitor(systemData.customData5, "custom_monitor_chart_5", "custom_monitor_header_5", systemData.interval, formatNetwork);
        }

        function drawChartForMonitor(data, area, titleArea, interval, format) {
            if (data !== '[]') {
                $("#" + area).show();
                $("#" + titleArea).show();
                $("#" + area + "_img_btn").show();
                plot = drawChart(area, data, format, interval);
            } else {
                // need to hide extended custom monitor data chart,if they do not exist.
                $("#" + area).hide();
                $("#" + titleArea).hide();
                $("#" + area + "_img_btn").hide();
            }
        }

    </script>