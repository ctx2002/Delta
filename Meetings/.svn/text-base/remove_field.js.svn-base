var teiq_meeting_store_planogram = {
		
		remove : function(id,field,file_id) {
		    if ( document.getElementById ) {
		    	var input_ele = document.getElementById(field+'_delete_' + id);
		    	input_ele.value = file_id;
		    	
		    	//remove a tag
		    	var a_ele = document.getElementById("img_" + field + "_" + id);
		    	a_ele.style.display = 'none';
		    	
		    	var upload_button = document.getElementById(field+"_" + id);
		    	upload_button.style.display = 'block';
		    	
		    	var remove_button = document.getElementById("remove_" + field + "_" + id);
		    	remove_button.style.display = "none";
		    	
		    	//window.event.cancelBubble = true
		    	if (window.event) {
		    	    if (window.event.cancelBubble) window.event.cancelBubble = true;
		    	    if (window.event.stopPropagation) window.event.stopPropagation = true;
		        }
		    	
		    }   	
		}
}