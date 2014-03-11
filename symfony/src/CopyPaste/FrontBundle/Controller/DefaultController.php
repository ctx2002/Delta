<?php

namespace CopyPaste\FrontBundle\Controller;

use Symfony\Bundle\FrameworkBundle\Controller\Controller;

class DefaultController extends Controller
{
    public function indexAction()
    {
        return $this->render('CopyPasteFrontBundle:Default:index.html.twig');
    }
}
