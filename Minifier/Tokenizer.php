<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Minifier
{
    require_once "JSCharacter.php";
    interface Tokenizer
    {
        public function getToken($character);
    }
    
    class JSTokenizer implements Tokenizer
    {
        protected $characterStack;
        protected $jsCharacter;
        public function __construct()
        {
            $this->characterStack = array();
            $this->jsCharacter = new \Minifier\JSCharacter();
        }
        public function getToken($character)
        {}
    }
}
?>
