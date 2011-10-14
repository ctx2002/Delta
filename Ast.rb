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
    attr_accessor(:I,:E)  
    def initialize(identifierAST,expressionAST,token)
        super(token)
        @I = identifierAST
        @E = expression
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
    def initialize()
      @eleCount = 0
    end   
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
  
  class ArrayTypeDenoterAST < TypeDenoterAST  
    attr_accessor(:IL,:T)
    def initialize (integerLiteralAST, typeDenoterAST,token ) 
      super(token)
      @IL = integerLiteralAST;
      @T = typeDenoterAST;
    end   
   end
  
   class BinaryExpressionAST < ExpressionAST
     attr_accessor(:O,:E1,:E2)
     def initialize(expressionAST, operatorAST, e2xpressionAST,token)
       super(token)
       @O = operatorAST;
       @E1 = expressionAST;
       @E2 = e2xpressionAST;   
     end
     
   end
   
   class BinaryOperatorDeclarationAST < DeclarationAST
     attr_accessor(:O,:ARG1,:ARG2,:RES)
     def initialize(operatorAST, arg1AST,arg2AST,resultAST,token)
        super(token)
        @O = oAST;
        @ARG1 = arg1AST;
        @ARG2 = arg2AST;
        @RES = resultAST;
     end
   end
   class BoolTypeDenoterAST < TypeDenoterAST
   end
   class CallCommandAST < CommandAST
     def initialize(identifierAST, actualParameterSequenceAST,token)
       super(token)
       @I = identifierAST
       @APS = actualParameterSequenceAST
     end
   end
   class CallExpressionAST < ExpressionAST
       attr_accessor(:I,:APS)
       def initialize(identifierAST , actualParameterSequenceAST ,token)
           super(token)
           @I = identifierAST
           @APS = actualParameterSequenceAST  
       end
   end
   
   class CharacterExpressionAST < ExpressionAST
     attr_accessor(:CL)
     def CharacterExpression (characterLiteralAST,token)
         super(token)
         @CL = characterLiteralAST
     end
   end
   
   class TerminalAST < AST
     attr_accessor(:spelling)
     def initialize(spelling,token)
       super(token)
       @spelling = spelling
     end
   end
   class CharacterLiteralAST < TerminalAST
     def initialize(spelling,token)
       super(spelling,token)
     end
   end
   class CharTypeDenoterAST < TypeDenoterAST
     
   end
   
   class ConstActualParameterAST < ActualParameterAST
     attr_accessor(:E)
     def initialize(expressionAST,token)
       super(token)
       @E = expressionAST
     end
   end
   class ConstDeclarationAST < DeclarationAST
     attr_accessor(:I,:E)
     def initialize(identifierAST, expressionAST,token)
       super(token)
       @I = identifierAST
       @E = expressionAST
     end
   end
   
   class FormalParameterAST < DeclarationAST
     def initialize(token)
       super(token)
     end    
   end
   
   class ConstFormalParameterAST < FormalParameterAST
     attr_accessor(:I,:T)
     def initialize(identifierAST, typeDenoterAST,token)
       super(token)
       @I = identifierAST
       @T = typeDenoterAST
     end
   end
   
   class DotVnameAST < VnameAST
     attr_accessor(:V,:I)
     def initialize(vnameAST, identifierAST,token)
       super(token)
       @V = vnameAST
       @I = identifierAST
     end
   end
   
   class EmptyActualParameterSequenceAST < ActualParameterSequenceAST
     def initialize(token)
       super(token)
     end       
   end
   class EmptyCommandAST < CommandAST
     def initialize(token)
       super(token)
     end
   end
   class EmptyExpression < ExpressionAST
     def initialize(token)
       super(token)
     end
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
     def initialize(identifierAST,token)
       super(token)
       @I = identifierAST
     end
   end
   
   class FuncDeclarationAST < DeclarationAST
     attr_accessor(:I,:FPS,:T,:E)
     def initialize(identifierAST, formalParameterSequenceAST,
                    typeDenoterAST, expressionAST,token)
         super(token)
         @I = identifierAST
         @FPS = formalParameterSequenceAST
         @T = typeDenoterAST
         @E = expressionAST
     end
   end
   
   class FuncFormalParameterAST < FormalParameterAST
     attr_accessor(:I,:FPS,:T)
     def initialize(identifierAST, formalParameterSequenceAST,
       typeDenoterAST,token)
       super(token)
       @I = identifierAST
       @FPS = formalParameterSequenceAST
       @token = typeDenoterAST
     end
   end
   
   class IfCommandAST < CommandAST
     attr_accessor(:E,:C1,:C2)
     def initialize(expressionAST, commandAST1, commandAST2,token)
       super(token)
       @E = expressionAST
       @C1 = commandAST1
       @C2 = commandAST2
     end
   end
   class IfExpressionAST < ExpressionAST
     attr_accessor(:E1,:E2,:E3)
     def initialize(expressionAST1, expressionAST2, expressionAST3,token)
        super(token)
        @E1 = expressionAST1
        @E2 = expressionAST2
        @E3 = expressionAST3
      end
   end
   
   class IntegerExpression < ExpressionAST
     attr_accessor(:I)
     def initialize(integerLiteralAST,token)
       super(token)
       @I = integerLiteralAST
     end
   end
   
   class IntegerLiteral < TerminalAST
     
   end
   class IntTypeDenoterAST < TypeDenoterAST
   end
   class LetCommandAST < CommandAST
     attr_accessor(:D,:C)
     def initialize(declarationAST, commandAST,token)
       super(token)
       @D = declarationAST
       @C = commandAST
     end
   end
   
   class LetExpressionAST < ExpressionAST
     attr_accessor(:D,:E)
      def initialize(declarationAST, expressionAST,token)
        super(token)
        @D = declarationAST
        @E = commandAST
      end  
   end
   
   class MultipleActualParameterSequenceAST < ActualParameterSequenceAST
     attr_accessor(:AP,:APS)
     def initialize(actualParameterAST, actualParameterSequenceAST,token)
       super(token)
       @AP = actualParameterAST
       @APS = actualParameterSequenceAST
     end
   end
   
   
   class MultipleArrayAggregateAST < ArrayAggregateAST
     attr_accessor(:AA,:E)
     def initialize(expressionAST, arrayAggregateAST,token)
       super(token)
       @E = expressionAST
       @AA = arrayAggregateAST
     end
   end
   
   class MultipleFieldTypeDenoterAST < FieldTypeDenoterAST
     attr_accessor(:I,:T,:FT)
     def initialize(identifierAST, typeDenoterAST, fieldTypeDenoterAST,token)
       super(token)
       @I = identifierAST
       @T = typeDenoterAST
       @FT = fieldTypeDenoterAST
     end
   end
   
   class MultipleFormalParameterSequenceAST < FormalParameterSequenceAST
     attr_accessor(:FP,:FPS)
     def initialize(formalParameterAST, formalParameterSequenceAST,token)
       super(token)
       @FP = formalParameterAST
       @FPS = formalParameterSequenceAST
     end
   end
   
   class MultipleRecordAggregateAST < RecordAggregateAST
     attr_accessor(:I,:E,:RA)
     def initialize(identifierAST, expressionAST, recordAggregateAST,token)
       super(token)
       @I = identifierAST
       @E = expressionAST
       @RA = recordAggregateAST
     end    
   end
   
   class RecordAggregateAST < AST
     attr_accessor(:type)
   end
   
   class RecordExpressionAST < ExpressionAST
     attr_accessor(:RA)
     def initialize(recordAggregateAST,token)
       super(token)
       @RA = recordAggregateAST
     end
   end
   
   class RecordTypeDenoterAST < TypeDenoterAST
     attr_accessor(:FT)
     def initialize(fieldTypeDenoterAST,token)
       super(token)
       @FT = fieldTypeDenoterAST
     end
   end
   class SequentialCommandAST < CommandAST
     attr_accessor(:C1,:C2)
     def initialize(commandAST1, commandAST2,token)
       super(token)
       @C1 = CommandAST1
       @C2 = commandAST2
     end
   end
   
   class SequentialDeclarationAST < DeclarationAST
     attr_accessor(:D1,:D2)
     def initialize(declarationAST1, declarationAST2,token)
       super(token)
       @D1 = declarationAST1
       @D2 = declarationAST2
     end
   end
   
   class SimpleTypeDenoterAST < TypeDenoterAST
     attr_accessor(:I)
     def initialize(identifierAST, token)
       super(token)
       @I = identifierAST
     end
   end
   
   class  SimpleVnameAST < VnameAST
     attr_accessor(:I)
     def initialize(identifierAST , token)
       super(token)
       @I = identifierAST
     end
   end
   
   class SingleActualParameterSequenceAST < ActualParameterSequenceAST
     attr_accessor(:AP)
     def initialize(actualParameterAST,token)
       super(token)
       @AP = actualParameterAST
     end
   end
   
   class SingleArrayAggregateAST < ArrayAggregateAST
     attr_accessor(:E)
     def initialize(expressionAST,token)
       super(token)
       @E = expressionAST
     end
   end
   
   class SingleFieldTypeDenoterAST < FieldTypeDenoterAST
     attr_accessor(:T,:I)
     def initialize(identifierAST, typeDenoterAST,token)
       super(token)
       @I = identifierAST
       @T = typeDenoterAST
     end
   end
   
   class SingleFormalParameterSequenceAST < FormalParameterSequenceAST
     attr_accessor(:FP)
     def initialize(formalParameterAST,token)
       super(token)
       @FP = formalParameterAST
     end
   end
   
   class SingleRecordAggregateAST < RecordAggregateAST
     attr_accessor(:I,:E)
     def initialize(identifierAST, expressionAST,token)
       super(token)
       @I = identifierAST
       @E = expressionAST
     end
   end
   
   class OperatorAST < TerminalAST
     attr_accessor(:decl)
     def initialize(spelling,token)
       super(spelling, token)
       @decl = nil
     end
   end
   
   class SubscriptVnameAST < VnameAST
     attr_accessor(:V, :E)
     def initialize(vnameAST, expressionAST,token)
       super(token)
       @V = vnameAST
       @E = expressionAST
     end
   end
   
   class TypeDeclarationAST < DeclarationAST
     attr_accessor(:I,:T)
     def initialize(identifierAST, typeDenoterAST,token)
       super(token)
       @I = identifierAST
       @T = typeDenoterAST
     end
   end
   
   class UnaryExpressionAST < ExpressionAST
     attr_accessor(:O,:E)
     def initialize(operatorAST, expressionAST,token)
       super(token)
       @O = operatorAST
       @E = expressionAST
     end
   end
   
   class ProcActualParameterAST < ActualParameterAST
     attr_accessor(:I)
     def initialize(identifierAST,token)
       super(token)
       @I = identifierAST
     end
   end
   
   class ProcDeclarationAST  < DeclarationAST
     attr_accessor(:I,:FPS,:C)
     def initialize(identifierAST, formalParameterSequenceAST,
                    commandAST,token)
         super(token)
         @I = identifierAST
         @FPS = FormalParameterSequenceAST
         @C = commandAST
     end
   end
   
   class ProcFormalParameterAST < FormalParameterAST
     attr_accessor(:I,:FPS)
     def initialize(identifierAST, formalParameterSequenceAST,token)
       super(token)
       @I = identifierAST
       @FPS = formalParameterSequenceAST
     end
   end
   
   class UnaryOperatorDeclarationAST < DeclarationAST
     attr_accessor(:O,:RES,:ARG)
     def initialize(operatorAST, argTypeDenoterAST,
       resultTypeDenoterAST,token)
       super(token)
       @O = operatorAST
       @ARG = argTypeDenoterAST
       @RES = resultTypeDenoterAST
     end
   end
   
   class VarActualParameterAST < ActualParameterAST
     attr_accessor(:V)
     def initialize(vnameAST,token)
       super(token)
       @V = vnameAST
     end
   end
   
  class VarDeclarationAST < DeclarationAST
    attr_accessor(:I,:T)
    def initialize(identifierAST, typeDenoterAST,token)
      super(token)
      @I = identifierAST
      @T = typeDenoterAST
    end
  end
  
  class VarFormalParameterAST < FormalParameterAST
    attr_accessor(:I,:T)
    def initialize(identifierAST, typeDenoterAST,token)
      super(token)
      @I = identifierAST
      @T = typeDenoterAST
    end
  end
  
  
  class VnameExpressionAST < ExpressionAST
    attr_accessor(:V)
    def initialize(vnameAST,token)
      super(token)
      @V = vnameAST
    end
  end
  
  class WhileCommandAST < CommandAST
    attr_accessor(:E,:C)
    def initilize(expressionAST, commandAST,token)
      super(token)
      @E = expressionAST
      @C = commandAST
    end
  end
  
  
end