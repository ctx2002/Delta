# encoding: utf-8
module Delta
  class AST
    attr_accessor(:token,:astName)
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
      @astName = "identifierAST"
    end
  end
  
end