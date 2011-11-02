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
        raise SyntaxError, "Expected #{tokenID}, current #{@currentToken.classInfo} #{@currentToken.value}"  
      end      
    end
    
    def scan
      token = @scanner.scan()
      while(token.match?(:comment) || token.match?(:eof) || token.match?(:space))
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
          programAST =  Delta::programAST.new(commandAST,preToken)
        rescue SyntaxError
          print "An error occurred: ",$!, "\n"
          return nil  
        end
        return programAST     
    end
    
    def parseCommand
      commandAST = nil
      preToken = @currentToken
      commandAST = parseSingleCommand();
      
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
      puts __method__
      p @currentToken
      if (@currentToken.match?(:identifier))
        puts __method__
        puts "in"
        iAST = parseIdentifier()
        p @currentToken
        if (@currentToken.match?(:lparen) )
          acceptIt() 
          apsAST = parseActualParameterSequence()
          accept(:rparen)
          commandAST = CallCommandAST.new(iAST, apsAST, preToken)
        else
          vAST = parseRestOfVname(iAST);
          accept(:becomes);
          eAST = parseExpression();
          commandAST = new AssignCommand.new(vAST, eAST, preToken);  
        end
      elsif (@currentToken.match?(:begin))
        acceptIt();
        commandAST = parseCommand();
        accept(:end);
      elsif (@currentToken.match?(:let))
        acceptIt()
        dAST = parseDeclaration()
        accept(:in)
        cAST = parseSingleCommand()
        commandAST = LetCommand.new(dAST, cAST, preToken);
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
        acceptIt();
        #TODO
        #dAST = parseDeclaration();
        #accept(Token.IN);
        #Expression eAST = parseExpression();
        #finish(expressionPos);
        #expressionAST = new LetExpression(dAST, eAST, expressionPos);
      elsif(@currentToken.match?(:if))
        #acceptIt();
        #Expression e1AST = parseExpression();
        #accept(Token.THEN);
        #Expression e2AST = parseExpression();
        #accept(Token.ELSE);
        #Expression e3AST = parseExpression();
        #finish(expressionPos);
        #expressionAST = new IfExpression(e1AST, e2AST, e3AST, expressionPos);
      else
        #expressionAST = parseSecondaryExpression()
      end
      return expressionAST  
    end
    
    def parseDeclaration
      declarationAST = nil
      preToken = @currentToken
      declarationAST = parseSingleDeclaration();
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
        eAST = parseExpression();
        declarationAST = ConstDeclaration.AST(iAST, eAST, preToken);
      elsif (@currentToken.match?(:var))
        acceptIt();
        iAST = parseIdentifier();
        accept(:colon);
        
        #TypeDenoter tAST = parseTypeDenoter();
        #declarationAST = new VarDeclaration(iAST, tAST, declarationPos);
      elsif (@currentToken.match?(:proc))
        acceptIt();
        iAST = parseIdentifier();
        accept(:lparen);
        #FormalParameterSequence fpsAST = parseFormalParameterSequence();
        #accept(Token.RPAREN);
        #accept(Token.IS);
        #Command cAST = parseSingleCommand();
        #finish(declarationPos);
        #declarationAST = new ProcDeclaration(iAST, fpsAST, cAST, declarationPos);
      elsif (@currentToken.match?(:func))
        acceptIt();
        Identifier iAST = parseIdentifier();
        accept(:lparen);
        #FormalParameterSequence fpsAST = parseFormalParameterSequence();
        #accept(Token.RPAREN);
        #accept(Token.COLON);
        #TypeDenoter tAST = parseTypeDenoter();
        #accept(Token.IS);
        #Expression eAST = parseExpression();
        #finish(declarationPos);
        #declarationAST = new FuncDeclaration(iAST, fpsAST, tAST, eAST,declarationPos);
      elsif (@currentToken.match?(:type))
        acceptIt();
        iAST = parseIdentifier();
        accept(:is);
        #TypeDenoter tAST = parseTypeDenoter();
        #finish(declarationPos);
        #declarationAST = new TypeDeclaration(iAST, tAST, declarationPos);
      else
        raise SyntaxError, "cannot start a declaration , current token #{@currentToken.classInfo}"   
      end
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
      
      if @currentToken.match?(:comma)
        accepIt()
        apsAST = parseProperActualParameterSequence()
        actualsAST = MultipleActualParameterSequenceAST.new(apAST, apsAST,preToken)
      else
        actualsAST = SingleActualParameterSequence.new(apAST, preToken);
      end
      return actualsAST
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
          puts __method__
          p @currentToken
      else
        raise SyntaxError, "identifier expected here, current #{@currentToken.classInfo}"
      end
      return idenAST
    end
  end
  
  class SyntaxError < StandardError  
  end
end