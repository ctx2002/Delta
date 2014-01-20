<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
interface Minifier
{
    public function mini($str);
}
/**
 * Description of Minifier
 *
 * @author anru
 */
class MinifierJS implements Minifier{
    public function mini($str);
}
/*
 *  InputElementDiv ::

WhiteSpace
LineTerminator
Comment
Token
DivPunctuator

InputElementRegExp ::

WhiteSpace
LineTerminator
Comment
Token
RegularExpressionLiteral
 * 
 * in examples such as the following:
 * a = b
   /hi/g.exec(c).map(d);
   where the first non-whitespace, non-comment character after a LineTerminator 
 * is slash (/) and the syntactic context allows division or division-assignment, 
 * no semicolon is inserted at the LineTerminator. 
 * That is, the above example is interpreted in the same way as:

   a = b / hi / g.exec(c).map(d);

 */
class JSLexer
{
    protected $js;
    public function __construct($js) {
        $this->js = $js;
    }
}

class Token
{
    protected $lexeme;
    protected $type;
}

class JSWhiteSpace extends Token
{
    public function __construct($value)
    {
        $this->type = "TOK_WHITESPACE";
        $this->value = $value;
    }
}

class JSLineTerminator extends Token
{
    public function __construct($value)
    {
        $this->type = "TOK_LINETERMINATOR";
        $this->value = $value;
    }
}

?>
