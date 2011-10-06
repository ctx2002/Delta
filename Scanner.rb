# encoding: utf-8


module Delta
    require File.absolute_path(File.dirname(__FILE__) + '\\' + 'Token')
  
  class Scanner
    attr_accessor(:register)
    class << self
        attr_accessor :source
    end
    def initialize(file)
      Scanner.source = file
      @register = Array.new
      Scanner.source.fetchFirstChar
      initRegister
    end
    
    def initRegister
      @register << SemicolonToken.new
      @register << IntegerToken.new
      @register << EofToken.new
      @register << SpaceToken.new
        @register << CommentToken.new
      @register << IdentifierToken.new
      @register << OperatorToken.new
      @register << DotToken.new
      @register << BecomesToken.new
      @register << ColonToken.new
      @register << CommaToken.new
      @register << IsToken.new
      @register << Lcurly.new
      @register << Rcurly.new
      @register << Lparen.new
      @register << Rparen.new
      @register << Lbracket.new
      @register << Rbracket.new
    end
    
    def scan
      error = true
      for t in @register
          if t.matchFirst? == true
            error = false
          t.collectInfo
          return t.currentToken
        end
      end 
      
      if error == true
          return ErrorToken.new.currentToken
            else
                puts "internal error"
        p Scanner.source
                exit      
      end
    end
    
    def start
        Scanner.source.getc
    end
    
  end
  
  class ScanToken
      attr_accessor( :currentToken)
    def initialize
      @currentToken = nil 
    end
    
    def takeIt
      Scanner.source.takeChar
    end
    
    private
    def tokenInfo(tokenClass,value)
        @currentToken = Delta::Token.new
        @currentToken.sourceInfo[:charCode] = Scanner.source.charCode
      @currentToken.sourceInfo[:currentLine] = Scanner.source.line
      @currentToken.sourceInfo[:startColumn] = Scanner.source.position
      @currentToken.classInfo = tokenClass
      @currentToken.spelling = Delta::TokenClass.getTokenClass(tokenClass)
      @currentToken.value = value
    end
  end
  
  class ErrorToken < ScanToken
      def initialize
        tokenInfo(:error,Scanner.source.currentChar)
      takeIt
    end   
  end
  
  class Lcurly < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == '{'
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:lcurly,'{')
          takeIt
    end     
  end
  
  class Rcurly < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == '}'
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:rcurly,'}')
          takeIt
    end     
  end
  
  class Rbracket < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == ']'
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:rbracket,']')
          takeIt
    end     
  end
  
  class Lbracket < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == '['
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:lbracket,'[')
          takeIt
    end     
  end
  class Rparen < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == ')'
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:rparen,')')
          takeIt
    end  
  end
  class Lparen < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == '('
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:lparen,'(')
          takeIt
    end    
  end
  class IsToken < ScanToken
      def matchFirst?
        if Scanner.source.currentChar == '~'
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:is,'~')
          takeIt
    end
  end
  class CommaToken < ScanToken
    def matchFirst?
        if Scanner.source.currentChar == ','
                return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:comma,',')
          takeIt
    end
  end
  class ColonToken < ScanToken
      def matchFirst?
        r = false
      
        if Scanner.source.currentChar == ':'
          takeIt
        if (Scanner.source.currentChar != '=')
            r = true
        end
        Scanner.source.ungetc(Scanner.source.currentChar)   
      end
      return r   
    end
    def collectInfo
        tokenInfo(:colon,':')
          takeIt
        end
  end
  
  class BecomesToken < ScanToken
      def matchFirst?
        r = false
      old = Scanner.source.currentChar
        if old == ':'
          takeIt()
        if (Scanner.source.currentChar == '=')
            r = true
        else
            Scanner.source.ungetc(Scanner.source.currentChar)
          Scanner.source.currentChar = old
        end    
      end
      return r   
    end
    def collectInfo
        tokenInfo(:becomes,':=')
          takeIt
        end
  end
  
  class DotToken < ScanToken
      def matchFirst?
            if Scanner.source.currentChar == '.'
        return true
      end
      return false
    end
        
        def collectInfo
        tokenInfo(:dot,'.')
          takeIt
        end   
  end
  class OperatorToken < ScanToken
       
      def matchFirst?
            if ['+','-','*','/','=','<','>','\\','&','@','%','^','?'].include?(Scanner.source.currentChar) 
        return true
      end
      return false
    end

        def collectInfo
        tokenValue = ''
      startColumn = Scanner.source.position
      line = Scanner.source.line
      charCode = Scanner.source.charCode
            
      loop do
          tokenValue = tokenValue + Scanner.source.currentChar
                takeIt  
          break if !['+','-','*','/','=','<','>','\\','&','@','%','^','?'].include?(Scanner.source.currentChar)           
      end
      
      tokenInfo(:operator,tokenValue)
      @currentToken.sourceInfo[:charCode] = charCode
      @currentToken.sourceInfo[:currentLine] = line
      @currentToken.sourceInfo[:startColumn] = startColumn 
    end       
  end
  class IdentifierToken < ScanToken
      def matchFirst?
            if (Scanner.source.currentChar =~ /[a-zA-Z]/) != nil
        return true
      end
      return false
    end
        
        def collectInfo
        tokenValue = ''
      startColumn = Scanner.source.position
      line = Scanner.source.line
      charCode = Scanner.source.charCode
      
      loop do
          tokenValue = tokenValue + Scanner.source.currentChar
                takeIt
                break if (Scanner.source.currentChar =~ /[a-zA-Z]/) == nil    
      end
            #while (Scanner.source.currentChar =~ /[a-zA-Z]/) != nil
            #   tokenValue = tokenValue + Scanner.source.currentChar
      # takeIt
      #end
            tokenInfo(:identifier,tokenValue)
      @currentToken.sourceInfo[:charCode] = charCode
      @currentToken.sourceInfo[:currentLine] = line
      @currentToken.sourceInfo[:startColumn] = startColumn
            #puts "current symbol " , Scanner.source.currentChar      
    end   
  end
  
  class CommentToken < ScanToken
      def matchFirst?
            if (Scanner.source.currentChar == '!')
        return true
      end
      return false
    end
        def collectInfo
            while  Scanner.source.currentChar != "\n" &&   Scanner.source.currentChar != "\r" && Scanner.source.charCode != -1
        takeIt    
      end
      #if Scanner.source.currentChar == "\n" || Scanner.source.currentChar == "\r"
      # takeIt
      #end
      tokenInfo(:space,'!')   
    end   
  end
  
  class SpaceToken < ScanToken
      def matchFirst?
            if (Scanner.source.currentChar =~ /\s/) != nil
        return true
      end
      return false
    end
    def collectInfo
        tokenInfo(:space,'<space>')
      takeIt
    end
  end
  
  class SemicolonToken < ScanToken
      
    def matchFirst?
        if  Scanner.source.currentChar == ';'
        return true
      end
      
      return false
      
    end
    def collectInfo
        tokenInfo(:semicolon,';')
      takeIt
    end
  end
  
  class EofToken < ScanToken
      
    def matchFirst?
      return Scanner.source.charCode == -1 ? true : false
    end
    def collectInfo
        Scanner.source.screen(Scanner.source.currentChar)
        tokenInfo(:eof,nil)
    end
  end
  
  class IntegerToken < ScanToken
      
      def matchFirst?
      return ['0','1','2','3','4','5','6','7','8','9'].include?(Scanner.source.currentChar)
    end
        def collectInfo
           
      tokenValue = ''
      
      startColumn = Scanner.source.position
      line = Scanner.source.line
      charCode = Scanner.source.charCode
      
      loop do
          tokenValue = tokenValue + Scanner.source.currentChar
                takeIt
                break if !(['0','1','2','3','4','5','6','7','8','9'].include?(Scanner.source.currentChar) )     
      end
      #while ['0','1','2','3','4','5','6','7','8','9'].include?(Scanner.source.currentChar)
      # tokenValue = tokenValue + Scanner.source.currentChar
            #    takeIt   
      #end
      
      tokenInfo(:intliteral,tokenValue.to_i)
      @currentToken.sourceInfo[:charCode] = charCode
      @currentToken.sourceInfo[:currentLine] = line
      @currentToken.sourceInfo[:startColumn] = startColumn
    end   
  end
end