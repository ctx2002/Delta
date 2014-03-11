<?php
if(!defined('sugarEntry') || !sugarEntry) die('Not A Valid Entry Point');

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

/*********************************************************************************

 * Description: This file is used to override the default Meta-data EditView behavior
 * to provide customization specific to the Calls module.
 * Portions created by SugarCRM are Copyright (C) SugarCRM, Inc.
 * All Rights Reserved.
 * Contributor(s): ______________________________________..
 ********************************************************************************/

require_once('include/json_config.php');
require_once('modules/Meetings/views/view.edit.php');

class CustomMeetingsViewEdit extends MeetingsViewEdit
{
 	
 	public function sort_content($a,$b)
 	{
 	    return strnatcmp ( $a['name'] , $b['name'] );
 	}
 	/**
 	 * @see SugarView::display()
 	 */
 	public function display()
 	{
 		$this->ev->tpl = 'custom/modules/Meetings/EditView.tpl';
 		$this->ss->assign('enctype','enctype="multipart/form-data"');
 		$values = $this->getStorePPGReview();
 		//var_dump($values);
 		$this->ss->assign('ppgs', $values);
 		
 		$this->ss->assign('training_type', $GLOBALS['app_list_strings']['store_training_type_list']);
 		$values = $this->getStoreTraining();
 		
 		$this->ss->assign('training', $values);
 		
 		$values = $this->getStoreMedico();
 		$this->ss->assign('medico',$values);
 		
 		$values = $this->getStoreMedical();
 		$this->ss->assign('drug_list',$GLOBALS['app_list_strings']['douglas_drug_type'] );
 		$this->ss->assign('medical',$values);
 		
 		$values = $this->getStoreFeedback();
 		$this->ss->assign('feedback',$values);
 		
 		$values = $this->getStorePlanogram();
 		$this->ss->assign('planogram',$values);
 		$this->ss->assign('store_planogram_complaint_value', $GLOBALS['app_list_strings']['dom_int_bool']);
 		
 		$values = $this->getClinicians();
 		$this->ss->assign('clinicians',$values);
 		$this->ss->assign('products_dropdown', $GLOBALS['app_list_strings']['douglas_clinicians']);
 		
 		parent::display();
 	}
 	
    private function getAllBrands($table = 'dg_cust_brand')
 	{
 		$result  = $this->bean->db->query('SELECT id,name FROM '.$table. " ORDER BY name");
 		$temp = array();
 		while($row = $this->bean->db->fetchByAssoc($result)) {
 			$temp[$row['id']] = $row['name'];	
 		}
 		
 		return $temp;
 		
 	}
 	
