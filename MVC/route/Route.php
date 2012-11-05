<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
namespace MVC\Route {
    require_once dirname(__FILE__) . "/../controller/Controller.php";
    class Route {
        protected $URIMeta;
        public function __construct()
        {
            $this->URIMeta = new RequestURIMetaData($_REQUEST['REQUEST_URI']);    
        }
        
        public function dispatch()
        {
            //find out where is controller   
            $con = new MVC\Controller\Controller();
        }
    }
    
    class RequestURIMetaData
    {
        protected $requestURI;
        protected $requestParam;
        public function __construct($requestURI="")
        {
            $this->URIStr($requestURI);
        }
        
        protected function setURI($result)
        {
            $this->requestURI = isset($result['path'])? $result['path'] : "";
            
        }
        
        protected function setParam($result)
        {
            $this->requestParam  = isset($result['query'])? $result['query'] : "";    
        }
        
        public function removeSlashInFront($uri)
        {
            return ltrim($uri,'/');    
        }
        
        public function URIStr($requestURI)
        {
            
            $result = parse_url($this->removeSlashInFront($requestURI) );
            $this->setURI($result);
            $this->setParam($result);    
        }
        
        public function explodeURI($uri,$index)
        {
            $result = explode ( "/" , $uri );
            if (!empty($result) ) {
                if (isset($result[$index]))
                    return $result[$index];
            }
            
            return null;
        }
        
        public function fetchController()
        {
            //controller name is first part of request uri
            //for example:
            //    http://mvc.localhost/hello/world?write=yes&out=false
            //    request uri is hello/world?write=yes&out=false,
            //    so hello is controller.
            
            return $this->explodeURI($this->requestURI,0);
        }
        
        public function fetchAction()
        {
            //action name is second part of request uri
            //for example:
            //    http://mvc.localhost/hello/world?write=yes&out=false
            //    request uri is hello/world?write=yes&out=false,
            //    so world is action.
            return $this->explodeURI($this->requestURI,1);    
        }
        
        public function getParam($name)
        {
            parse_str($this->requestParam,$out);
            //var_dump($out[$name]);
            if (isset($out[$name])) { 
                return $out[$name];
            }
            
            return null;
        }
    }
    
}
?>
