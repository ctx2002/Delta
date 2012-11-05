<?php

/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
class CSVFile implements Iterator
{
    protected $handle;
    protected $fileName;
    protected $delimiter;
    protected $enclosure;
    protected $current;
    protected $header;
    
    protected $line;
    protected $skip;
	
    public function __construct($fileName,$delimiter=',',$enclosure='"',$escape='\\')
    {
        $this->fileName=$fileName;
        $this->delimiter = $delimiter;
        $this->enclosure = $enclosure;
        $this->escape = $escape;
        $this->handle = $this->openFile($this->fileName);
        $this->markHeader(true);
        $this->line = 0;
        $this->skipHeader(true);
    }
    
    protected function openFile($fileName)
    {
        $h = fopen($fileName, "r");
        if (!$h)
            throw new Exception("Unable to open  " . $fileName . ".");
        return $h;
    }
    
    public function skipHeader($skip = true)
    {
        $this->skip = $skip;
	return $this->skip;
    }
    
    public function markHeader($header = true)
    {
        if ($header == false) {
		    $this->skipHeader(false);    
		}
		$this->header = $header;    
    }
    
    public function hasHeader()
    {
        return $this->header;
    }
    
    public function key()
    {
        return ftell($this->handle);
    }
    
    public function current ( )
    {
	$obj = new CSVRow($this->current,$this->header);
        return $obj;     
    }
    
    public function next()
    {
        //fgetcsv already set up next position
        $this->addLine(1);
    }
    
    public function rewind()
    {
        $this->line = 0;
        rewind($this->handle);
    }
    public function valid()
    {
        $this->current = fgetcsv($this->handle, 0, $this->delimiter,$this->enclosure,$this->escape);	
        if ($this->hasHeader() && $this->line == 0) {
            $this->header = $this->current;
        }
			
        if ($this->skip && $this->line == 0 ) {
            $this->current = fgetcsv($this->handle, 0, $this->delimiter,$this->enclosure,$this->escape);
        }
        return $this->current;
    }
    
    protected function addLine($number)
    {
        $this->line += $number;   
    }
	
	public function __destruct()
	{
	    fclose($this->handle);
	}
}

class CSVRow
{
    protected $data;
    protected $header;
    
    /*
     * header array constains headers, and must has same order
     * as data array. 
     * for example:
     *     header array is array('name','address','phone')
     *     data array is array('nru','4 battterby avenue','0212678854')
           
     */
    public function __construct($data,$header)
    {
        $this->data = $data;
	$this->header = $header;
    }
    
    public function getData()
    {
        return $this->data;
    }
    
   
    public function changeItToAssoc()
    {
        $temp = array();
        $i = 0;
        foreach ($this->header as $header) {
            if (isset($this->data[$i]))
                $temp[$header] = $this->data[$i];
            ++$i;
        }
        
        return $temp;
    }
}
/*
$obj = new CSVFile("my.csv");
 //no header
$obj->markHeader(false);

foreach (  $obj as $data) {
    //this is wrong, since I have set markHeader(false) to false, which 
   // means this csv has no header. so we can not use changeItToAssoc method.  
    var_dump($data->changeItToAssoc());
}
 * 
 * 
 * $obj = new CSVFile("my.csv");
 * foreach (  $obj as $data) {
 *     // i am assuming , my.csv file contains header.
 *     var_dump($data->changeItToAssoc());    
 * }
 * 
 */