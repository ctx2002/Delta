# encoding: utf-8
module Delta
    require File.absolute_path(File.dirname(__FILE__) + '\\' + 'ast')
  class Parser
    @currentToken
    attr_accessor(:scanner)
    def initialize(scanner)
      @scanner = scanner
    end
    
    def accept?(tokenID)
      if @currentToken.match?(tokenID)
        @currentToken = @scanner.scan()
        return true
      end
      raise SyntaxError, "Expected #{tokenID}, current #{@currentToken.classInfo}"
    end
    
    def acceptIt()
      @currentToken = @scanner.scan()  
    end
    
    def parseProgram
        @currentToken = preToken = @scanner.scan()
        begin
          commandAST = parseCommand()
          programAST =  Delta::programAST.new(commandAST,preToken)
        rescue SyntaxError
          return nil  
        end
        return programAST     
    end
    
    def parseCommand
      commandAST = nil
      commandAST = parseSingleCommand();
    end
    
    def parseSingleCommand
      commandAST = nil
      if (@currentToken.match?(:identifier))
        identifierAST = parseIdentifier();
      elsif (@currentToken.match?(:lparen))
        acceptIt()  
      end
    end
    
    def parseIdentifier
      preToken = @currentToken
      idenAST = nil
      if accept?(:identifier)     
          idenAST = Delta::IdentifierAST.new(preToken)
      end
      return idenAST
    end
  end
  
  class SyntaxError < StandardError  
  end
end