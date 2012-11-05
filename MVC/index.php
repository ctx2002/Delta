<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title></title>
    </head>
    <body>
        <?php
        // put your code herevar_dump();
        var_dump($_SERVER['REQUEST_URI']);
       $rt = parse_url($_SERVER['REQUEST_URI']);
        var_dump(explode("/",$rt['path']));
        ?>
    </body>
</html>
