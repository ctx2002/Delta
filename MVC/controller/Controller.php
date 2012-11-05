<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

namespace MVC\Controller {
    require_once dirname(__FILE__)."/../config/MVC_Config.php";
    class Controller {
        public function __construct()
        {
            
        }
        
        public function getControllerDir()
        {
            global $MVC_Config;
            if (isset($MVC_Config['controller'])) {
                if (isset($MVC_Config['controller']['path']))
                    return $MVC_Config['controller']['path'];    
            }
            return '';
        }
    }
}
?>
