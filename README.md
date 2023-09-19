# PIXEL JUMP
### Video Demo: https://youtu.be/jKnUsMxosUc
### Description:
A "Doodle jump" clone infinite scrolling platformer made in Godot using GDScript.
Originally, I thought about doing something like a pong clone, or something else more "classic". I even thought about doing a flappy bird clone, which I've done before. The main reason behind choosing this project in specific was the simplicity in a fun game. It's nothing out of the ordinary, you just go up. It brought me back to the era of early cellphone games, like the endless runners and fruit cutters of old.

### The files:
GDScript is not a very convoluted language, so most files here should be easy to understand. Nevertheless, here they are:

#### Scripts:
Here is where all the code logic rests.

    title_screen
    This is, well, the title screen code. It handles the button functionality for re(starting) the game and showing your highscore.

    global
    This script is quite simple: It declares the public variable score so it can be used freely between the scenes (both in calculating your score ingame and showing your best score on the main menu).

    platform, cloud_platform, spring_platform and enemy
    Self explanatory. They are the main obstacle in the game: While the platform parent is nothing special, the cloud platform is programmed to dissapear after being jumped on (while not giving you much height), the spring platform launches the player much farther, and the enemy moves around and can kill the player if not hit from above.

    player
    Code for the player. Handles movement, screenwrapping in the horizontal axis when the player goes too far in a direction, jumping (which is automatic), and a death function in case the player collides with the enemy (unless it is from above, in which case it will not trigger this function and instead jump on the enemy).

    game
    Where most of the logic resides. Here, platforms are initially spawned, with one appearing for every one that gets cleared upon reaching the platform_cleaner object. It also handles collision, spawning random platforms, making sure they can't spawn twice in a row so the game doesn't softlock the player, handling each special case (enemy and cloud dissapearing after being hit, enemies being able to kill the player) and updating your score.

#### Scenes
Here is where the objects themselves are located. Nothing to note here logic-wise, just the different nodes each object uses (player being a kinematicbody, for example).

#### Assets
Here is where all the used (and unused!) assets were made. Most were acquired from Kenney (www.kenney.nl), all under the cc0 (No rights reserved) license.