<div class="row">
	<div class="span6">
		<fieldset>
			<legend><@spring.message "perfTest.configuration.basicConfiguration"/></legend>
		</fieldset>
		<div class="form-horizontal form-horizontal-2">

			<div class="control-group">

                <div class="row">
                    <div class="span4">
                        <div class="control-group">
                            <label for="agent_count" class="control-label">
							<@spring.message "perfTest.configuration.agent"/>
                            </label>
                            <div class="controls">
							<@input_append name="agentCount"
									value="${(test.agentCount)!0}"
									message="perfTest.configuration.agent"
									append_prefix="perfTest.configuration.max" append='<span id="maxAgentCount"></span>' />
							</div>
                            <div id="err_agent_count" class="small_error_box" style="margin-left:120px;">
                            </div>
                        </div>
                    </div>
					<div class="span2">
						<#if clustered == true>
							<label for="region" class="control-label" style="margin-left:-50px;width:80px">
								<@spring.message "perfTest.configuration.region"/>
								<span rel="popover" data-html="true"
									data-content='<@spring.message "perfTest.configuration.region.help"/>' 
									data-placement='top' title='<@spring.message "perfTest.configuration.region"/>' > 
									<i class="icon-question-sign" style="vertical-align: middle;"></i>
								</span>
							</label> 
							<select id="region" name="region" class="pull-right" style="width: 110px">
								<#list regionList as eachRegion>
									<option value="${eachRegion}" <#if (test.region?? && test.region == eachRegion)>selected</#if> >
										<@spring.message "${eachRegion}"/>
									</option> 
								</#list>
							</select> 
							<div id="err_region">
							</div>
						</#if>
					</div>
				</div>
			</div>
			<div class="control-group">
				<label for="vuser_per_agent" class="control-label">
					<@spring.message "perfTest.configuration.vuserPerAgent"/>
				</label>
				<div class="controls">
					<@input_append name="vuserPerAgent"
						value="${(test.vuserPerAgent)!1}"
						message="perfTest.configuration.vuserPerAgent"
						append_prefix="perfTest.configuration.max" append="${(maxVuserPerAgent)!0}" />
					<i class="pointer-cursor expand" id="expand_collapse_btn"></i>
					<div class="pull-right">
						<span class="badge badge-info pull-right"
							  style="padding:7px 20px 7px 20px;-webkit-border-radius:20px;border-radius:20px;-moz-border-radius:20px">
							<span id="vuserlabel"><@spring.message "perfTest.configuration.availVuser"/></span><span
								id="total_vuser"></span>
						</span>
					</div>
					<div id="process_thread_config_panel" style="display: none;">
						<@input_prepend name="processes" value="${test.processes}" message="perfTest.report.process"
							extraCss="control-group" />
						<@input_prepend name="threads" value="${test.threads}" message="perfTest.report.thread"
							extraCss="control-group" />
					</div>
				</div>
			</div>
			<div class="control-group" id="script_control">
				<label for="script_name" class="control-label">
					<@spring.message "perfTest.configuration.script"/>
				</label>
				<div class="controls">
					<select id="script_name" class="required" name="scriptName" style="width: 275px" old_script="<#if quickScript??>${quickScript}<#else>${(test.scriptName)!}</#if>" />
					<input type="hidden" id="script_revision"
						name="scriptRevision"
						value="${(test.scriptRevision)!-1}"
						old_revision="${(test.scriptRevision)!-1}"/>
					<button class="btn btn-mini btn-info pull-right" type="button"
						id="show_script_btn"
						style="margin-top: 3px; display: none;">R
						<#if test.scriptRevision != -1>
							${test.scriptRevision}
						<#else>
							<#if quickScriptRevision??>${quickScriptRevision}<#else>HEAD</#if>
						</#if>
					</button>
				</div>
			</div>
			<div class="control-group">
				<label for="Script Resources" class="control-label">
					<@spring.message "perfTest.configuration.scriptResources"/>
				</label>
				<div class="controls">
					<div class="div-resources" id="scriptResources"></div>
				</div>
			</div>
			<div class="control-group">
				<label class="control-label">
					<@spring.message "perfTest.configuration.targetHost"/></label>
					<#assign targetHosts = test.targetHosts>
				<div class="controls">
					<#include "host.ftl">
				</div>
			</div>
			<hr>
			<div class="control-group">
				<label class="control-label"> 
					<input type="radio" id="duration_ratio" name="threshold" value="D"
						<#if test.threshold == "D">checked</#if>/>
					<@spring.message "perfTest.configuration.duration"/>
				</label>
				<div class="controls docs-input-sizes">
					<select class="select-item" id="select_hour"></select> : 
					<select class="select-item" id="select_min"></select> : 
					<select	class="select-item" id="select_sec"></select> &nbsp;&nbsp;
					<code>HH:MM:SS</code>
					<input type="hidden" id="duration" name="duration" value="${test.duration}"/>
					<input type="hidden" id="duration_hour" name="durationHour" value="0"/>
					<div id="duration_slider" class="slider" style="margin-left: 0; width: 255px"></div>
					<input id="hidden_duration_input" class="hide" data-step="1"/>
				</div>
			</div>
            <div class="control-group">
                <label for="run_count" class="control-label">
                    <input type="radio" id="run_count_radio" name="threshold" value="R"
						   <#if test.threshold == "R" >checked</#if>/>
				<@spring.message "perfTest.configuration.runCount"/>
                </label>

                <div class="controls">
				<@input_append  name="runCount"
						value="${(test.runCount)!0}"
						message="perfTest.configuration.runCount"
						others='number_limit="${(maxRunCount)}"'
						append_prefix="perfTest.configuration.max" append="${(maxRunCount)!0}" />
                </div>
            </div>
			<div class="control-group">
				<div class="row">
					<div class="span3">
						<div class="control-group">
							<label for="sampling_interval" class="control-label">
								<@spring.message "perfTest.configuration.samplingInterval"/>
							</label>
							<div class="controls">
								<#assign samplingIntervalArray = [1,2,3,4,5,10,30,60]> 
								<select class="select-item" id="sampling_interval" name="samplingInterval"> 
									<#list samplingIntervalArray as eachInterval>
										<option value="${eachInterval}"
											<#if test.samplingInterval != 0>
												<#if eachInterval == test.samplingInterval> selected="selected" </#if> 
											<#else> 
												<#if eachInterval == 2>
													selected="selected" 
												</#if> 
											</#if> >
											${eachInterval}
										</option>
									</#list>
								</select>
							</div>
						</div>
					</div>
					<div class="span3">
						<div class="control-group">
							<label for="ignore_sample_count" class="control-label" style="width: 150px;margin-left:-20px">
								<@spring.message "perfTest.configuration.ignoreSampleCount"/>
							</label>
							<div class="controls">
								<@input_popover name="ignoreSampleCount"
									value="${test.ignoreSampleCount}"
									message="perfTest.configuration.ignoreSampleCount"
									extraCss="input-mini" />
							</div>
							<div id="err_ignore_sample_count" class="small_error_box" style="margin-left:100px">
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="control-group">
				<div class="row">
					<div class="span3"> 
						<div class="control-group">
							<label for="safeDistribution" class="control-label"> 
								<@spring.message "perfTest.configuration.safeDistribution"/>
							</label>
							<div class="controls">
								<input type="checkbox" id="safe_distribution_checkbox" name="safeDistribution"
								<#if test.safeDistribution == true>checked<#else><#if safeFileDistribution?default(false)==true>checked</#if> </#if> />
								<span style="margin-top: 10px; margin-left: 10px" 
									rel='popover' data-html='true'
									data-content='<@spring.message "perfTest.configuration.safeDistribution.help"/>' 
									title='<@spring.message "perfTest.configuration.safeDistribution"/>'
									id="dist_comment"> 
									<i class="pointer-cursor icon-question-sign" style="margin-top:5px"></i>
								</span> 
							</div>
						</div>
					</div>
					<div class="span3">
						<div class="control-group">
							<label for="param" class="control-label" style="width:70px;margin-left:-20px">
								<@spring.message "perfTest.configuration.param"/>
							</label>
							<div class="controls" style="margin-left:70px">
								<@input_popover name = "param"
									value = "${(test.param?html)}"
									message ="perfTest.configuration.param"
									others = 'style="width:120px"'/>
							</div>
							<div id="err_param" class="small_error_box" style="margin-left:-25px">
							</div>
						</div>
					</div>					
				</div>
			</div>
		</div>
	</div>
	<!-- end test content left -->

	<div class="span6">
		<fieldset>
			<legend>
				<input type="checkbox" id="use_ramp_up" name="useRampUp" style="vertical-align: middle; margin-bottom:5px"
					<#if test.useRampUp == true>checked</#if> />
				<@spring.message "perfTest.configuration.rampEnable"/>
			</legend>
		</fieldset>
		<div class="form-horizontal form-horizontal-2">
			<div class="control-group">
				<div class="row">
					<div class="span3">
						<@input_label name="initProcesses"
							value="${test.initProcesses}" message="perfTest.configuration.initalProcesses" />
					</div>

					<div class="span3">
						<@input_label name="processIncrement"
							value="${test.processIncrement}" message="perfTest.configuration.rampup" />
					</div>
				</div>
				<div class="row">
					<div class="span3">
						<@input_label name="initSleepTime"
							value="${test.initSleepTime}"
							message="perfTest.configuration.initalSleepTime" others="<code>MS</code>" />
					</div>
					<div class="span3">
						<@input_label name="processIncrementInterval"
							value="${test.processIncrementInterval}"
							message="perfTest.configuration.processesEvery" others="<code>MS</code>" />
					</div>
				</div>
			</div>
		</div>
		<legend class="center" style="margin-top:0px;padding-top:0px"> <@spring.message "perfTest.configuration.rampUpDes"/> </legend>
		<div id="rampup_chart" class="rampup-chart" style="margin-left: 20px"></div>
	</div>
	<!-- end test content right -->
</div>