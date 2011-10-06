# encoding: utf-8
module Delta
    class Source
      attr_accessor(:fileName,:file ,:currentChar)
    attr_reader(:position, :line, :prePosition)
        attr_reader(:lineState,:charCode)
    def initialize(file)
        @fileName = file
      @position = -1;
      @line = 1;
      @lineState = 0
    end
    def open
        if File.exists?(@fileName) && !File.directory?(@fileName)
          @file = File.new(@fileName, "r")
      else
          puts "file is not exists. --- " + @fileName
        exit
            end
    end
    def getc
        if @file
        return @file.getc
      else 
          puts "File was not open " + @fileName
                exit        
      end
    end
    def ungetc(char)
        if @file
          if ["\n","\r"].include?(char)
            @line -= 1;    
        end
        @position = @prePosition
          @file.ungetc(char)
      else
          puts "File was not open " + @fileName
                exit
      end
    end
    
    def takeChar
        @currentChar = getc
      sourceInfo (@currentChar) 
    end
    
    def fetchFirstChar
        @currentChar = getc
            skipBOM     
            sourceInfo (@currentChar) 
            return @currentChar     
    end
    
    def screen (char)
        if @file
        if ( char != nil ) #not at end of file
          sourceInfo(char)  
        else
          updateSourceInfo
          @charCode = -1      
        end
      else
          puts "File was not open " + @fileName
                exit        
      end
    end
    
    
    private
    def skipBOM
        if @currentChar.ord == 61371 #0xef 0xbb
        ck = getc
        n = 0
        cl = -1
        ck.each_byte do |c|
            n = n + 1
          cl = c
        end
        if cl == 191 && n == 1 #cl is 0xbf
            #0xef 0xbb 0xbf is a BOM sequence
            @currentChar = getc
                    sourceInfo (@currentChar)
                else
                    ungetc(ck)        
        end
      end   
    end
    
    
    private 
    def sourceInfo (char)
        @prePosition = @position
        @position += 1
      detectNewLine(char)
      
      if char != nil
                @charCode = char.ord
      else
          @charCode = -1
            end   
    end
    
    private
    def detectNewLine (char)
        if @lineState == 0
              if ["\n","\r"].include?(char)
                    #puts "enter",char,@position        
            #updateSourceInfo
          @lineState = 1
        end
      elsif @lineState == 1
          
          if not (["\n","\r"].include?(char) )
            updateSourceInfo      
        end
        @lineState = 0
          #if not ["\n","\r"].include?(char) 
        #    @lineSate = 0
        #else
        #   updateSourceInfo
                #    @lineSate = 0          
        #end
      end
    end
    private
    def updateSourceInfo
        @line += 1
      @prePosition = @position
      @position = 0
    end
    end 
end