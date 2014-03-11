require 'set'
class FARule < Struct.new(:state,:char,:next_state)
  def applies_to?(state,char)
    self.state == state && self.char == char
  end
  def follow
    next_state
  end
  def inspect
    "#{state} #{char} #{next_state}"
  end 
end

class NORule < Struct.new(:state,:char)
  def follow
    puts 'no rule'
	"#{state} #{char}"
  end
  def call
    self
  end
  
  def inspect
    "#{state} #{char}"
  end
end

class DFARuleBooks < Struct.new(:rules)
  def next_state(state,char)
    rule_for(state,char).follow
  end
  def rule_for(state,char)
    rules.detect( NORule.new(state,char) ) { |rule| rule.applies_to?(state,char) }
  end  
end

class DFA < Struct.new(:current_state,:accept_states,:rulebook)
  def accepting?
    accept_states.include?(current_state)
  end
  def read_character(char)
    self.current_state = rulebook.next_state(current_state,char)
  end
  
  def read_string(string)
    string.chars.each { |char| read_character(char) }
  end
end

class NFA < Struct.new(:current_states,:accept_states,:rulebook)
  def accepting?
    (current_states & accept_states).any?
  end
   def read_character(char)
    self.current_states = rulebook.next_states(current_states,char)
  end
  
  def read_string(string)
    string.chars.each { |char| read_character(char) }
  end
  
  def current_states
    rulebook.follow_free_moves(super)
  end
end

class NFARuleBook < Struct.new(:rules)
	def next_states(states, character)
	  states.flat_map { |state|  follow_rules_for(state, character) }.to_set
	end
	def follow_rules_for(state, character)
	   rules_for(state, character).map { |rule|  rule.follow}
	end
	def rules_for(state, character)
	  rules.select { |rule| rule.applies_to?(state, character) }
	end
	
	def follow_free_moves(states)
	  #more_states = next_states(states, nil)
	  #if more_states.subset?(states)
	  #  states
	  #else
	  #  follow_free_moves(states + more_states)
		
	  while true
	    more_states = next_states(states, nil)
        if more_states.subset?(states)
          return states
		end
        states = states + more_states		
	  end
	end
end


class DFADesign < Struct.new(:start,:accept_states,:rulebook)
  def to_dfa
    DFA.new(start,accept_states,rulebook)
  end
  
  def accepts?(string)
    to_dfa.tap{ |dfa| dfa.read_string(string) }.accepting?
  end
end

class NFADesign < Struct.new(:start_state, :accept_states, :rulebook)
	def accepts?(string)
	  to_nfa.tap { |nfa| nfa.read_string(string) }.accepting?
	end
	def to_nfa(current_state = Set[start_state])
      NFA.new(current_state, accept_states, rulebook)
	end
end

module Pattern
	def bracket(outer_precedence)
		if precedence < outer_precedence
			'(' + to_s + ')'
		else
			to_s
		end
	end
	def inspect
	  "/#{self}/"
	end
end

class Empty
  include Pattern
  def to_s
    ''
  end
  def precedence
    3
  end
  
  def to_nfa_design
    start_state = Object.new
	accept_states = [start_state]
	rulebook = NFARuleBook.new([])
	NFADesign.new(start_state, accept_states, rulebook)
  end
end

class Literal < Struct.new(:char)
  include Pattern
  def precedence
    3
  end
  
  def to_s
    char.to_s
  end
  
  def to_nfa_design
    start = Object.new
	accept = Object.new
	rule = FARule.new(start,char,accept)
	rulebook = NFARuleBook.new([rule])
    NFADesign.new(start, [accept], rulebook)	
  end
end


em = Empty.new.to_nfa_design
puts em.accepts?('')