<?php
/*
x+y+z
return function ($y) use($x) {
			return function ($z) use($x,$y) { return $x+$y+$z;  }
		  }
*/

$test = 
function ($x) {
    return function($y) use($x) {
	  return function ($z) use($x,$y) { return $x+$y+$z;  };  
	};   	  
};
echo $test(1)->__invoke(2)->__invoke(3) ;
echo "\n";

$la = function($func,$x) { return $func($func($x) ); };
echo $la( function($y){ return $y+1;},0);
echo "\n";
/*
$p = function( $func ) { return function($x) use ($func) { return $func($x);}; };
echo $p( function($n) { return $n+1;} )->__invoke(0);
echo "\n";
*/

$zero = function ($func) {  return function($x){ return $x; };};
$one = function ($func) {  return function($x) use($func) { return $func($x); };};

$two = function($func) { return function($x) use ($func) { return $func( $func($x)); }; };
$three = function($func) { return function($x) use ($func) { return $func( $func( $func($x))); }; };
function to_integer($func)
{
  return $func( function($n){return $n+1;})->__invoke(0);
}

echo to_integer($zero);
echo "\n";
echo to_integer($one);
echo "\n";
echo to_integer($two);
echo "\n";
echo to_integer($three);
echo "\n";


$zero = function($hit) { return function($ball){ return $ball; }; };
$one = function($hit)  {  return function($ball) use ($hit) { return $hit($ball); }; };
$two = function($hit) { return function($ball) use ($hit) { return $hit($hit($ball)); }; };

echo to_integer($zero);
echo "\n";
echo to_integer($one);
echo "\n";
echo to_integer($two);
