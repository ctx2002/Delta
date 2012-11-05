<?php

namespace MVC\Route;

require_once dirname(__FILE__) . '/../../route/Route.php';

/**
 * Test class for RequestURIMetaData.
 * Generated by PHPUnit on 2012-10-10 at 12:06:56.
 */
class RequestURIMetaDataTest extends \PHPUnit_Framework_TestCase {

    /**
     * @var RequestURIMetaData
     */
    protected $object;

    /**
     * Sets up the fixture, for example, opens a network connection.
     * This method is called before a test is executed.
     */
    protected function setUp() {
        $this->object = new RequestURIMetaData;
    }

    /**
     * Tears down the fixture, for example, closes a network connection.
     * This method is called after a test is executed.
     */
    protected function tearDown() {
        
    }

    /**
     * @covers MVC\Route\RequestURIMetaData::explodeURI
     * 
     */
    public function testExplodeURI() {
        // Remove the following lines when you implement this test.
        //$this->object->URIStr("hello/anru?write=yes&out=false");
        $uri = parse_url("hello/anru?write=yes&out=false");
        $con = $this->object->explodeURI($uri['path'],0);
        $this->assertEquals('hello', $con);
        
        $con = $this->object->explodeURI($uri['path'],1);
        $this->assertEquals('anru', $con);
        
        $uri = parse_url("");
        $con = $this->object->explodeURI($uri['path'],0);
        $this->assertEquals(null, $con);
        
        $uri = parse_url("/////");
        $con = $this->object->explodeURI($uri['path'],0);
        $this->assertEquals(null, $con);
        
        $uri = parse_url("/anru////");
        //var_dump($uri);
        $con = $this->object->explodeURI($uri['path'],0);
        $this->assertEquals(null, $con);
        
        $uri = parse_url("/anru////");
        $con = $this->object->explodeURI($uri['path'],1);
        $this->assertEquals('anru', $con);
        
        $uri = parse_url("/anru////");
        $con = $this->object->explodeURI($uri['path'],2);
        $this->assertEquals(null, $con);
    }

    /**
     * @covers MVC\Route\RequestURIMetaData::fetchController
     * @todo Implement testFetchController().
     */
    public function testFetchController() {
        $this->object->URIStr("hello/anru?write=yes&out=false");
        $con = $this->object->fetchController();
        $this->assertEquals('hello', $con);
        
        $this->object->URIStr("/world/anru?write=yes&out=false");
        $con = $this->object->fetchController();
        $this->assertEquals('world', $con);
        
        $this->object->URIStr("//////world/anru?write=yes&out=false");
        $con = $this->object->fetchController();
        $this->assertEquals('world', $con);
    }

    /**
     * @covers MVC\Route\RequestURIMetaData::fetchAction
     * @todo Implement testFetchAction().
     */
    public function testFetchAction() {
        $this->object->URIStr("hello/anru?write=yes&out=false");
        $con = $this->object->fetchAction();
        $this->assertEquals('anru', $con);
        
        $this->object->URIStr("hello//anru?write=yes&out=false");
        $con = $this->object->fetchAction();
        $this->assertEquals(null, $con);
    }

    /**
     * @covers MVC\Route\RequestURIMetaData::getParam
     * @todo Implement testGetParam().
     */
    public function testGetParam() {
        $this->object->URIStr("hello/anru?write=yes&out=false");
        $r = $this->object->getParam('write');
        $this->assertEquals('yes', $r);
        
        $this->object->URIStr("hello/anru?write=yes&out=false");
        $r = $this->object->getParam('out');
        $this->assertEquals('false', $r);
        
        $this->object->URIStr("hello/anru?write=yes&out=");
        $r = $this->object->getParam('out');
        $this->assertEquals('', $r);
        
        $this->object->URIStr("hello/anru?write=yes&out");
        $r = $this->object->getParam('out');
        $this->assertEquals('', $r);
    }

}

?>
