{*
/*********************************************************************************
 * The contents of this file are subject to the SugarCRM Professional Subscription
 * Agreement ("License") which can be viewed at
 * http://www.sugarcrm.com/crm/products/sugar-professional-eula.html
 * By installing or using this file, You have unconditionally agreed to the
 * terms and conditions of the License, and You may not use this file except in
 * compliance with the License.  Under the terms of the license, You shall not,
 * among other things: 1) sublicense, resell, rent, lease, redistribute, assign
 * or otherwise transfer Your rights to the Software, and 2) use the Software
 * for timesharing or service bureau purposes such as hosting the Software for
 * commercial gain and/or for the benefit of a third party.  Use of the Software
 * may be subject to applicable fees and any use of the Software without first
 * paying applicable fees is strictly prohibited.  You do not have the right to
 * remove SugarCRM copyrights from the source code or user interface.
 *
 * All copies of the Covered Code must include on each user interface screen:
 *  (i) the "Powered by SugarCRM" logo and
 *  (ii) the SugarCRM copyright notice
 * in the same form as they appear in the distribution.  See full license for
 * requirements.
 *
 * Your Warranty, Limitations of liability and Indemnity are expressly stated
 * in the License.  Please refer to the License for the specific language
 * governing these rights and limitations under the License.  Portions created
 * by SugarCRM are Copyright (C) 2004-2011 SugarCRM, Inc.; All Rights Reserved.
 ********************************************************************************/

*}
{{include file=$headerTpl}}
{sugar_include include=$includes}
<div id="{{$module}}_detailview_tabs" 
{{if $useTabs}}
class="yui-navset detailview_tabs"
{{/if}}
>
    {{if $useTabs}}
    {* Generate the Tab headers *}
    {{counter name="tabCount" start=-1 print=false assign="tabCount"}}
    <ul class="yui-nav">
    {{foreach name=section from=$sectionPanels key=label item=panel}}
        {{counter name="tabCount" print=false}}
        <li><a id="tab{{$tabCount}}" href="#tab{{$tabCount}}"><em>{sugar_translate label='{{$label}}' module='{{$module}}'}</em></a></li>
    {{/foreach}}
    </ul>
    {{/if}}
    <div {{if $useTabs}}class="yui-content"{{/if}}>
{{* Loop through all top level panels first *}}
{{counter name="panelCount" print=false start=0 assign="panelCount"}}
{{foreach name=section from=$sectionPanels key=label item=panel}}
{{assign var='panel_id' value=$panelCount}}
<div id='{{$label}}' class='detail view'>
{counter name="panelFieldCount" start=0 print=false assign="panelFieldCount"}
{{* Print out the panel title if one exists*}}

