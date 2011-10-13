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
  
  class AnyTypeDenoterAST < TypeDenoterAST 
  end
  
  class ArrayTypeDenoter < TypeDenoter  
    attr_accessor(:IL,:T)
    def initialize (integerLiteralAST, typeDenoterAST ) 
      @IL = integerLiteralAST;
      @T = typeDenoterAST;
    end   
   end
  
   class BinaryExpressionAST < Expression
     attr_accessor(:O,:E1,:E2)
     def initialize(expressionAST, operatorAST, e2xpressionAST)
       @O = operatorAST;
       @E1 = expressionAST;
       @E2 = e2xpressionAST;   
     end
     
   end
   
   class BinaryOperatorDeclarationAST < DeclarationAST
     attr_accessor(:O,:ARG1,:ARG2,:RES)
     def initialize(operatorAST, arg1AST,arg2AST,resultAST)
        @O = oAST;
        @ARG1 = arg1AST;
        @ARG2 = arg2AST;
        @RES = resultAST;
     end
   end
   class BoolTypeDenoterAST < TypeDenoter
   end
   class CallCommandAST < CommandAST
     def initialize(identifierAST, actualParameterSequenceAST)
       @I = identifierAST
       @APS = actualParameterSequenceAST
     end
   end
   class CallExpressionAST < Expression
       attr_accessor(:I,:APS)
       def initialize(identifierAST , actualParameterSequenceAST )
           @I = identifierAST
           @APS = actualParameterSequenceAST  
       end
   end
   
   class CharacterExpression < Expression
     attr_accessor(:CL)
     def CharacterExpression (characterLiteralAST)
         @CL = characterLiteralAST
     end
   end
   
   class TerminalAST < AST
     attr_accessor(:spelling)
     def initialize(spelling)
       @spelling = spelling
     end
   end
   class CharacterLiteralAST < TerminalAST
     def initialize(spelling)
       @spelling = spelling
     end
   end
   class CharTypeDenoterAST < TypeDenoterAST
     
   end
   
   class ConstActualParameterAST < ActualParameterAST
     attr_accessor(:E)
     def initialize(expressionAST)
       @E = expressionAST
     end
   end
   class ConstDeclarationAST < DeclarationAST
     attr_accessor(:I,:E)
     def initialize(identifierAST, expressionAST)
       @I = identifierAST
       @E = expressionAST
     end
   end
   
   class FormalParameterAST < DeclarationAST
     
   end
   
   class ConstFormalParameterAST < FormalParameterAST
     attr_accessor(:I,:T)
     def initialize(identifierAST, typeDenoterAST)
       @I = identifierAST
       @T = typeDenoterAST
     end
   end
   
   class DotVnameAST < VnameAST
     attr_accessor(:V,:I)
     def initialize(vnameAST, identifierAST)
       @V = vnameAST
       @I = identifierAST
     end
   end
   
   class EmptyActualParameterSequenceAST < ActualParameterSequenceAST
       
   end
   class EmptyCommandAST < CommandAST
   end
   class EmptyExpression < ExpressionAST
   end
   class FormalParameterSequenceAST < AST
   end
   class EmptyFormalParameterSequenceAST < FormalParameterSequenceAST
   end
   
   class ErrorTypeDenoterAST < TypeDenoterAST
   end
   
   class FieldTypeDenoterAST < TypeDenoterAST
   end
   
   class FuncActualParameterAST < ActualParameterAST
     attr_accessor(:I)
     def initialize(identifierAST)
       @I = identifierAST
     end
   end
   
   class FuncDeclarationAST < DeclarationAST
     attr_accessor(:I,:FPS,:T,:E)
     def initialize(identifierAST, formalParameterSequenceAST,
                    typeDenoterAST, expressionAST)
         @I = identifierAST
         @FPS = formalParameterSequenceAST
         @T = typeDenoterAST
         @E = expressionAST
     end
   end
   
   class FuncFormalParameterAST < FormalParameterAST
     attr_accessor(:I,:FPS,:T)
     def initialize(identifierAST, formalParameterSequenceAST,
       typeDenoterAST)
       @I = identifierAST
       @FPS = formalParameterSequenceAST
       @token = typeDenoterAST
     end
   end
end