class Rule
  attr_accessor :current_state,:character,:next_state
    
  def initialize(current_state,character,next_state)
    @current_state = current_state
    @character = character
    @next_state = next_state	
  end
  def to_next_state
    self.next_state
  end
  def accept?(current_state,character)
    self.current_state == current_state && self.character == character
  end
  def to_s
    "#{current_state} - #{character}"
  end  
end

class RuleBook
  attr_accessor :rules
  def initialize(rules)
    #@current_state = current_state
    #@character = character
    @rules = rules	
  end
  def to_next_state(current_state,character)
    nextRule = applies_to(current_state,character)
	if nextRule == nil
	  'no rule'
	else 
	  nextRule.to_next_state
	end
  end
  
  def applies_to(state,char)
    rules.detect { |rule| rule.accept?(state,char)}
  end
end

class DFA 
  attr_accessor :ruleBook, :current_state,:accept_states
  def initialize(current_state,accept_states,ruleBook)
    @current_state = current_state
    @accept_states = accept_states
    @ruleBook = ruleBook	
  end
  def accepting?
    self.accept_states.include?(current_state)
  end
  def read_a_character(char)
    self.current_state = self.ruleBook.to_next_state(current_state,char)
  end  
end

book = RuleBook.new([Rule.new(1,'a',2), Rule.new(2,'b',3), Rule.new(3,'c',4)])
dfa = DFA.new(1,[4],book)
puts dfa.read_a_character('a')
puts dfa.read_a_character('b')
puts dfa.accepting?
puts dfa.read_a_character('c')
puts dfa.accepting?
