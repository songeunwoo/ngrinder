<#ftl strip_whitespace=true>
<#--
 * html_component.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common html component blocks.
 *
 -->

<#function toUnderscore camelCase>
	<#return camelCase?replace("[A-Z]", "_$0", 'r')?lower_case>
</#function>

<#macro input_append name,value,message,id="",others="",append="",append_prefix="">

	<#if id==""><#assign inputId=toUnderscore(name)></#if>

	<div class="input-append">
		<input type="text" class="input input-mini"
			   rel="popover" id="${inputId}" name="${name}"
			   value="${value}" data-html="true"
			   data-content='<@spring.message "${message}.help"/>'
			   title='<@spring.message "${message}"/>'
			<#if others!="">${others}</#if> />

		<#if append!="">
			<span class="add-on">
				<@spring.message "${append_prefix}"/>
				${append}
			</span>
		</#if>
	</div>
</#macro>

<#macro input_label name,value,message,id="",others="">

	<#if id==""><#assign inputId=toUnderscore(name)></#if>
	<div class="control-group">
		<label for="${inputId}" class="control-label">
			<@spring.message "${message}"/>
		</label>
		<div class="controls">
			<input type="text" class="input input-mini" id="${inputId}" name="${name}"
				   value="${value}" style="width:40px"/>
			<#if others!="">${others}</#if>
		</div>
		<div id="err_${inputId}" style="margin-bottom: 0px;height: 15px;line-height:15px"></div>
	</div>
</#macro>