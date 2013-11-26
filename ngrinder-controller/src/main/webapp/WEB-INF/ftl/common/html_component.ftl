<#ftl strip_whitespace=true>
<#--
 * html_component.ftl
 *
 * This file consists of a collection of FreeMarker macros aimed at easing
 * some of the common html component blocks.
 *
 -->

<#macro input id,name,value,dataContent,title,others>
	<div class="input-append">
		<input type="text" class="input input-mini"
			   rel="popover" id="${id}" name="${name}"
			   value="${value}" data-html="true"
			   data-content='${dataContent}'
			   title='${title}'
		${others}/>
		<#nested>
	</div>
</#macro>