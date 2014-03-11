require_relative 'Add'
require_relative 'Number'
require_relative 'Multiply'
require_relative 'LessThan'
require_relative 'Boolean'
require_relative 'Variable'
require_relative 'Assign'
require_relative 'ExpressionMachine'
require_relative 'StatementMachine'
require_relative 'If'
class Machine
  def self.new(syntax, *args)
    machine_class =
      case syntax
      when Add, Boolean, LessThan, Multiply, Number, Variable
        ExpressionMachine
      when Assign, DoNothing, If, Sequence, While
        StatementMachine
      else
        raise "Unrecognized syntax: #{syntax.inspect}"
      end

    $stderr.puts "WARNING: Automatically using #{machine_class} instead of #{self}. See the the_meaning_of_programs/README.md for details."

    machine_class.new(syntax, *args)
  end
end


an = Assign.new(:x, Add.new(Variable.new(:x), Number.new(1)))
m = Machine.new(an,{x: Number.new(3)})
m.run

less = LessThan.new(Variable.new(:x),Number.new(5))
ad = Add.new(Variable.new(:x),Number.new(2))
al = Multiply.new(Variable.new(:x),Number.new(3))
an = If.new(less,ad,al)
m = Machine.new(an,{x: Number.new(3)})
m.run