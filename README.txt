Authors James Otwell and Jason Wojcik

- Game Description
	Our game is a replica of one of our favorite games while growing up; Pokemon.
	Many of us can remember growing up and playing Pokemon on our gameboys and we
	wanted to recreate that experience.  Our game will include several original
	characters, battles, and an open world experience.

- Documentation
camera.pde: Contains the logic for the camera that follows the player.  This 
			logic stops the camera when the player is near a wall and
			follows the player when he is moving. The player is always in the 
			center of the screen unless near the edge of the map.

game.pde: Contains the logic for the game as well as the starting screen and animations.
		  The majority of the code for our game will be written in this file.

player.pde: Contains the logic for character movement, animation and display.
			This file will hold all of the logic for the player.

tilemap.pde: This file contains the logic for the background tilemap.  It 
			 builds up the background tilemap then exports it as an image 
			 so that rendering is faster.

index.html: default html file displayed when the ip address of the ip of the VM
			is entered in the browser. Runs the processing code to display game

tile.html: runs javascript to display and number the tiles used in the game.
			Helper file to see which number a tile is to be entered in tilemap 
			arrays.

Artistic Credits.txt: file that gives credit to authors of the images used for the game

All other files are image resources to be used in the game

- Instructions

For our final project, our team used multiple files as well as several images.
These files and images must be included in order for the game to run.

The necessary files are also included here: https://github.com/jmotwel/VGDFinal

You need to host a file server in the directory in order to play the game.
If you have python it is simple. Python comes integrated with a file server.
The command is:
python -m http.server
After running the command go to the address specified in the console.
By default it is http://localhost:8000


All of the code for our game is included in the .pde files.
These files are "camera.pde", "game.pde", "player.pde", "tilemap.pde", monster.pde, and "viewTiles.pde".

Any permissions and credits given for the images and artistic work are inside the atistic credits
text file.

- Game Controls
Currently we only have the game menu and scrolling tilemap implemented. Use the mouse to click
on buttons in the screen. Press the start game button to start the game and the instructions
button to view the instructions. Make sure the game is focused on by clicking on the 400x400
canvas if the controls arent working. Use WSAD to move the player once the game has started.
Press "r" to toggle the run state of the player and move faster.

Shortcuts:

9: set gamestate to playing area and set shiny chance to 1:1
8: add 5 pokemon to team.
7: show starting animation.

Please email either jmwojcik@vt.edu or jmotwel@vt.edu with any questions.
