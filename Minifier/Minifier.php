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
 */
class JSLexer
{
    protected $js;
    public function __construct($js) {
        $this->js = $js;
    }
}

?>
