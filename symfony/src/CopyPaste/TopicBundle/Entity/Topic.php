<?php
namespace CopyPaste\TopicBundle\Entity;
use Doctrine\ORM\Mapping as ORM;
/*\@\HasLifecycleCallbacks*/

/**
 * @ORM\Entity
 * @ORM\Table(name="topic")
 * 
 */
class Topic {
    /**
     * @ORM\Id
     * @ORM\Column(type="guid")
     * @ORM\GeneratedValue(strategy="UUID")
     */
    protected $id;
    /**
     * @ORM\Column(type="string", length=128)
     */
    protected $subject;
    
    /**
     * @ORM\Column(type="text")
     */
    protected $content;
    
    /** 
     * @ORM\Column(type="datetime", name="datetime_created")
     * 
     */
    protected $dateTimeCreated;
    /** 
     * @ORM\Column(type="datetime", name="datetime_modified")
     *
     *  
     */
    protected $dateTimeModified;
    /** 
     * @ORM\Column(type="datetime", name="datetime_published") 
     */
    protected $dateTimePublished;
    
    
    /** 
     * @ORM\Column(type="datetime", name="datetime_removed")
     *
     */
    protected $dateTimeRemoved;
    
    /** @ORM\Column(type="string") */
    protected $timezone;
    
    /**
     * @var bool
     */
    private $localized = false;

    public function __construct(\DateTime $createDate)
    {
        $this->localized = true;
        $this->created = $createDate;
        $this->timezone = $createDate->getTimeZone()->getName();
    }

    public function getCreated()
    {
        if (!$this->localized) {
            $this->created->setTimeZone(new \DateTimeZone($this->timezone));
        }
        return $this->created;
    }
}

?>
