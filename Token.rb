# encoding: utf-8
module Delta
    
  class TokenClass
    @@tokenClass = Hash.new
    @@tokenClass[:intliteral] = "<int>"
    @@tokenClass[:charliteral] = "<char>"
    @@tokenClass[:eof] = '<eof>'
    
    @@tokenClass[:space] = '<space>'
    @@tokenClass[:operator] = '<operator>'
    @@tokenClass[:identifier] = '<identifier>'
    @@tokenClass[:array] = 'array'
    @@tokenClass[:begin] = 'begin'
    @@tokenClass[:const] = 'const'
    @@tokenClass[:do] = 'do'
    @@tokenClass[:else] = 'else'
    @@tokenClass[:end] = 'end'
    @@tokenClass[:func] = 'func'
    @@tokenClass[:if] = 'if'
    @@tokenClass[:in] = 'in'
    @@tokenClass[:let] = 'let'
    @@tokenClass[:of] = 'of'
    @@tokenClass[:proc] = 'proc'
    @@tokenClass[:record] = 'record'
    @@tokenClass[:type] = 'type'
    @@tokenClass[:then] = 'then'
    @@tokenClass[:var] = 'var'
    @@tokenClass[:while] = 'while'
    @@tokenClass[:dot] = '.'
    @@tokenClass[:colon] = ':'
    @@tokenClass[:semicolon] = ';'
    @@tokenClass[:comma] = ','
    @@tokenClass[:becomes] = ':='
    @@tokenClass[:is] = '~'
    @@tokenClass[:lparen] = '('
    @@tokenClass[:rparen] = ')'
    @@tokenClass[:lbracket] = '['
    @@tokenClass[:rbracket] = ']'
    @@tokenClass[:lcurly] = '{'
    @@tokenClass[:rcurly] = '}'
    @@tokenClass[:error] = '<error>'
    
    
    
    def self.getTokenClass(classSymbol)
      return @@tokenClass[classSymbol]
    end
    
    end

  class Token
    
    attr_accessor(:spelling,:sourceInfo,:classInfo,:value)
    #class << self; attr_accessor :tokenClass end
    def initialize()
        @sourceInfo = Hash.new
      #@tokenClass = Hash.new
      #@tokenClass[:intliteral] = "<int>    "
      #@tokenClass[:charliteral] = "<char>    "
      #@tokenClass[:eof] = '    '
      #@tokenClass[:semicolon] = ';    '
      #@tokenClass[:space] = '<space> '
    end
    
    def match?(tokenClass)
        if TokenClass.getTokenClass(tokenClass) ==  TokenClass.getTokenClass(@classInfo)
      #if (TokenClass.tokenClass[@classInfo] == TokenClass.tokenClass[tokenClass])
          return true;
      end
      return false
    end
    
    #def match?(token)
    #    if ( token.classInfo == @classInfo )
    #     return true
    # end
    # return false
    #end
    
    def eofToken?
        #return @source.charCode == -1 ? true : false
      if (@spelling == TokenClass.getTokenClass(:eof) )
          return true
      end
      return false
    end
  end
end