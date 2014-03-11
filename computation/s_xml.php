<?php
$xml = simplexml_load_file("products.xml");
$att = "/PRODUCTS/PRODUCT[@category='software']";

$products = $xml->xpath("/PRODUCTS");
var_dump($products);
foreach ($products as $key => $value) {
    foreach ($value as $product) {
	    //var_dump((string)$product['category']);
		//var_dump((string)$product->SKU);
	}
}

/*$names= $xml->xpath("/PRODUCTS/PRODUCT/NAME");
//var_dump($names);
foreach ($names as $va) {
    var_dump($va);
}*/