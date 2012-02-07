# encoding: utf-8
module Delta
  require File.absolute_path(File.dirname(__FILE__) + '\\' + 'ast')
  class Parser
    
    attr_accessor(:scanner,:currentToken)
    def initialize(scanner)
      @scanner = scanner
    end
    
    def accept(tokenID)
      if @currentToken.match?(tokenID)
        @currentToken = scan()
      else
        raise SyntaxError, "Expected '#{tokenID}', current #{@currentToken.classInfo} #{@currentToken.value} line #{@currentToken.sourceInfo}"  
      end      
    end
    
    def scan
      token = @scanner.scan()
	  #|| token.match?(:eof)
      while(token.match?(:comment)  || token.match?(:space))
        token = @scanner.scan()
      end
      return token
    end
    
    def acceptIt()
      @currentToken = scan()
    end
    
    def parseProgram
        @currentToken = preToken = scan()
        begin
          commandAST = parseCommand()
          #p commandAST
          programAST =  Delta::ProgramAST.new(commandAST,preToken)
		  p programAST
        rescue SyntaxError
          print "An error occurred: ",$!, "\n"
          return nil  
        end
        return programAST     
    end
    
    def parseCommand
      commandAST = nil
      preToken = @currentToken
      commandAST = parseSingleCommand()
	  
      while (@currentToken.match?(:semicolon))
         acceptIt();
         commandAST2 = parseSingleCommand();
         commandAST = SequentialCommandAST.new(commandAST,commandAST2,preToken)
      end
      return commandAST
    end
    
    def parseSingleCommand
      commandAST = nil
      preToken = @currentToken
      
      if (@currentToken.match?(:identifier))
        
        iAST = parseIdentifier()
        if (@currentToken.match?(:lparen) )
          acceptIt() 
          apsAST = parseActualParameterSequence()
          accept(:rparen)
          commandAST = CallCommandAST.new(iAST, apsAST, preToken)
        else
          vAST = parseRestOfVname(iAST);
          accept(:becomes);
          eAST = parseExpression();
          commandAST = AssignCommandAST.new(vAST, eAST, preToken)  
        end
      elsif (@currentToken.match?(:begin))
        acceptIt();
        commandAST = parseCommand()
        accept(:end);
      elsif (@currentToken.match?(:let))
        acceptIt()
        dAST = parseDeclaration()
        accept(:in)
        cAST = parseSingleCommand()
        commandAST = LetCommandAST.new(dAST, cAST, preToken);
      elsif (@currentToken.match?(:if))
        acceptIt();
        eAST = parseExpression()
        accept(:then)
        c1AST = parseSingleCommand()
        accept(:else);
        c2AST = parseSingleCommand()
        commandAST = new IfCommandAST(eAST, c1AST, c2AST, preToken)
      elsif (@currentToken.match?(:while))
        acceptIt();
        eAST = parseExpression()
        accept(:do)
        cAST = parseSingleCommand()
        commandAST = WhileCommandAST.new(eAST, cAST, preToken); 
      elsif (@currentToken.match?(:semicolon) ||
             @currentToken.match?(:end) ||
              @currentToken.match?(:else) ||
              @currentToken.match?(:in) ||
              @currentToken.match?(:eot) )  
       commandAST = EmptyCommandAST.new(preToken)
      else
        raise SyntaxError, "cannot start a command , current token #{@currentToken.classInfo}"  
      end
      
      return commandAST
    end
    
    def parseRestOfVname(identifierAST)
      preToken = @currentToken
      vAST = SimpleVnameAST.new(identifierAST,preToken)
      while (@currentToken.match?(:dot) || @currentToken.match?(:lbracket))
        if (@currentToken.match?(:dot))
          acceptIt()
          iAST = parseIdentifier()
          vAST = DotVnameAST.new(vAST, iAST, preToken)
        else
          acceptIt()
          eAST = parseExpression()
          accept(:rbracket);
          vAST = SubscriptVname.new(vAST, eAST, vnamePos)
        end
      end
      
      return vAST  
    end
    
    def parseExpression
      expressionAST = nil
      preToken = @currentToken
      if (@currentToken.match?(:let))
        acceptIt()
        dAST = parseDeclaration()
        accept(:in)
        expressionAST = parseExpression()
        expressionAST = LetExpressionAST.new(dAST, eAST, preToken);
      elsif(@currentToken.match?(:if))
        acceptIt()
        e1AST = parseExpression()
        accept(:then)
        e2AST = parseExpression()
        accept(:else);
        e3AST = parseExpression()
        expressionAST = IfExpressionAST.new(e1AST, e2AST, e3AST, preToken)
      else
        expressionAST = parseSecondaryExpression()
      end
      return expressionAST  
    end
    
    def parseSecondaryExpression
      expressionAST = nil
      preToken = @currentToken
      expressionAST = parsePrimaryExpression();
      while (@currentToken.match?(:operator))
        opAST = parseOperator()
        e2AST = parsePrimaryExpression();
        expressionAST = BinaryExpressionAST.new(expressionAST, opAST, e2AST,preToken)
      end
      return expressionAST
    end
    
    def parsePrimaryExpression
      preToken = @currentToken
      expressionAST = nil
      if @currentToken.match?(:intliteral)
        ilAST = parseIntegerLiteral()
        expressionAST = IntegerExpressionAST.new(ilAST , preToken)
      elsif @currentToken.match?(:charliteral)
        clAST= parseCharacterLiteral()
        expressionAST = CharacterExpressionAST.new(clAST, preToken)
      elsif @currentToken.match?(:lbracket)
        acceptIt()
        aaAST = parseArrayAggregate();
        accept(:rbracket);
        expressionAST = ArrayExpressionAST.new(aaAST, preToken)
      elsif @currentToken.match?(:lcurly)
        acceptIt();
        raAST = parseRecordAggregate()
        accept(:rcurly)
        expressionAST = RecordExpressionAST.new(raAST, pretoken)
      elsif @currentToken.match?(:identifier)
        iAST= parseIdentifier()
        if (@currentToken.match?(:lparen) )
          acceptIt()
          apsAST = parseActualParameterSequence()
          accept(:rparen)
          expressionAST = CallExpressionAST.new(iAST, apsAST, preToken)
        else
          vAST = parseRestOfVname(iAST)
          expressionAST = VnameExpressionAST.new(vAST, preToken)
        end
      elsif @currentToken.match?(:operator)
        opAST = parseOperator()
        eAST = parsePrimaryExpression()
        expressionAST = UnaryExpressionAST.new(opAST, eAST, preToken)
      elsif @currentToken.match?(:lparen)
        acceptIt()
        expressionAST = parseExpression()
        accept(:rparen)
      else
        raise SyntaxError, "cannot start an expression , current token #{@currentToken.classInfo}"    
      end    
    end
    
    def parseActualParameterSequence
      actualAST = nil
      preToken = @currentToken
      id  = TokenClass.getID(@currentToken.spelling)
      if [:identifier,:intliteral,:charliteral,:operator,:let,:if,:lparen,:lbracket,:lcurly].include?(id)
        eAST = parseExpression()
        actualAST = new ConstActualParameterAST.new(eAST, @currentToken)
      elsif ( @currentToken.match?(:var) )
        acceptIt();
        vAST = parseVname()
        actualAST = VarActualParameterAST.new(vAST, preToken)
      elsif ( @currentToken.match?(:proc) )
        acceptIt()
        iAST = parseIdentifier()
        actualAST = ProcActualParameterAST.new(iAST, preToken)
      elsif ( @currentToken.match?(:func) )
        acceptIt()
        iAST = parseIdentifier()
        actualAST = FuncActualParameterAST.new(iAST, preToken)
      else
        #cannot start an actual parameter
        raise SyntaxError, "cannot start an actual parameter , current token #{@currentToken.classInfo}"    
      end
      
      return actualAST
    end
    
    def parseVname
		vnameAST = nil
		iAST = parseIdentifier()
		parseRestOfVname(iAST)
		return vnameAST
    end
    
    def parseIdentifier
      i = nil
      if (@currentToken.match?(:identifier)) 
        i = new IdentifierAST.new(@currentToken)
        acceptIt()
      else
        i = nil
        raise SyntaxError, "identifier expected here , current token #{@currentToken.classInfo}"    
      end
      return I;
    end
    
    def parseIntegerLiteral
      il = nil
      
      if @currentToken.match?(:intliteral)
        il = IntegerLiteralAST.new(@currentToken)
        acceptIt()
      else
        il = nil
        raise SyntaxError, "integer literal expected here , current token #{@currentToken.classInfo}"    
      end
      
      return il;
    end
    
    def parseCharacterLiteral
      cl = nil
      if @currentToken.match?(:charliteral)
        cl =   CharacterLiteralAST.new(@currentToken)
        acceptIt()
      else
        cl = nil
        raise SyntaxError, "character literal expected here , current token #{@currentToken.classInfo}"
      end
      
      return cl
    end
    
    def parseArrayAggregate
      aggregateAST = nil
      preToken = @currentToken
  
      eAST = parseExpression()
      if @currentToken.match?(:comma)
        acceptIt()
        aAST = parseArrayAggregate()
        aggregateAST = MultipleArrayAggregateAST.new(eAST, aAST, preToken)
      else
        aggregateAST = SingleArrayAggregateAST.new(eAST, preToken) 
      end
      
      return aggregateAST
    end
    
    def parseRecordAggregate
      aggregateAST = nil
      preToken = @currentToken
      iAST = parseIdentifier()
      accept(:is)
      eAST = parseExpression()
      if @currentToken.match?(:comma)
        acceptIt()
        aAST = parseRecordAggregate()
        aggregateAST = MultipleRecordAggregateAST,new(iAST, eAST, aAST, preToken)
      else
        aggregateAST = SingleRecordAggregate.new(iAST, eAST, preToken)
      end
      
      return aggregateAST
    end
    
    def parseOperator
      operator = nil
      if @currentToken.match?(:operator)
        operator = OperatorAST.new(@currentToken)
		@currentToken = scan()
      else
        operator = nil
        raise SyntaxError, "operator expected here , current token #{@currentToken.classInfo}"  
      end
      return operator
    end
    
    def parseDeclaration
      declarationAST = nil 
      preToken = @currentToken
      declarationAST = parseSingleDeclaration();
      #if currentToken is :var, which means there are 
	  #multiple var definition line , and one of line is not ended with ";"
	  #for example:
	  # var n: integer
      # var c: char 
	  # var n: integer must followed by a ";"
	  if (@currentToken.match?(:var))
	    raise SyntaxError, "need a ; after a var definition"
	  end
      while (@currentToken.match?(:semicolon) ) 
        acceptIt();
        d2AST = parseSingleDeclaration();
        declarationAST = SequentialDeclarationAST.new(declarationAST, d2AST,preToken);
      end
      return declarationAST
    end
    
    def parseSingleDeclaration
      declarationAST = nil
      preToken = @currentToken
      if (@currentToken.match?(:const))
        acceptIt();
        iAST = parseIdentifier();
        accept(:is);
		preToken = @currentToken
        eAST = parseExpression();
        declarationAST = ConstDeclaration.AST(iAST, eAST, preToken);
      elsif (@currentToken.match?(:var))
        acceptIt()
        iAST = parseIdentifier();
        accept(:colon);
		preToken = @currentToken
        tAST = parseTypeDenoter();
        declarationAST = VarDeclarationAST.new(iAST, tAST, preToken);
      elsif (@currentToken.match?(:proc))
        acceptIt();
        iAST = parseIdentifier();
        accept(:lparen);
        fpsAST = parseFormalParameterSequence();
        accept(:rparen);
        accept(:is);
		preToken = @currentToken
        cAST = parseSingleCommand()
        declarationAST = ProcDeclarationAST.new(iAST, fpsAST, cAST, preToken);
      elsif (@currentToken.match?(:func))
        acceptIt();
        iAST = parseIdentifier();
        accept(:lparen);
        fpsAST = parseFormalParameterSequence();
        accept(:rparen);
        accept(:colon);
        tAST = parseTypeDenoter()
        accept(:is);
		preToken = @currentToken
        eAST = parseExpression();
        declarationAST = FuncDeclarationAST(iAST, fpsAST, tAST, eAST,preToken);
      elsif (@currentToken.match?(:type))
        acceptIt();
        iAST = parseIdentifier();
        accept(:is);
		preToken = @currentToken
        tAST = parseTypeDenoter();
        declarationAST = new TypeDeclarationAST.new(iAST, tAST, preToken);
      else
        raise SyntaxError, "cannot start a declaration , current token #{@currentToken.classInfo}"   
      end
    end
    
	def parseTypeDenoter
	  typeAST = nil
	  preToken = @currentToken
	  if (@currentToken.match?(:identifier))
	    iAST = parseIdentifier()
		typeAST = SimpleTypeDenoterAST.new(iAST,preToken)
	  elsif(@currentToken.match?(:array))
	    acceptIt();
        ilAST = parseIntegerLiteral()
        accept(:of);
        tAST = parseTypeDenoter()
		typeAST = ArrayTypeDenoter(ilAST,tAST,preToken)
	  elsif(@currentToken.match?(:record))
	    acceptIt();
		fAST = parseFieldTypeDenoter()
		accept(:end)
		typeAST = RecordTypeDenoterAST(fAST,preToken)
	   else
	     raise SyntaxError, "cannot start a type denoter, current token #{@currentToken.classInfo}" 
	  end
	  return typeAST
	end
	def parseFieldTypeDenoter
	  fieldAST = nil
	  preToken = @currentToken
	  iAST = parseIdentifier()
	  accept(:colon);
	  tAST = parseTypeDenoter()
	  if (@currentToken.match?(:comma))
	    acceptIt();
		fAST = parseFieldTypeDenoter()
		fieldAST = MultipleFieldTypeDenoterAST.new(iAST,tAST,fAST,preToken)
      else
	    fieldAST = SingleFieldTypeDenoterAST.new(iAST,tAST,preToken)
	  end
	  return fieldAST
	end
    def parseActualParameterSequence
      actualsAST = nil
      preToken = @currentToken
      if @currentToken.match?(:rparen)
        actualsAST = EmptyActualParameterSequenceAST.new(preToken)
      else
        actualsAST = parseProperActualParameterSequence()  
      end
      return actualsAST 
    end
    
    def parseProperActualParameterSequence
      actualsAST = nil
      preToken = @currentToken
      apAST = parseActualParameter()
      
      if (@currentToken.match?(:comma) )
        accepIt()
        apsAST = parseProperActualParameterSequence()
        actualsAST = MultipleActualParameterSequenceAST.new(apAST, apsAST,preToken)
      else
        actualsAST = SingleActualParameterSequence.new(apAST, preToken);
      end
      return actualsAST
    end
	
	def parseFormalParameterSequence
	  preToken = @currentToken
	  formalsAST = nil
	  if (@currentToken.match?(:rparen))
	    formalsAST = EmptyFormalParameterSequenceAST.new(preToken)
	  else
	    formalsAST = parseProperFormalParameterSequence()
	  end
	  return formalsAST
	end
    def parseProperFormalParameterSequence
      preToken = @currentToken
	  formalsAST = nil
      fpAST = parseFormalParameter
      if (@currentToken.match?(:comma))
        acceptIt()
		preToken = @currentToken
		fpsAST = parseProperFormalParameterSequence
		formalsAST = MultipleFormalParameterSequenceAST.new(fpAST,fpsAST,preToken)
	  else
	    formalsAST = SingleFormalParameterSequenceAST.new(fpAST,preToken)
	  end
      return formalsAST	  
	end
	def parseFormalParameter
	   formalAST = nil
	   
	   if (@currentToken.match?(:identifier))
	    iAST = parseIdentifier()
		accept(:colon)
		preToken = @currentToken
		tAST = parseTypeDenoter()
		formalAST = ConstFormalParameterAST.new(iAST,tAST,preToken)
	   elsif (@currentToken.match?(:var))
	    iAST = parseIdentifier()
		accept(:colon)
		preToken = @currentToken
		tAST = parseTypeDenoter()
		formalAST = VarFormalParameterAST.new(iAST,tAST,preToken)
	   elsif (@currentToken.match?(:proc))
		 acceptIt()
		 iAST = parseIdentifier()
		 accept(:lparen)
		 fpsAST = parseFormalParameterSequence 
		 accept(:rparen)
		 preToken = @currentToken
		 formalAST = ProcFormalParameterAST.new(iAST,fpsAST,preToken)
	   elsif (@currentToken.match?(:func))
		 acceptIt()
		 iAST = parseIdentifier()
		 accept(:lparen)
		 fpsAST = parseFormalParameterSequence
		 accept(:rparen)
		 accept(:colon)
		 tAST = parseTypeDenoter()
		 preToken = @currentToken
		 formalAST = FuncFormalParameterAST.new(iAST,fpsAST,tAST,preToken)
		else
		 raise SyntaxError, "cannot start a formal parameter, current token #{@currentToken.classInfo}" 
	   end
	   return formalAST
	end
    def parseActualParameter
      actualAST = nil
      preToken = @currentToken
      if @currentToken.match?(:identifier) or
         @currentToken.match?(:intliteral) or
         @currentToken.match?(:charliteral) or
         @currentToken.match?(:operator) or
         @currentToken.match?(:let) or
         @currentToken.match?(:if) or
         @currentToken.match?(:lparen) or
         @currentToken.match?(:lbracket) or
         @currentToken.match?(:lcurly)
         eAST = parseExpression       
         actualAST = ConstActualParameterAST.new(eAST, preToken)
      elsif @currentToken.match?(:var)
        acceptIt()
        vAST = parseVname();
        actualAST = VarActualParameterAST.new(vAST, preToken)
      elsif @currentToken.match?(:proc)
        acceptIt()
        iAST = parseIdentifier
        actualAST = ProcActualParameterAST(iAST, preToken)
      elsif @currentToken.match?(:func)
        acceptIt()
        iAST = parseIdentifier       
        actualAST = FuncActualParameterAST.new(iAST, actualPos);
      else
        raise SyntaxError, "cannot start an actual parameter, current #{@currentToken.classInfo}"  
      end
    end
    
    def parseIdentifier
      preToken = @currentToken
      idenAST = nil
	  
      if @currentToken.match?(:identifier)     
          idenAST = Delta::IdentifierAST.new(preToken)
          @currentToken = scan()
      else
        raise SyntaxError, "identifier expected here, current #{@currentToken.classInfo}"
      end
      return idenAST
    end
  end
  
  class SyntaxError < StandardError  
  end
end