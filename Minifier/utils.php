<?php
//copied from stackoverflow
class utils {
    //
    static public function char2UnicodePoint($c)
    {
        if (ord($c{0}) >=0 && ord($c{0}) <= 127)
        return ord($c{0});
        if (ord($c{0}) >= 192 && ord($c{0}) <= 223)
            return (ord($c{0})-192)*64 + (ord($c{1})-128);
        if (ord($c{0}) >= 224 && ord($c{0}) <= 239)
            return (ord($c{0})-224)*4096 + (ord($c{1})-128)*64 + (ord($c{2})-128);
        if (ord($c{0}) >= 240 && ord($c{0}) <= 247)
            return (ord($c{0})-240)*262144 + (ord($c{1})-128)*4096 + (ord($c{2})-128)*64 + (ord($c{3})-128);
        if (ord($c{0}) >= 248 && ord($c{0}) <= 251)
            return (ord($c{0})-248)*16777216 + (ord($c{1})-128)*262144 + (ord($c{2})-128)*4096 + (ord($c{3})-128)*64 + (ord($c{4})-128);
        if (ord($c{0}) >= 252 && ord($c{0}) <= 253)
            return (ord($c{0})-252)*1073741824 + (ord($c{1})-128)*16777216 + (ord($c{2})-128)*262144 + (ord($c{3})-128)*4096 + (ord($c{4})-128)*64 + (ord($c{5})-128);
        if (ord($c{0}) >= 254 && ord($c{0}) <= 255)    //  error
            return FALSE;
        return 0;    
    }
    
    static public function cache_char2UnicodePoint($c)
    {
        static $cache = array();
        if (isset($cache[$c])) return $cache[$c];
        $code = \utils::char2UnicodePoint($c);
        $cache[$c] = $code;
        return $code;
    }
    // $num is unicode code point.
    static public function utf8($num)
    {
        if($num<=0x7F)       return chr($num);
        if($num<=0x7FF)      return chr(($num>>6)+192).chr(($num&63)+128);
        if($num<=0xFFFF)     return chr(($num>>12)+224).chr((($num>>6)&63)+128).chr(($num&63)+128);
        if($num<=0x1FFFFF)   return chr(($num>>18)+240).chr((($num>>12)&63)+128).chr((($num>>6)&63)+128).chr(($num&63)+128);
        return '';
    }
}

?>