{{* Check to see if the panel variable is an array, if not, we'll attempt an include with type param php *}}
{{* See function.sugar_include.php *}}
{{if !is_array($panel)}}
    {sugar_include type='php' file='{{$panel}}'}
{{else}}
	
	{{if !empty($label) && !is_int($label) && $label != 'DEFAULT' && !$useTabs}}
	<h4>{sugar_translate label='{{$label}}' module='{{$module}}'}</h4>
	{{/if}}
	{{* Print out the table data *}}
	<table id='detailpanel_{{$smarty.foreach.section.iteration}}' cellspacing='{$gridline}'>
	

	
	{{foreach name=rowIteration from=$panel key=row item=rowData}}
	<tr>
		{{assign var='columnsInRow' value=$rowData|@count}}
		{{assign var='columnsUsed' value=0}}
	    {{foreach name=colIteration from=$rowData key=col item=colData}}
	    {{if !empty($colData.field.name)}}
			{if $fields.{{$colData.field.name}}.acl > 0}
		{{/if}}
			<td width='{{$def.templateMeta.widths[$smarty.foreach.colIteration.index].label}}%' scope="row">
				{{if isset($colData.field.customLabel)}}
			       {{$colData.field.customLabel}}
				{{elseif isset($colData.field.label) && strpos($colData.field.label, '$')}}
				   {capture name="label" assign="label"}
				   {{$colData.field.label}}
				   {/capture}
			       {$label|strip_semicolon}:
				{{elseif isset($colData.field.label)}}
				   {capture name="label" assign="label"}
				   {sugar_translate label='{{$colData.field.label}}' module='{{$module}}'}
				   {/capture}
			       {$label|strip_semicolon}:
				{{elseif isset($fields[$colData.field.name])}}
				   {capture name="label" assign="label"}
				   {sugar_translate label='{{$fields[$colData.field.name].vname}}' module='{{$module}}'}
				   {/capture}
			       {$label|strip_semicolon}:
				{{else}}
				   &nbsp;
				{{/if}}
			</td>
			<td width='{{$def.templateMeta.widths[$smarty.foreach.colIteration.index].field}}%' {{if $colData.colspan}}colspan='{{$colData.colspan}}'{{/if}}>
				{{if $colData.field.customCode || $colData.field.assign}}
					{counter name="panelFieldCount"}
					{{sugar_evalcolumn var=$colData.field colData=$colData}}	
				{{elseif $fields[$colData.field.name] && !empty($colData.field.fields) }}
				    {{foreach from=$colData.field.fields item=subField}}
				        {{if $fields[$subField]}}
				        	{counter name="panelFieldCount"}
				            {{sugar_field parentFieldArray='fields' tabindex=$tabIndex vardef=$fields[$subField] displayType='DetailView'}}&nbsp;
				        {{else}}
				        	{counter name="panelFieldCount"}
				            {{$subField}}
				        {{/if}}
				    {{/foreach}}					    		
				{{elseif $fields[$colData.field.name]}}
					{counter name="panelFieldCount"}
					{{sugar_field parentFieldArray='fields' vardef=$fields[$colData.field.name] displayType='DetailView' displayParams=$colData.field.displayParams typeOverride=$colData.field.type}}
				{{/if}}
			</td>
		{{if !empty($colData.field.name)}}
			{else}
			
			<td scope="row">&nbsp;</td><td>&nbsp;</td>
			{/if}
		{{/if}}
		{{/foreach}}
	</tr>
	{{/foreach}}
	</table>
{{/if}}
</div>
{if $panelFieldCount == 0}

<script>document.getElementById("{{$label}}").style.display='none';</script>
{/if}
{{/foreach}}
</div>
<div id="store_ppg_review">
	    <table id="table_store_ppg_review" class = "edit view">
	        <caption>Store PPG Review</caption>
	        <thead>
	            <tr> 
	            <th></th>
	            <th>Store Audit Completed</th>
	            <th>PPG Review Completed</th>
	            <th>Growth % on brand</th>
	            <th>Comments , action taken</th>
	            </tr>
	        </thead>
	        <tbody>
	        {{foreach name=pgReview from=$ppgs key=ppg_key item=ppg}}
	            <tr>
	                <td>{{$ppg.name}}</td>
	                <td><input class="checkbox" name="ppg_audit[{{$ppg_key}}]" type="checkbox" value="{{$ppg.audit}}" {{$ppg.audit_check_box}} disabled=true /></td>
	                <td><input class="checkbox" name="ppg_completed[{{$ppg_key}}]" type="checkbox" value="{{$ppg.ppg}}" {{$ppg.ppg_check_box}} disabled=true /></td>
	                <td><span name="ppg_growth[{{$ppg_key}}]" >{{$ppg.growth}}</span></td>
	                <td><p name="ppg_comment[{{$ppg_key}}]">{{$ppg.comment}}</p></td>
	            </tr>
	        {{/foreach}}
	        </tbody>
	    </table>
	</div>
</div>
{{include file=$footerTpl}}
{{if $useTabs}}
<script type="text/javascript" src="include/javascript/sugar_grp_yui_widgets.js"></script>
<script type="text/javascript">
var {{$module}}_detailview_tabs = new YAHOO.widget.TabView("{{$module}}_detailview_tabs");
{{$module}}_detailview_tabs.selectTab(0);
</script> 
{{/if}}