 	private function getClinicians()
 	{
 	    $storedValues = array();
 	    $values = $this->getAllBrands('dg_clinicians');
 	    $lists = $this->bean->get_linked_beans('dg_meeting_clinicians_meetings','dg_meeting_clinicians');
 	    
 	    $checked = "checked = 'checked'";
 	    
 	    foreach ($lists as $key => $obj) {
 	        $clinician = $obj->get_linked_beans('dg_meeting_clinicians_dg_clinicians','dg_Clinicians');
 	        $c = $clinician[0];
 	        
 	        $discussed = '';
 			$literature_given = '';
 			$samples_given = '';
 			$merchandising = '';
 	    	if ($obj->discussed == 1) $discussed = $checked;
 	    	if ($obj->literature_given == 1) $literature_given = $checked;
 	    	if ($obj->samples_given == 1) $samples_given = $checked;
 	    	if ($obj->merchandising == 1) $merchandising = $checked;
 	    	
 	    	/*
 	    	 * $temp = array('name' => ucfirst( $brand->name), 'discussed_check_box' => $discussed, 'discussed' => $obj->discussed,
 	    	              'drug' => $obj->drug,
 	    	              'literature_given_check_box' => $literature_given, 'literature_given' => $obj->literature_given,
 	    	              'samples_given_check_box' => $samples_given, 'samples_given' => $obj->samples_given,
 	    	              'comment' => $obj->description);
 	    	
 	    	 * */
 	        
 	        $temp = array('name' => ucfirst($c->name),'discussed_check_box' => $discussed, 'discussed' => $obj->discussed,
 	                      'literature_given_check_box' => $literature_given, 'literature_given' => $obj->literature_given,
 	    	              'samples_given_check_box' => $samples_given, 'samples_given' => $obj->samples_given,
 	                       'comment' => $obj->description, 
 	                       'merchandising_check_box'=>$merchandising,'merchandising' => $obj->merchandising,
 	                       'product'=>$obj->product,
 	                      );
 	        $storedValues[$c->id] = $temp;
 	    }
 	    
 	    uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst($content),'discussed_check_box' => '', 'discussed' => 0,
 	                      'literature_given_check_box' => '', 'literature_given' => 0,
 	    	              'samples_given_check_box' => '', 'samples_given' => 0,
 	                       'comment' => '', 
 	                       'merchandising_check_box'=>'','merchandising' => 0,
 	                       'product'=>'',
 	                      );
 	    	    
 	    	}
 	    }
 	    
 	    
 	    return $storedValues;   
 	    
 	    
 	}
 	
    private function getStorePlanogram()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands();
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_planogram_meetings','dg_store_planogram');
 		
 		//var_dump($lists);
 		
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_planogram_dg_cust_brand','dg_cust_brand');
 		    $brand = $brands[0];
 			
            
 	    	$temp = array('name' => ucfirst( $brand->name),
 	    	              'complaint' => $obj->complaint,'comment'=>$obj->description,'brand_id'=>$brand->id,'photo_1'=>$obj->photo_1,'photo_2'=>$obj->photo_2,'photo_3'=>$obj->photo_3);
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst( $content), 'complaint' => 'not_checked',
 	    	    'comment'=>'','brand_id'=>'','photo_1'=>'','photo_2'=>'','photo_3'=>'');
 	    	    
 	    	}
 	    }
 	    return $storedValues;
 	}
 	
 	
    private function getStoreFeedback()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands();
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_feedback_meetings','dg_store_feedback');
 		
 		//var_dump($lists);
 		
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_feedback_dg_cust_brand','dg_cust_brand');
 		    $brand = $brands[0];
 			
            
 	    	$temp = array('name' => ucfirst( $brand->name), 'comment' => $obj->description);
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst( $content), 'comment' => '');
 	    	    
 	    	}
 	    }
 	    return $storedValues;
 	}
 	
    
 	
    private function getStoreMedical()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands('dg_cust_medical');
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_medical_meetings','dg_store_medical');
 		
 		//var_dump($lists);
 		//$drug_list = array_keys($GLOBALS['app_list_strings']['douglas_drug_type']);
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_medical_dg_cust_medical','dg_cust_medical');
 		    $brand = $brands[0];
 			$discussed = '';
 			$literature_given = '';
 			$samples_given = '';
 	    	if ($obj->discussed == 1) $discussed = $checked;
 	    	if ($obj->literature_given == 1) $literature_given = $checked;
 	    	if ($obj->samples_given == 1) $samples_given = $checked;
            
 	    	$temp = array('name' => ucfirst( $brand->name), 'discussed_check_box' => $discussed, 'discussed' => $obj->discussed,
 	    	              'drug' => $obj->drug,
 	    	              'literature_given_check_box' => $literature_given, 'literature_given' => $obj->literature_given,
 	    	              'samples_given_check_box' => $samples_given, 'samples_given' => $obj->samples_given,
 	    	              'comment' => $obj->description);
 	    	
 	    	//$storedValues[$name] = $temp;
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst( $content), 'discussed_check_box' => '', 'discussed' => 0,
 	    	              'drug' => '',
 	    	              'literature_given_check_box' => '', 'literature_given' => 0,
 	    	              'samples_given_check_box' => '', 'samples_given' => 0,
 	    	              'comment' => '');
 	    	    
 	    	}
 	    }
 	    return $storedValues;   
 	}
 	
 	private function getStoreMedico()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands('dg_cust_medico');
 		
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_medico_meetings','dg_store_medico');
 		
 		//var_dump($lists);
 		
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_medico_dg_cust_medico','dg_cust_medico');
 		    $brand = $brands[0];
 		    //var_dump($brand);
 			$completed = '';
 	    	if ($obj->completed == 1) $completed = $checked;
            
 	    	$temp = array('name' => ucfirst( $brand->name), 'completed_check_box' => $completed, 'completed' => $obj->completed,
 	    	              'comment' => $obj->description);
 	    	
 	    	//$storedValues[$name] = $temp;
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst( $content), 'completed_check_box' => '', 'completed' => 0,
 	    	              'comment' => '');
 	    	    
 	    	}
 	    }
 	    
 	   
 	    return $storedValues;   
 	}
 	
 	
    private function getStoreTraining()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands();
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_training_meetings','dg_store_training');
 		
 		//var_dump($lists);
 		
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_training_dg_cust_brand','dg_cust_brand');
 		    $brand = $brands[0];
 			$retail = '';
 	    	if ($obj->retail == 1) $retail = $checked;
            
 	    	$temp = array('name' => ucfirst( $brand->name), 'retail_check_box' => $retail, 'retail' => $obj->retail,
 	    	              'growth' => $obj->growth,'type'=>$obj->type,'brand_id' => $brand->id);
 	    	
 	    	//$storedValues[$name] = $temp;
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst( $content), 'retail_check_box' => '', 'retail' => 0,
 	    	              'growth' => '','type'=>'none','brand_id' => $key);
 	    	    
 	    	}
 	    }
 	    return $storedValues;
 	}
 	
 	private function getStorePPGReview()
 	{
 	    $storedValues = array(); //when first loaded, there are no ppg review stored in dg_store_ppg_review
 		$values = $this->getAllBrands();
 		$checked = "checked = 'checked'";
 		
 		$lists = $this->bean->get_linked_beans('dg_store_ppg_review_meetings','dg_store_ppg_review');
 		
 		foreach ($lists as $key => $obj) {
 		    
 		    $brands = $obj->get_linked_beans('dg_store_ppg_review_dg_cust_brand','dg_cust_brand');
 		    $brand = $brands[0];
 			$audit = '';
 	        $review = '';
 	    	if ($obj->audit == 1) $audit = $checked;
 	    	if ($obj->review == 1) $review = $checked;
            
 	    	$temp = array('name' => ucfirst( $brand->name), 'audit_check_box' => $audit, 'audit' => $obj->audit,
 	    	              'ppg_check_box' => $review, 'ppg'=>$obj->review ,'growth' => $obj->growth,'comment'=>$obj->comment,'brand_id' => $brand->id);
 	    	
 	    	//$storedValues[$name] = $temp;
 	    	$storedValues[$brand->id] = $temp;
 		}
 		
 		uasort($storedValues,array($this,'sort_content'));
 		
 	    foreach ($values as $key => $content) {
 	    	if (!array_key_exists($key,$storedValues)) {
 	    	    $storedValues[$key] = array('name' => ucfirst($content), 'audit' => 0,'audit_check_box' => '','ppg_check_box' => '',
 	    	                                 'ppg'=>0,'growth' => '','comment'=>'','brand_id' => $key);
 	    	}
 	    }
 	    return $storedValues;
 	}
}
