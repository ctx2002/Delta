<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
namespace Minifier
{
    require_once("utils.php");
    require_once("Unicode.php");
    class JSCharacter
    {
        protected $char = null;
        protected $unicode = null;
        public function __construct($char)
        {
            $this->char = $char;
            $this->unicode = new \Unicode();
        }
        
        public function isWhitespace()
        {
            $ucode = \utils::cache_char2UnicodePoint($this->char);
            if ($ucode) return $this->unicode->isWhitespace($ucode);
            //may be 0xfeff
            if (isset($this->char{0}) && isset($this->char{1})) {
                if ($this->char{0} == 0xfe && $this->char{1} == 0xff) return true;
            }
            return false;
        }
        
        public function isLineTerminator()
        {
            $ucode = \utils::cache_char2UnicodePoint($this->char);
            return $this->unicode->isLineTerminator($this->char);
        }
    }
}
?>
