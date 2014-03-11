<?php

class FARule
{
    protected $current_state;
	protected $char;
	protected $next_state;
	public function __construct($current_state,$char,$next_state)
	{
	    $this->current_state = $current_state;
		$this->char  = $char;
		$this->next_state = $next_state;
	}
	
	public function getCurrentState()
	{
	    return $this->current_state;
	}
	
	public function nextState()
	{
	    return $this->next_state;
	}
	
	public function appliesTo($state,$char)
	{
	    if ($this->current_state == $state && $this->char == $char) return true;
		return false;
	}
	
	public function __toString()
	{
	    echo $this->current_state . ' to '. $this->next_state . " over ".$this->char;
	}
}

class NoRule
{
    public function nextState()
	{
	    throw new Exception("no next state");
	}   
}

class FARuleBook
{
    protected $rules;
	//protected $current_state;
	//protected $char;
	public function __construct($rules)
	{
	    $this->rules = $rules;
		//$this->current_state = $current_state;
		//$this->accept_states = $accept_states;
	}
	
	public function next_state($current_state,$char)
	{
	    $rule = $this->rule_for($current_state,$char);
		$rule->nextState();
	}
	
	public function rule_for($current_state,$char)
	{
	    foreach ($this->rules as $rule) {
		    if ($rule->appliesTo($current_state,$char)) {
			    return $rule;
			}
		}
		return new NoRule();    	
	}
	
	//publ
}

class DFA
{
    protected $book;
	protected $current_state;
	protected $accept_state;
	public function __construct($book,$start_state,$accept_state)
	{
	    $this->book = $book;
		$this->current_state = $start_state;
		$this->accept_state = $accept_state;
	}
	
	public function read_char($char)
	{
	    $this->current_state = $this->book->next_state($this->current_state,$char);    
	}
	
	public function read_str($str)
	{
	    $len = strlen($str);
		for($i=0; $i<$len; $i++) {
		    $this->read_char($str[$i]);
		}
	}
	
	public function isAccepting()
	{
	    return in_array($this->current_state,$this->accept_state);    
	}
}
$r = array( new FARule(1,'0',1),
            new FARule(1,'1',2),
            new FARule(2,'0',1),
 			new FARule(2,'1',2));
			
$book = new FARuleBook($r);
$dfa = new DFA($book,1,array(2));