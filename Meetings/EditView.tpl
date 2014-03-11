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

<div id="{{$form_name}}_tabs" 
{{if $useTabs}}
class="yui-navset"
{{/if}}
>
    {{if $useTabs}}
    {* Generate the Tab headers *}
    {{counter name="tabCount" start=-1 print=false assign="tabCount"}}
    <ul class="yui-nav">
    {{foreach name=section from=$sectionPanels key=label item=panel}}
        {{counter name="tabCount" print=false}}
        <li class="selected"><a id="tab{{$tabCount}}" href="#tab{{$tabCount}}"><em>{sugar_translate label='{{$label}}' module='{{$module}}'}</em></a></li>
    {{/foreach}}
    </ul>
    {{/if}}
    <div {{if $useTabs}}class="yui-content"{{/if}}>
{{* Loop through all top level panels first *}}
{{counter name="panelCount" start=-1 print=false assign="panelCount"}}

{{foreach name=section from=$sectionPanels key=label item=panel}}
{{counter name="panelCount" print=false}}

{{* Print out the table data *}}
<div id="{{$label}}">
{counter name="panelFieldCount" start=0 print=false assign="panelFieldCount"}
{{* Check to see if the panel variable is an array, if not, we'll attempt an include with type param php *}}
{{* See function.sugar_include.php *}}
{{if !is_array($panel)}}
    {sugar_include type='php' file='{{$panel}}'}
{{else}}

<table width="100%" border="0" cellspacing="1" cellpadding="0"  class="{$def.templateMeta.panelClass|default:'edit view'}">
{{* Only show header if it is not default or an int value *}}
{{if !empty($label) && !is_int($label) && $label != 'DEFAULT' && !$useTabs && $showSectionPanelsTitles}}
<tr>
<th align="left" colspan="8">
<h4>{sugar_translate label='{{$label}}' module='{{$module}}'}</h4>
</th>
</tr>
{{/if}}

{{assign var='rowCount' value=0}}
{{foreach name=rowIteration from=$panel key=row item=rowData}}
<tr>

	{{assign var='columnsInRow' value=$rowData|@count}}
	{{assign var='columnsUsed' value=0}}

    {{* Loop through each column and display *}}
    {{counter name="colCount" start=0 print=false assign="colCount"}}

	{{foreach name=colIteration from=$rowData key=col item=colData}}

	{{counter name="colCount" print=false}}
	{{math assign="tabIndex" equation="$panelCount * $maxColumns + $colCount"}}
	{{if count($rowData) == $colCount}}
		{{assign var="colCount" value=0}}
	{{/if}}

	{{if !empty($colData.field.name)}}
		{if $fields.{{$colData.field.name}}.acl > 1 || ($showDetailData && $fields.{{$colData.field.name}}.acl > 0)}
	{{/if}}

		{{if empty($def.templateMeta.labelsOnTop) && empty($colData.field.hideLabel)}}
		<td valign="top" id='{{$colData.field.name}}_label' width='{{$def.templateMeta.widths[$smarty.foreach.colIteration.index].label}}%' scope="row">
			{{if isset($colData.field.customLabel)}}
			   {{$colData.field.customLabel}}
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
			{{/if}}
			{{* Show the required symbol if field is required, but override not set.  Or show if override is set *}}
			{{if ($fields[$colData.field.name].required && !isset($colData.field.displayParams.required)) || 
			     (isset($colData.field.displayParams.required) && $colData.field.displayParams.required && $fields[$colData.field.name].required !== false)}}
			    <span class="required">{{$APP.LBL_REQUIRED_SYMBOL}}</span>
			{{/if}}
		</td>
		{{/if}}

		<td valign="top" width='{{$def.templateMeta.widths[$smarty.foreach.colIteration.index].field}}%' {{if $colData.colspan}}colspan='{{$colData.colspan}}'{{/if}}>
			{{if !empty($def.templateMeta.labelsOnTop)}}
				{{if isset($colData.field.label)}}
				    {{if !empty($colData.field.label)}}
			   		    {sugar_translate label='{{$colData.field.label}}' module='{{$module}}'}:
				    {{/if}}
				{{elseif isset($fields[$colData.field.name])}}
			  		{sugar_translate label='{{$fields[$colData.field.name].vname}}' module='{{$module}}'}:
				{{/if}}
				
				{{* Show the required symbol if field is required, but override not set.  Or show if override is set *}}
				{{if ($fields[$colData.field.name].required && (!isset($colData.field.displayParams.required) || $colData.field.displayParams.required)) || 
				     (isset($colData.field.displayParams.required) && $colData.field.displayParams.required)}}
				    <span class="required" title="{{$APP.LBL_REQUIRED_TITLE}}">{{$APP.LBL_REQUIRED_SYMBOL}}</span>
				{{/if}}
				{{if !isset($colData.field.label) || !empty($colData.field.label)}}
				<br>
				{{/if}}
			{{/if}}

		{{if !empty($colData.field.name)}}
			{if $fields.{{$colData.field.name}}.acl > 1}
		{{/if}}
			
			{{if $fields[$colData.field.name] && !empty($colData.field.fields) }}
			    {{foreach from=$colData.field.fields item=subField}}
			        {{if $fields[$subField.name]}}
			        	{counter name="panelFieldCount"}
			            {{sugar_field parentFieldArray='fields' tabindex=$colData.field.tabindex vardef=$fields[$subField.name] displayType='EditView' displayParams=$subField.displayParams formName=$form_name}}&nbsp;
			        {{/if}}
			    {{/foreach}}
			{{elseif !empty($colData.field.customCode)}}
				{counter name="panelFieldCount"}
				{{sugar_evalcolumn var=$colData.field.customCode colData=$colData tabindex=$colData.field.tabindex}}
			{{elseif $fields[$colData.field.name]}}
				{counter name="panelFieldCount"}
			    {{$colData.displayParams}}
				{{sugar_field parentFieldArray='fields' tabindex=$colData.field.tabindex vardef=$fields[$colData.field.name] displayType='EditView' displayParams=$colData.field.displayParams typeOverride=$colData.field.type formName=$form_name}}
			{{/if}}
		{{if !empty($colData.field.name)}}
		{{if $showDetailData }}
		{else}
			{{if $fields[$colData.field.name] && !empty($colData.field.fields) }}
			    {{foreach from=$colData.field.fields item=subField}}
			        {{if $fields[$subField.name]}}
			        	
			            {{sugar_field parentFieldArray='fields' tabindex=$colData.field.tabindex vardef=$fields[$subField.name] displayType='DetailView' displayParams=$subField.displayParams formName=$form_name}}&nbsp;
			        {{/if}}
			    {{/foreach}}
			{{elseif !empty($colData.field.customCode)}}
				<td></td><td></td>
			{{elseif $fields[$colData.field.name]}}
			    {{$colData.displayParams}}
			    {counter name="panelFieldCount"}
				{{sugar_field parentFieldArray='fields' tabindex=$colData.field.tabindex vardef=$fields[$colData.field.name] displayType='DetailView' displayParams=$colData.field.displayParams typeOverride=$colData.field.type formName=$form_name}}
			{{/if}}
		</td>
		{{/if}}

		{/if}

		{else}

		  <td></td><td></td>

	{/if}

	{{else}}

		</td>
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

<div id="store_tab">

<ul id="tablist">
    <li><a onclick="show_dg_store(this,'store_ppg_review')">Store ppg review</a></li>
    <li><a onclick="show_dg_store(this,'store_training')">Store training</a></li>
    <li><a onclick="show_dg_store(this,'store_planogram')">Store planogram</a></li>
    <li><a onclick="show_dg_store(this,'store_feedback')">Store feedback</a></li>
    <li><a onclick="show_dg_store(this,'store_medico')">Medico</a></li>
    <li><a onclick="show_dg_store(this,'store_medical')">Medical</a></li>
    <li><a onclick="show_dg_store(this,'store_clinician')">Clinicians</a></li>
</ul>

<div id="store_ppg_review" class="db_store">
    <table id="table_store_ppg_review" class = "edit view">
        <caption>Store PPG Review</caption>
        <thead>
            <tr> 
            <th></th>
            <th>Store Audit Completed</th>
            <th>PPG Review Completed</th>
            <th>Growth % on brand (key in a number not text)</th>
            <th>Comments , action taken</th>
            </tr>
        </thead>
        <tbody>
        {foreach name=pgReview from=$ppgs key=ppg_key item=ppg}
            <tr>
                <td>{$ppg.name}</td>
                <td><input name="ppg_audit[{$ppg.brand_id}]" type="checkbox" value="{$ppg.audit}" {$ppg.audit_check_box} /></td>
                <td><input name="ppg_completed[{$ppg_key}]" type="checkbox" value="{$ppg.ppg}" {$ppg.ppg_check_box} /></td>
                <td><input name="ppg_growth[{$ppg_key}]" type="text" value="{$ppg.growth}" /></td>
                <td><textarea rows="3" cols="40" name="ppg_comment[{$ppg_key}]">{$ppg.comment}</textarea></td>
            </tr>
        {/foreach}
        </tbody>
    </table>
</div>

<div id="store_training" class="db_store">
   <table id="table_store_training" class = "edit view">
        <caption>Store Training</caption>
        <thead>
            <tr> 
            <th></th>
            <th>Training Type</th>
            <th>Retail Staff Incentive set</th>
            <th>Growth Target % Increase (input a number)</th>
            
            </tr>
        </thead>
        <tbody>
        {foreach name=storeTraining from=$training key=training_key item=tran}
	            <tr>
	                <td>{$tran.name}</td>
	                <td>
	                    <select name="store_training_type[{$training_key}]">
	                        {foreach name=storeList from=$training_type key=type_key item=type_value}
	                            {if $type_key == $tran.type}
	                                <option value="{$type_key}" selected="selected">{$type_value}</option>
	                            {else}
	                                <option value="{$type_key}">{$type_value}</option>
	                            {/if}
	                        {/foreach}
	                    </select>
	                </td>
	                <td><input class="checkbox" name="store_training_retail[{$training_key}]" type="checkbox" value="{$tran.retail}" {$tran.retail_check_box}  /></td>
	                <td><input name="store_training_growth[{$training_key}]" value="{$tran.growth}" size = "16"/></td>
	            </tr>
	        {/foreach}
        </tbody>
    </table> 
</div>

<div id="store_planogram" class="db_store">
<table id="table_store_planogram" class = "edit view">
	        <caption>Store Planogram</caption>
	        <thead>
	            <tr> 
	            <th></th>
	            <th>Compliant</th>
	            <th>Comment, action taken</th>
	            <th>attached photo 1 if not compliant</th>
	            <th>attached photo 2 if not compliant</th>
	            <th>attached photo 3 if not compliant</th>
	            </tr>
	        </thead>
	        <tbody>
	        {foreach name=storePlanogram from=$planogram key=plan_key item=plan}
	            <tr>
	                <td>
	                    {$plan.name}
	                </td>
	                <td>
	                    <select name="store_planogram_complaint[{$plan_key}]">
	                        {foreach name=storePlanList from=$store_planogram_complaint_value key=p_key item=p_value}
	                            {if $p_key == $plan.complaint}
	                                <option value="{$p_key}" selected="selected">{$p_value}</option>
	                            {else}
	                                <option value="{$p_key}">{$p_value}</option>
	                            {/if}
	                        {/foreach}
	                    </select>
	                </td>
	                <td>
	                <textarea name="store_planogram_comment[{$plan_key}]" row=3 column=20 >{$plan.comment}</textarea>
	                <td>
	                    {if $plan.photo_1 != ''}
	                        <input type="file" class="imageUploader"  
	                            style="display:none" value="" maxlength="255" size="30" title="" name="photo_1[{$plan_key}]" id="photo_1_{$plan_key}">
	                        
	                       <a  href="javascript:SUGAR.image.lightbox('index.php?entryPoint=download&amp;id={$plan.photo_1}&amp;type=SugarFieldImage&amp;isTempFile=1')">
                             <img id="img_photo_1_{$plan_key}" style="height: 64px;" src="index.php?entryPoint=download&amp;id={$plan.photo_1}&amp;type=SugarFieldImage&amp;isTempFile=1">
                           </a>
                           <button type="button" id="remove_photo_1_{$plan_key}" name="remove_{$plan_key}" onClick="teiq_meeting_store_planogram.remove('{$plan_key}','photo_1','{$plan.photo_1}')" >Remove</button>
                           <input type= "hidden" id= "photo_1_delete_{$plan_key}" name="photo_delete[]" value="" />
	                    {else}
	                    <input type="file" class="imageUploader" " 
	                            value="" maxlength="255" size="30" title="" name="photo_1[{$plan_key}]" id="photo_1_{$plan_key}">
	                    {/if}   
	                   
	                </td>
	               
	               <td>
	               
	                    {if $plan.photo_2 != ''}
	                        <input type="file" class="imageUploader"  
	                            style="display:none" value="" maxlength="255" size="30" title="" name="photo_2[{$plan_key}]" id="photo_2_{$plan_key}">
	                        
	                       <a  href="javascript:SUGAR.image.lightbox('index.php?entryPoint=download&amp;id={$plan.photo_2}&amp;type=SugarFieldImage&amp;isTempFile=1')">
                             <img id="img_photo_2_{$plan_key}" style="height: 64px;" src="index.php?entryPoint=download&amp;id={$plan.photo_2}&amp;type=SugarFieldImage&amp;isTempFile=1">
                           </a>
                           <button type="button" id="remove_photo_2_{$plan_key}" name="remove_{$plan_key}" onClick="teiq_meeting_store_planogram.remove('{$plan_key}','photo_2','{$plan.photo_2}')" >Remove</button>
                           <input type= "hidden" id = "photo_2_delete_{$plan_key}" name="photo_delete[]" value="" />
	                    {else}
	                    <input type="file" class="imageUploader" " 
	                            value="" maxlength="255" size="30" title="" name="photo_2[{$plan_key}]" id="photo_2_{$plan_key}">
	                    {/if}   
	                    
	                </td>
	                 <td>
	                   {if $plan.photo_3 != ''}
	                        <input type="file" class="imageUploader"  
	                            style="display:none" value="" maxlength="255" size="30" title="" name="photo_3[{$plan_key}]" id="photo_3_{$plan_key}">
	                        
	                       <a  href="javascript:SUGAR.image.lightbox('index.php?entryPoint=download&amp;id={$plan.photo_3}&amp;type=SugarFieldImage&amp;isTempFile=1')">
                             <img id="img_photo_3_{$plan_key}" style="height: 64px;" src="index.php?entryPoint=download&amp;id={$plan.photo_3}&amp;type=SugarFieldImage&amp;isTempFile=1">
                           </a>
                           <button type="button" name="remove_photo_3_{$plan_key}" id="remove_{$plan_key}" onClick="teiq_meeting_store_planogram.remove('{$plan_key}','photo_3','{$plan.photo_3}')" >Remove</button>
                           <input type= "hidden" id = "photo_3_delete_{$plan_key}" name="photo_delete[]" value="" />
	                    {else}
	                    <input type="file" class="imageUploader" " 
	                            value="" maxlength="255" size="30" title="" name="photo_3[{$plan_key}]" id="photo_3_{$plan_key}">
	                    {/if}   
	                </td>
	                   
	            </tr>
	        {/foreach}
	        </tbody>
	    </table>
</div>

<div id="store_feedback" class="db_store">
<table id="table_feedback" class = "edit view">
        <caption>Store Feedback</caption>
        <thead>
            <tr> 
            <th></th>
            <th>Comments -  competitors / retailer feedback on promotions / POS</th>
            </tr>
        </thead>
        <tbody>
        {foreach name=storeFeedback from=$feedback key=f_key item=f_value}
	            <tr>
	                <td>{$f_value.name}</td>
	                <td><textarea rows="3" cols="40" name="feedback_comment[{$f_key}]">{$f_value.comment}</textarea></td>
	            </tr>
	        {/foreach}
        </tbody>
    </table> 
</div>

<div id="store_medico" class="db_store">
    <table id="table_medico" class = "edit view">
        <caption>Medico</caption>
        <thead>
            <tr> 
            <th></th>
            <th>completed</th>
            <th>comment</th>
            </tr>
        </thead>
        <tbody>
        {foreach name=storeMedico from=$medico key=medico_key item=medico_value}
	            <tr>
	                <td>{$medico_value.name}</td>
	               
	                <td><input class="checkbox" name="medico_completed[{$medico_key}]" type="checkbox" value="{$medico_value.completed}" {$medico_value.completed_check_box}  /></td>
	                <td><textarea rows="3" cols="40" name="medico_comment[{$medico_key}]">{$medico_value.comment}</textarea></td>
	            </tr>
	        {/foreach}
        </tbody>
    </table> 
</div>



<div id="store_medical" class="db_store">
<table id="table_medical" class = "edit view">
        <caption>Medical</caption>
        <thead>
            <tr> 
            <th></th>
            <th>Drug dropdown</th>
            <th>Discussed</th>
            <th>Literature given</th>
            <th>Samples given</th>
            <th>Comments</th>
            </tr>
        </thead>
        <tbody>
        {foreach name=storeMedical from=$medical key=medical_key item=medical_value}
	            <tr>
	                <td>{$medical_value.name}</td>
	                <th>
	                    <select name="medical_drug[{$medical_key}]">
	                        {foreach name=drugList from=$drug_list key=p_key item=p_value}
	                            {if $p_key == $medical_value.drug}
	                                <option value="{$p_key}" selected="selected">{$p_value}</option>
	                            {else}
	                                <option value="{$p_key}">{$p_value}</option>
	                            {/if}
	                        {/foreach}    
	                    </select>
	                </th>
	                <td><input class="checkbox" name="medical_discussed[{$medical_key}]" type="checkbox" value="{$medical_value.discussed}" {$medical_value.discussed_check_box}  /></td>
	                <td><input class="checkbox" name="medical_literature_given[{$medical_key}]" type="checkbox" value="{$medical_value.literature_given}" {$medical_value.literature_given_check_box}  /></td>
	                <td><input class="checkbox" name="medical_samples_given[{$medical_key}]" type="checkbox" value="{$medical_value.samples_given}" {$medical_value.samples_given_check_box}  /></td>
	                <td><textarea rows="3" cols="40" name="medical_comment[{$medical_key}]">{$medical_value.comment}</textarea></td>
	            </tr>
	        {/foreach}
        </tbody>
    </table> 
</div>

<div id="store_clinician" class="db_store">
<table id="table_clinician" class = "edit view">
        <caption>Clinicians</caption>
        <thead>
            <tr> 
            <th></th>
            <th>Clinician Dropdown</th>
            <th>Discussed</th>
            <th>Literature given</th>
            <th>Samples given</th>
            <th>Merchandising</th>
            <th>Comments</th>
            </tr>
        </thead>
        <tbody>
            {foreach name=storeClinician from=$clinicians key=clinician_key item=clinician_value}
            <tr>
                <td>{$clinician_value.name}</td>
                <th>
	                    <select name="clinician_product[{$clinician_key}]">
	                        {foreach name=productList from=$products_dropdown key=p_key item=p_value}
	                            {if $p_key == $clinician_value.product}
	                                <option value="{$p_key}" selected="selected">{$p_value}</option>
	                            {else}
	                                <option value="{$p_key}">{$p_value}</option>
	                            {/if}
	                        {/foreach}    
	                    </select>
	            </th>
	            
	           <td><input class="checkbox" name="clinician_discussed[{$clinician_key}]" type="checkbox" value="{$clinician_value.discussed}" {$clinician_value.discussed_check_box}  /></td>           
               <td><input class="checkbox" name="clinician_literature_given[{$clinician_key}]" type="checkbox" value="{$clinician_value.literature_given}" {$clinician_value.literature_given_check_box}  /></td>
	           <td><input class="checkbox" name="clinician_samples_given[{$clinician_key}]" type="checkbox" value="{$clinician_value.samples_given}" {$clinician_value.samples_given_check_box}  /></td>
	           <td><input class="checkbox" name="clinician_merchandising[{$clinician_key}]" type="checkbox" value="{$clinician_value.merchandising}" {$clinician_value.merchandising_check_box}  /></td>
	           
	           <td><textarea rows="3" cols="40" name="clinician_comment[{$clinician_key}]">{$clinician_value.comment}</textarea></td>
            </tr>
            {/foreach}
            {*
            $values = $this->getClinicians();
 		$this->ss->assign('clinicians',$values);
 		$this->ss->assign('products_dropdown', $GLOBALS['app_list_strings']['douglas_clinicians']);
            *}
        </tbody>
    </table> 
</div>


</div><!-- store_tab -->

</div>
{{include file=$footerTpl}}
{{if $useTabs}}
<script type="text/javascript" src="include/javascript/sugar_grp_yui_widgets.js"></script>
<script type="text/javascript">
var {{$form_name}}_tabs = new YAHOO.widget.TabView("{{$form_name}}_tabs");
{{$form_name}}_tabs.selectTab(0);
</script> 
{{/if}}
<script type="text/javascript">
YAHOO.util.Event.onContentReady("form_QuickCreate_Accounts", 
    function () {ldelim} initEditView(document.forms.{{$form_name}}) {rdelim});
//window.setTimeout(, 100);
window.onbeforeunload = function () {ldelim} return onUnloadEditView(); {rdelim};
</script>
{literal}
    <script type="text/javascript">
    function show_dg_store(obj,id)
    {
        var eles = YAHOO.util.Dom.getElementsByClassName('db_store','div');
        for(var x in eles) {
            eles[x].style.display = 'none';
        }
        var ele = YAHOO.util.Dom.get(id);
        ele.style.display = 'block';
    }   
    </script>   
{/literal}
