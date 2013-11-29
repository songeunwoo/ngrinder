<#ftl strip_whitespace = true>
<#--
 * ngrinder_macros.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common html component blocks.
 *
 -->

<#function toUnderscore camelCase>
	<#return camelCase?replace("[A-Z]", "_$0", 'r')?lower_case>
</#function>

<#macro input_append name, value, message, others = "", append = "", append_prefix = "">
	<div class="input-append">
		<input type="text" class="input input-mini"
			   rel="popover" id ="${toUnderscore(name)}" name="${name}"
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

<#macro input_label name, value, message, others = "">
	<div class="control-group">
		<label for="${toUnderscore(name)}" class="control-label">
			<@spring.message "${message}"/>
		</label>
		<div class="controls">
			<input type="text" class="input input-mini" id="${toUnderscore(name)}" name="${name}"
				   value="${value}" style="width:40px"/>


			<#if others!="">${others}</#if>
		</div>
		<div id="err_${toUnderscore(name)}" style="margin-bottom: 0px;height: 15px;line-height:15px"></div>
	</div>
</#macro>

<#macro list list_items colspan = "8">
	<#if list_items?has_content>
		<#list list_items as each>
			<#nested each each_index>
		</#list>
	<#else>
    <tr>
        <td colspan="${colspan}" class="center"><@spring.message "common.message.noData"/></td>
    </tr>
	</#if>
</#macro>