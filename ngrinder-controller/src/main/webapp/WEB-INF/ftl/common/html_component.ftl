<#ftl strip_whitespace=true>
<#--
 * html_component.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common html component blocks.
 *
 -->

<#macro input id,name,value,message,others="",append_prefix="",append="">
	<div class="input-append">
		<input type="text" class="input input-mini"
			   rel="popover" id="${id}" name="${name}"
			   value="${value}" data-html="true"
			   data-content='<@spring.message "${message}.help"/>'
			   title='<@spring.message "${message}"/>'
			<#if others?length!=0>${others}</#if> />

		<#if append_prefix?length!=0>
			<span class="add-on">
				<@spring.message "${append_prefix}"/>
				<#if append?length!=0>
				${append}
				</#if>
			</span>
		</#if>
	</div>
</#macro>