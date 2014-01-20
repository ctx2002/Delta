<?php

function test($x)
{
    return $x+12;
}

$server = new SoapServer(null, array('uri' => "http://sugar65.local"));
$server->addFunction("test");
$server->handle();
?>
