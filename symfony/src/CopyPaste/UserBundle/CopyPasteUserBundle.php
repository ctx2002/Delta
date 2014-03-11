<?php

namespace CopyPaste\UserBundle;

use Symfony\Component\HttpKernel\Bundle\Bundle;

class CopyPasteUserBundle extends Bundle
{
    public function getParent()
    {
        /*
         * By returning the name of the bundle in the getParent method of 
         * your bundle class, you are telling the Symfony2 framework that 
         * your bundle is a child of the FOSUserBundle
         */
        return 'FOSUserBundle';
    }
}
