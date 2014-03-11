<?php 
 //WARNING: The contents of this file are auto-generated


// created: 2011-05-25 16:52:31
$dictionary["Meeting"]["fields"]["dg_meeting_clinicians_meetings"] = array (
  'name' => 'dg_meeting_clinicians_meetings',
  'type' => 'link',
  'relationship' => 'dg_meeting_clinicians_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_MEETING_CLINICIANS_MEETINGS_FROM_DG_MEETING_CLINICIANS_TITLE',
);


// created: 2011-05-10 15:00:38
$dictionary["Meeting"]["fields"]["dg_store_feedback_meetings"] = array (
  'name' => 'dg_store_feedback_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_feedback_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_FEEDBACK_MEETINGS_FROM_DG_STORE_FEEDBACK_TITLE',
);


// created: 2011-05-10 15:00:35
$dictionary["Meeting"]["fields"]["dg_store_medical_meetings"] = array (
  'name' => 'dg_store_medical_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_medical_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_MEDICAL_MEETINGS_FROM_DG_STORE_MEDICAL_TITLE',
);


// created: 2011-05-10 15:00:36
$dictionary["Meeting"]["fields"]["dg_store_medico_meetings"] = array (
  'name' => 'dg_store_medico_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_medico_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_MEDICO_MEETINGS_FROM_DG_STORE_MEDICO_TITLE',
);


// created: 2011-05-10 15:00:35
$dictionary["Meeting"]["fields"]["dg_store_planogram_meetings"] = array (
  'name' => 'dg_store_planogram_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_planogram_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_PLANOGRAM_MEETINGS_FROM_DG_STORE_PLANOGRAM_TITLE',
);


// created: 2011-05-10 15:00:34
$dictionary["Meeting"]["fields"]["dg_store_ppg_review_meetings"] = array (
  'name' => 'dg_store_ppg_review_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_ppg_review_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_PPG_REVIEW_MEETINGS_FROM_DG_STORE_PPG_REVIEW_TITLE',
);


// created: 2011-05-10 15:00:37
$dictionary["Meeting"]["fields"]["dg_store_training_meetings"] = array (
  'name' => 'dg_store_training_meetings',
  'type' => 'link',
  'relationship' => 'dg_store_training_meetings',
  'source' => 'non-db',
  'side' => 'right',
  'vname' => 'LBL_DG_STORE_TRAINING_MEETINGS_FROM_DG_STORE_TRAINING_TITLE',
);


 // created: 2012-02-14 13:30:13
$dictionary['Meeting']['fields']['order_method_c']['dependency']='';

 

 // created: 2011-11-21 12:19:18
$dictionary['Meeting']['fields']['status']['default']='Planned';
$dictionary['Meeting']['fields']['status']['audited']=true;
$dictionary['Meeting']['fields']['status']['calculated']=false;
$dictionary['Meeting']['fields']['status']['dependency']=false;

 

/*$dictionary['Meeting']['fields']['douglas_talked_drug_1'] = array(
    'name' => 'douglas_talked_drug_1',
    'vname' => 'LBL_DOUGLAS_TALKED_DRUG',
    'type'  => 'bool',
);

$dictionary['Meeting']['fields']['douglas_talked_drug_2'] = array(
    'name' => 'douglas_talked_drug_2',
    'vname' => 'LBL_DOUGLAS_TALKED_DRUG',
    'type'  => 'bool',
);
$dictionary['Meeting']['fields']['douglas_talked_drug_3'] = array(
    'name' => 'douglas_talked_drug_3',
    'vname' => 'LBL_DOUGLAS_TALKED_DRUG',
    'type'  => 'bool',
);
$dictionary['Meeting']['fields']['douglas_talked_drug_4'] = array(
    'name' => 'douglas_talked_drug_4',
    'vname' => 'LBL_DOUGLAS_TALKED_DRUG',
    'type'  => 'bool',
);
$dictionary['Meeting']['fields']['douglas_talked_drug_5'] = array(
    'name' => 'douglas_talked_drug_5',
    'vname' => 'LBL_DOUGLAS_TALKED_DRUG',
    'type'  => 'bool',
);
*/
/*
$dictionary['Meeting']['fields']['dg_store_ppg_review'] = array(
    'name' => 'dg_store_ppg_review',
    'vname' => 'LBL_DOUGLAS_STORE_PPG_REVIEW',
    'type'  => 'link',
    'relationship' => 'meeting_ppgs',
    'bean_name' => 'dg_store_ppg_review',
    'module' => 'dg_store_ppg_review',
    'source'=>'non-db',
);


$dictionary['Meeting']['relationships']['meeting_ppgs'] = array('lhs_module'=> 'Meetings', 'lhs_table'=> 'meetings', 'lhs_key' => 'id',
                              'rhs_module'=> 'dg_store_ppg_review', 'rhs_table'=> 'dg_store_ppg_review', 'rhs_key' => 'store_ppg_review_meeting_id',
                              'relationship_type'=>'one-to-many');
*/
?>