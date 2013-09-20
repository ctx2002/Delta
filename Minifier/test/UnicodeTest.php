<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */

/**
 * Description of UnicodeTest
 *
 * @author anru
 */

namespace UnicodeTest {
    require_once dirname(__FILE__)."/../vendor/autoload.php";
    require_once dirname(__FILE__)."/../Unicode.php";
    class UnicodeTest extends \PHPUnit_Framework_TestCase{
        public function testisWhitespace()
        {
            $uni = new \Unicode\Unicode();
            $w = 0x0009;
            $r = $uni->isWhitespace($w);
            $this->assertTrue($r);
            
            $nw = 0x0045;
            $r = $uni->isWhitespace($nw);
            $this->assertFalse($r);
            
            $w = 0xa;
            $r = $uni->isWhitespace($w);
            $this->assertTrue($r);
            
            $w = 0x3000;
            $r = $uni->isWhitespace($w);
            $this->assertTrue($r);
        }
    }
}

?>
