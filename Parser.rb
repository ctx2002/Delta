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
    
    def parseProgram
        @currentToken = preToken = @scanner.scan()
        commandAST = parseCommand()
        programAST =  Delta::programAST.new(commandAST,preToken)     
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