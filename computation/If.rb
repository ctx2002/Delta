require_relative "Boolean"
class If < Struct.new(:condition,:body,:alternative)
  def to_s
    "if ( #{condition} ) then  #{body} else  #{alternative} "
  end
  
  def inspect
    "<<#{self}>>"
  end
  
  def reducible?
    true
  end
  
  def reduce(environment)
    if condition.reducible?
	  [If.new(condition.reduce(environment),body,alternative),environment]
	else
	  case condition
	    when Boolean.new(true)
		  [body,environment]
		when Boolean.new(false)
		  [alternative,environment]
	  end
	end
  end
end