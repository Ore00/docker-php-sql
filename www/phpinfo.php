<?php
if(mail("linda.mcgraw@me.com","Testing PHP","Hope this works!"))
    print "Email successful" . PHP_EOL;
else
    print "Failure"  . PHP_EOL;

    phpinfo();
?>