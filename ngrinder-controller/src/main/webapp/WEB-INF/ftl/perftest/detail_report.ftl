<!DOCTYPE html>
<html>
	<head>
		<#include "../common/common.ftl">
		<#include "../common/jqplot.ftl">
		<title><@spring.message "perfTest.report.title"/></title>
		
		<style> 
			body {
				padding-top: 0;
			}	
			.left {
				border-right: 1px solid #878988
			}
			div.chart {
				border: 1px solid #878988; 
				height: 200px; 
				min-width: 615px; 
			}
			div.bigchart {
				border: 1px solid #878988; 
				height: 300px; 
				min-width: 615px; 
			}
			h6 {
				margin-top: 20px;
			}
			td strong {
				color: #6DAFCF
			}
			.jqplot-yaxis {
			    margin-right: 10px;
			}
			.jqplot-xaxis {
			    margin-right: 5px;
       			margin-top: 5px; 
			}
			.compactpadding th {
				padding: 8px 5px;
				vertical-align: middle;
			}
			.jqplot-image-button {
			    margin-top: 5px;
			    margin-bottom: 5px;
			}
			div.jqplot-image-container {
			    position: relative;
			    z-index: 11;
			    margin: auto;
			    display: none;
			    background-color: #ffffff;
			    border: 1px solid #999;
			    display: inline-block;
			    min-width: 698px;   
			}
			div.jqplot-image-container-header {
			    font-size: 1.0em;
			    font-weight: bold;
			    padding: 5px 15px;
			    background-color: #eee;
			}
			div.jqplot-image-container-content {
			    background-color: #ffffff;
			}
			a.jqplot-image-container-close {
			    float: right;
			}
		</style>
	</head>

	<#setting number_format="number"> 
	<body>
		<div class="navbar-inner" style="width:912px; margin-left:auto; margin-right:auto; margin-bottom:0">
			<h3><@spring.message "perfTest.report.reportPage"/> ${test.testName}</h3>
		</div>
	<div class="container">
	   <form name="download_csv_form">
	       <input type="hidden" id="test_id" name="testId" value="${test.id}">
	   </form>
		<div class="row">
			<div class="span3">
			    <table class="table table-bordered compactpadding">
				    <colgroup>
						<col width="120px">
						<col>
				    </colgroup>
			        <tr>
			       	   <th><@spring.message "perfTest.report.vusersPerAgent"/></th>
			           <td><strong>${test.vuserPerAgent}</strong></td>
			        </tr>
			        <tr>
                       <th><@spring.message "perfTest.report.agent"/></th>
                       <td><span>${test.agentCount}</span>
                    </tr>
                    <tr>
                       <th><@spring.message "perfTest.report.process"/></th>
                       <td>${test.processes}</td>
                    </tr>
                    <tr>
                       <th><@spring.message "perfTest.report.thread"/></th>
                       <td>${test.threads}</td>
                    </tr>
                    <tr>
                        <td colspan="2" class="divider"></td>
                    </tr>
                    <#if test.threshold?? && test.threshold == "D">
	                   <tr>
	                       <th><@spring.message "perfTest.configuration.duration"/></th>
	                       <td><span>${test.durationStr}</span> <code>HH:MM:SS</code></td>
	                   </tr>
                    <#else>
                   		<tr>
	                       <th><@spring.message "perfTest.configuration.runCount"/></th>
	                       <td><span>${test.runCount}</td>
	                   </tr>
                    </#if>
                    <tr>
	                    <th><@spring.message "perfTest.configuration.runtime"/></th>
	                    <td><span>${test.runtimeStr}</span> <code>HH:MM:SS</code></td>
	                </tr>
                    <tr>
                        <th><@spring.message "perfTest.configuration.ignoreSampleCount"/></th>
                        <td><span>${test.ignoreSampleCount}</span></td>
                    </tr>
                    <tr>
                        <td colspan=2></td>
                    </tr>
                    <tr>
                        <th>TPS</th>
                        <td><strong><#if test.tps??>${(test.tps)?string(",##0.#")}</#if></strong></td>
                    </tr>
                    <tr>
                        <th><@spring.message "perfTest.report.meantime"/></th>
                        <td><span>${(test.meanTestTime!0)?string(",##0.##")}</span>&nbsp;&nbsp; <code>ms</code></td>
                    </tr>
                    <tr>
                        <th><@spring.message "perfTest.report.peakTPS"/></th>
                        <td><strong>${test.peakTps!""}</strong></td>
                    </tr>
                    <tr>
                        <th><@spring.message "perfTest.report.totalTests"/></th>
                        <td>${(test.tests + test.errors)!""}</td>
                    </tr>
                    <tr>
                        <th><@spring.message "perfTest.report.successfulTests"/></th>
                        <td>${(test.tests)!""}</td>
                    </tr>
                    <tr>
                        <th><@spring.message "perfTest.report.errors"/></th>
                        <td>${test.errors!""}</td>
                    </tr>
			    </table>
			    <ul class="nav nav-list">
					<li class="active">
						<a id="test_btn" href="javascript:void(0);">
							<i class="icon-tag icon-white"></i> <@spring.message "perfTest.report.performanceReport"/>
						</a>
					</li>
					<li><a><i class="icon-tags"></i> <@spring.message "perfTest.report.targetHost"/></a></li>
					<#if test.targetHostIP?exists>
					<li>
						<ul class="nav nav-list">
							<#list test.targetHostIP as targetIp>
							<li><a class="target-montor" href="javascript:void(0);" ip="${targetIp}"><i class="icon-chevron-right"></i> ${targetIp}</a></li>
							</#list>
						</ul>
					</li>
			        </#if>
                    <#list pluginList as pluginName>
                    <li><a><i class="icon-tags"></i> ${pluginName}</a></li>
                        <li>
                           <ul class="nav nav-list">
                               <#list test.targetHostIP as targetIp>
                                   <li><a class="plugin-montor" href="javascript:void(0);" ip="${targetIp}" plugin="${pluginName}">
                                       <i class="icon-chevron-right"></i> ${targetIp}
                                   </a></li>
                               </#list>
                           </ul>
                        </li>
                    </#list>
			    </ul>
			</div>
			<div class="span9">
			    <table class="table table-bordered" style="margin-bottom:35px">
			    	<colgroup>
						<col width="120">
						<col width="220">
						<col width="120">
						<col>
					</colgroup>
                   <tr>
                       <th><@spring.message "perfTest.table.startTime"/></th>
                       <td><span><#if test.startTime??>${test.startTime?string('yyyy-MM-dd HH:mm:ss')}<#else>&nbsp;</#if></span></td>
                       <th><@spring.message "perfTest.table.finishTime"/></th>
                       <td><span><#if test.finishTime??>${test.finishTime?string('yyyy-MM-dd HH:mm:ss')}<#else>&nbsp;</#if></span></td>
                   </tr>
                   <tr>
                     	<th><@spring.message "perfTest.report.testcomment"/></th>
                    	<td colspan="3">${(test.testComment)!?html?replace('\n', '<br>')}</td>
                   </tr>  
                </table>
			    <div id="detail_panel">
				</div>
			</div>
		</div>
		<#include "../common/copyright.ftl">
	</div>
	<#include "../common/messages.ftl">
	
	<!-- For jqplot legend -->
	<script src="${req.getContextPath()}/plugins/jqplot/plugins/jqplot.enhancedLegendRenderer.min.js"></script>
	<script src="${req.getContextPath()}/js/generate-img.js"></script>
	<script>
	    var performanceInit = false;
	    var targetMonitorData = {}; //save monitor data
        var targetPluginData = {}; //save plugin monitor data
        var performanceData;  // save performance data
	    var imgBtnLabel = "<@spring.message "perfTest.report.exportImg.button"/>";
	    var imgTitle = "<@spring.message "perfTest.report.exportImg.title"/>"
    	
		$(document).ready(function() {
		    $("#test_btn").click(function() {
                generatePerformanceChart();
		        changActiveLink($(this));
		    });
		    
		    $("a.target-montor").click(function() {
                var $elem = $(this);
                generateMonitorChart($elem.attr("ip"));
                changActiveLink($elem);
            });

            $("a.plugin-montor").click(function() {
                var $elem = $(this);
                var pluginName = $elem.attr("plugin");
                generatePluginChart(pluginName, $elem.attr("ip"));
                changActiveLink($elem);
            });

            $.ajaxSetup({"cache":false});
            generatePerformanceChart();
		});
		
		function changActiveLink(obj) {
			$("li").removeClass("active");
			$("ul.nav-list i.icon-white").removeClass("icon-white");
			obj.parent("li").addClass("active");
			obj.children("i").addClass("icon-white");
		}

		function generatePerformanceChart(){
            $("#detail_panel").load("${req.getContextPath()}/perftest/${(test.id)?c}/detail_report_perf", {},  function() {
                    if (performanceData == undefined) {
                        getPerformanceDataAndDraw(${(test.id)?c});
                    } else {
                        drawPerformanceChart(performanceData);
                    }
                });
        }

        function generateMonitorChart(ip){
            $("#detail_panel").load("${req.getContextPath()}/perftest/${(test.id)?c}/detail_report_target", function() {
                    if (!targetMonitorData[ip]) {
                        getTargetMonitorDataAndDraw(${(test.id)?c}, ip);
                    } else {
                        drawMonitorChart(targetMonitorData[ip]);
                    }
                });
        }

        function generatePluginChart(pluginName, ip){
            $("#detail_panel").load("${req.getContextPath()}/perftest/${(test.id)?c}/detail_report_target_plugin?pluginName=" + pluginName, function() {
                var pluginDataMap = targetPluginData[pluginName];
                if (!pluginDataMap || !pluginDataMap[ip]) {
                    getTargetPluginDataAndDraw(${test.id}, pluginName, ip);
                } else {
                    drawPluginChart(pluginDataMap[ip]);
                }
            });
        }
              

	</script>
	</body>
</html>
