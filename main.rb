# encoding: utf-8
require File.absolute_path(File.dirname(__FILE__) + '\\' + 'Parser')
require File.absolute_path(File.dirname(__FILE__) + '\\' + 'Token')
require File.absolute_path(File.dirname(__FILE__) + '\\' + 'Source')
require File.absolute_path(File.dirname(__FILE__) + '\\' + 'Scanner')       
#puts File.expand_path(File.dirname(__FILE__) + '\\' + 'Token')


s = Delta::Source.new('dd.txt')
s.open()
scan = Delta::Scanner.new(s)

p = Delta::Parser.new(scan);
p.parseProgram()
#scan.start
#parser = Delta::Parser.new(scan)
#token = scan.scan
#p token
#while ( !token.eofToken?)
  #parser.parseIdentifier(token)
 # token = scan.scan
  #p token
#end