# encoding: utf-8
module Delta
  class AST
    attr_accessor(:token)
    attr_accessor(:astName)
    def initialize(token)
      @token = token
    end
  end
  
  class ProgramAST < AST
      attr_accessor(:commandAST)
    def initialize(commandAST,token)
        super(token)
        @commandAST = commandAST
    end
  end
  
  class IdentifierAST < AST
    def initialize(token)
      super(token)
      #@astName = "identifierAST"
    end
  end
  
  class ConstDeclaration < AST
    attr_accessor(:identifierAST,:expressionAST)  
    def initialize(identifier,expression,token)
        super(token)
        @identifierAST = identifierAST
        @expressionAST = expression
      end  
  end
  
  class AnyTypeDenoter < TypedenoterAST 
  end
  
  class ExpressionAST < AST 
    
  end
  
  class VnameAST < AST
  end
  class CommandAST < AST 
  end
  class DeclarationAST < AST
  end
  class TypedenoterAST < AST
  end
  class ActualParameterAST < AST
  end
  class ActualParameterSequenceAST < AST
  end
  
  class ArrayAggregateAST < AST
    attr_accessor(:eleCount)   
  end
  class ArrayExpression < ExpressionAST
    attr_accessor(:AA)
    def initialize(arrayAggregateAST ,token)
      super(token)
      @AA = arrayAggregateAST
    end
  end
  
  class ArrayTypeDenoter < TypedenoterAST
    attr_accessor(:IL,:T)
    def initialize(integerLiteralAST, typeDenoterAST,token)
      super(token)
      @IL = integerLiteralAST
      @T = typeDenoterAST
    end
  end
  
  class AssignCommandAST < CommandAST
    attr_accessor(:V,:E)
    def initialize(vnameAST,expressionAST,token)
      super(token)
      @V = vnameAST
      @E = expressionAST
    end
  end
end