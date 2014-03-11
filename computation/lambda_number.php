<?php
$id = function($x) {
    return $x;
};

$zero = function($proc,$x) {
    return $x;
};

$one = function($proc,$x) {
    return $proc($x);
};

$two = function($proc,$x) {
    $one = $proc($x);
    return $proc( $one );
};

$three = function($proc,$x) {
    return $proc( $proc( $proc($x) ));
};

$convert = function($id) {
    return function($n) use ($id) {
	    return $id->__invoke(1) + $n;
	};
};

$converter = function($n) {
    return $n + 1;
};

function to_integer($number) {
    global $converter;
    return $number($converter,0);
}

echo to_integer($zero);
echo "\n" . to_integer($one);
echo "\n" . to_integer($two);
echo "\n" . to_integer($three);