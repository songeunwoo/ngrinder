<#ftl strip_whitespace=true>
<#--
 * html_component.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common html component blocks.
 *
 -->

<#macro input name,value,message,id="",others="",append="",append_prefix="">

	<#assign inputId = id>

	<#if id==""><#assign inputId=name?replace("[A-Z]", "_$0", 'r')?lower_case></#if>

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