<?php
$client = new SoapClient(null, array('location' => "http://sugar65.local/myServer.php",
                                     'uri'      => "http://sugar65.local"));


echo $client->test(12);
?>
