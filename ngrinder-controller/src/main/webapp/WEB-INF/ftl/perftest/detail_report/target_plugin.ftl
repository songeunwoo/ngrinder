
    <div class="page-header">
        <h4>${reportCategory}</h4>
    </div>

    <div id="chart_container">
    </div>


    <script>
        var currentTestId = 0;
        $(document).ready(function() {

        });

        function getTargetPluginDataAndDraw(testId, reportCategory, ip) {
            currentTestId = testId;
            $.ajax({
                url: "${req.getContextPath()}/perftest/"+testId+"/detail_report/target/"+reportCategory+"/graph",
                dataType:'json',
                cache: true,
                data: {'targetIP': ip, 'imgWidth': 700}
            }).done(function(result) {
                if (!targetPluginData[reportCategory]) {
                    targetPluginData[reportCategory] = {};
                }
                var dataMapOfPlugin = targetPluginData[reportCategory];
                dataMapOfPlugin[ip] = result;
                drawPluginChart(result);
            }).fail(function() {
                showErrorMsg("Get monitor data failed!");
            });
        }

        function drawPluginChart(currMonitorData) {
            var headerStr = currMonitorData['header'];
            var headerList = eval(headerStr);
            var $container = $("#chart_container");

            for (var i = 0; i < headerList.length; i++) {
                var currentHead = headerList[i];
                $container.append("<h6>" + currentHead + "</h6><div id='"+ currentHead +"' class='chart'></div>");
                var currentData = currMonitorData[currentHead];
                var dataFormat;
                var currentHeadLow = currentHead.toLowerCase();

                if (currentHeadLow.lastIndexOf("cpu") >= 0) {
                    dataFormat = formatPercentage;
                } else if (currentHeadLow.lastIndexOf("memory") >= 0 || currentHeadLow.lastIndexOf("heap") >= 0) {
                    dataFormat = formatMemoryInByte;
                } else {
                    dataFormat = null;
                }

                checkDataAndDraw(currentHead, currentData, dataFormat, currMonitorData.interval);
            }
            generateImg(imgBtnLabel, imgTitle);
        }

    </script>