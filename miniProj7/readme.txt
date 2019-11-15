Author:james Otwell

Bases off of code from example file on canvas
Tile map is open source image
This game is a simple example of a* search algorithm through maze
There is no win condition just try to escape from the ghosts
Use the WSAD keys to move through the maze

SETUP:
Processing js is really wierd about loading images and files
when trying to view it through the browser. The steps below 
will show you how to host a directory to be viewed in the 
browser.

Easiest method is using python3

Step 1:
    Python comes with a build in http server to host files
    Makes Sure you have python 3 installed. The cla will be 
    different for python 2
Step2:
    cd to the mini project 7 directory add enter the following
    command:
        python3 -m http.server

    This will host the current directory files on port 8000
    make sure no other service is using this port.
Step3:
    enter:
        localhost:8000
    into the web browser. Here you should see all the files
    in the directory. Click on template.html and the game
    should load.