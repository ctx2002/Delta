<?php
class CustomMeetingsController extends SugarController
{
    private $old = 10;
	public function post_save()
    {
    	parent::post_save();
        
    }
    
    public function post_delete()
    {
        parent::post_delete();
    }
   
    
}