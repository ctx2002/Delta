<?php
/*
Unicode Whitespace
Code point 	Name 	Script 	General category 	Remark
U+0009 		Common 	Other, control 	HT, Horizontal Tab
U+000A 		Common 	Other, control 	LF, Line feed
U+000B 		Common 	Other, control 	VT, Vertical Tab
U+000C 		Common 	Other, control 	FF, Form feed
U+000D 		Common 	Other, control 	CR, Carriage return
U+0020 	space 	Common 	Separator, space 	
U+0085 		Common 	Other, control 	NEL, Next line
U+00A0 	no-break space 	Common 	Separator, space 	
U+1680 	ogham space mark 	Ogham 	Separator, space 	
U+180E 	mongolian vowel separator 	Mongolian 	Separator, space 	
U+2000 	en quad 	Common 	Separator, space 	
U+2001 	em quad 	Common 	Separator, space 	
U+2002 	en space 	Common 	Separator, space 	
U+2003 	em space 	Common 	Separator, space 	
U+2004 	three-per-em space 	Common 	Separator, space 	
U+2005 	four-per-em space 	Common 	Separator, space 	
U+2006 	six-per-em space 	Common 	Separator, space 	
U+2007 	figure space 	Common 	Separator, space 	
U+2008 	punctuation space 	Common 	Separator, space 	
U+2009 	thin space 	Common 	Separator, space 	
U+200A 	hair space 	Common 	Separator, space 	
U+2028 	line separator 	Common 	Separator, line 	
U+2029 	paragraph separator 	Common 	Separator, paragraph 	
U+202F 	narrow no-break space 	Common 	Separator, space 	
U+205F 	medium mathematical space 	Common 	Separator, space 	
U+3000 	ideographic space 	Common 	Separator, space 	
*/
namespace Unicode {
    class Unicode {
        const BOM = 0xfeff; //utf8 leading

        public function isWhitespace($hexNumber)
        {
            $WHITESPACE = array(0x0009,0x000a,0x000b,0x000c,0x000d,
                           0x0020,0x0085,0x00a0,0x1680,0x180e,0x2000,
                           0x2001,0x2002,0x2003,0x2004,0x2005,0x2006,
                           0x2007,0x2008,0x2009,0x220a,0x2028,
                           0x2029,0x202f,0x205f,0x3000);
            return in_array($hexNumber, $WHITESPACE);
        }
        
        public function isLineTerminator($codeUnit)
        {
            $line = array(0x000a,0x000d,0x2028,0x2029);
            return in_array($codeUnit, $line);
        }
    }
}

?>
