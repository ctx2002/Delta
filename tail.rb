#coding utf-8
#this script working for 1.8 and 1.9 
if ARGV.length() > 1
    fileName = ARGV[1]
	line = ARGV[0].to_i
	
	currentLine = 1;
	handler = File.new(fileName, "r")
	
	handler.seek(0,IO::SEEK_END)

	state = 0
	back = -3
	while true
	    
	    c = handler.getc
		break if (currentLine > line)
		break if (handler.tell == 1) #reach start position
		
		if (state == 0 and c != nil)
		    if (c.chr == "\r" or c.chr == "\n")
			    #ruby moved 3 pointer forward to fetch a end of line character
				back = -3
			    state = 1
			end
		elsif (state == 1 and c != nil)
		    if (c.chr != "\n" and c.chr != "\r")
			    state = 0
				currentLine += 1
				back = -2
			end
		end
		
		#since getc moved file pointer , we have to back up 2 characters
		#it like go forward 1 step , backward 2 steps, so we are not going to examine 
		#same character
		handler.seek( back,IO::SEEK_CUR)
	end
	
	#skip 3 characters, this is because last call is call to fetch end of line character
    #ruby moved 3 pointer forward to fetch a end of line character	
    handler.seek( 3,IO::SEEK_CUR)
	while(true)
	   if (line = handler.gets() )
		    puts line   
		end
	end
else 
    puts "Usage :"
    puts "tail last_n_line filename"
    puts "tail 5 filename retrieve last 5 line of the filename"	
end
#my comment
#other ok what
#hello 777
#4567
#gui
#0000
#wwwwww
#4567890
#ppppppp