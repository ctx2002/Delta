<?php

namespace CopyPaste\UserBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction($name)
    {
        return $this->render('CopyPasteUserBundle:Default:index.html.twig', array('name' => $name));
    }
}
