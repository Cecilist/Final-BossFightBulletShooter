# Final Project

## Made By
- Jacob Cecil
- Lucas Harris

## Project Report
After receiving our feedback from iteration 1, we went into this iteration with three main goals, ensure we follow our class adopted style guide, get some properly working health bars, and make some enemy attacks that aren't just random bullets flying across the screen.
 We set aside time towards the end of the iteration (Monday night and Tuesday morning to be exact) to go over every line of code, and sure it meet the style guide. 
 Lucas commited to redoing the health bar, making a proper HUD, and adding in powerups for the player. 
 Jacob commited to getting more interesting attacks for the boss, and handling the other bit of feedback we got, wich was about our player ship's hit box.
 Every bullet hell game that I (Jacob) have played has had a hit box around the size of just a few pixels, while the player sprite is much larger. 
 We wanted to mimic this idea. 
 A feature we hope to implement as inspiriation from other bullet hell games is a near miss system. 
 Essentailly, if a bullet is colliding with either the player sprite, or very close to it, the player accumulates either points towards their score, or fills up some kind of super attack meter. 
 For iteration two, we decided to make the hit box overlap with the what the player ship's cockpit, and move forward from there if need be based on feedback. 
 We have made some good progress this iteration.
 We dont't have a solid plan for iteration 3 yet, but its probably going to be all about added polish to what we have, and adding more attacks to the boss, and player. 

## Evaluation
- [X] D-1: The repository link is submitted to Canvas before the project deadline.
- [X] D-2: The repository contains a <code>README.md</code> file in its top-level directory.
- [X] D-3: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of M or less.
- [X] C-1: Your repository is well-formed, with an appropriate <code>.gitignore</code> file and no unnecessary files tracked.
- [X] C-2: Your release is tagged using <a href="https://semver.org/">semantic versioning</a> where the major version is zero, the minor version is the iteration number, and the patch version is incremented as usual for each change made to the minor version, and the release name matches the release tag.
- [X] C-3: You have a clear legal right to use all incorporated assets, and the licenses for all third-party assets are tracked in the <code>README.md</code> file.
- [X] C-4: The <code>README.md</code> contains instructions for how to play the game or such instructions are incorporated into the game itself.
- [X] C-5: The project content is eligible for an <a href="https://www.esrb.org/ratings-guide/">ESRB Rating</a> of T or less.
- [X] C-6: The release demonstrates the core gameplay loop: the player can take actions that move them toward a goal.
- [X] B-1: The <code>README.md</code> file contains a personal reflection on the iteration and self-evaluation, as defined above.
- [X] B-2: The game runs without errors or warnings.
- [X] B-3: The source code and project structure comply with our adopted style guides.
- [X] B-4: Clear progress has been made on the game with respect to the project plan.
- [X] A-1: The source code contains no warnings. All warnings are properly addressed, not just ignored.
- [X] A-2: The game includes the conventional player experience loop of title, gameplay, and ending.
- [X] A-3: Earn <em>N</em>*&lceil;<em>P</em>/2&rceil; stars, where <em>N</em> is the iteration number and <em>P</em> is the number of people on the team.
- [ ] ⭐ Include a dynamic (non-static) camera
- [ ] ⭐ Incorporate parallax background scrolling
- [ ] ⭐ Use paper doll animations
- [ ] ⭐ Incorporate smooth transitions between title, game, and end states, rather than jumping between states via <code>change_scene</code>
- [ ] ⭐ Support two of the following: touch input, mouse/keyboard input, and gamepad input
- [ ] ⭐ Allow the user to control the volume of music and sound effects independently.
- [ ] ⭐ Incorporate juiciness and document it in the <code>README.md</code>
- [ ] ⭐ Use particle effects
- [ ] ⭐ Use different layers and masks to manage collisions and document this in the <code>README.md</code>
- [X] ⭐ Incorporate pop into your HUD or title screen using <code>Tween</code> or <code>AnimationPlayer</code>
- [ ] ⭐ Include an AI-controlled character
- [X] ⭐ Add a pause menu that includes, at minimum, the ability to resume or return to the main menu
- [ ] ⭐ The game is released publicly on <code>itch.io</code>, with all the recommended accompanying text, screenshots, gameplay videos, <i>etc.</i>

This project effectively accomplishes all of the necessary requirements, so it deserves an **__** grade.

## Third Party Assets
- [Chakra Petch](https://fonts.google.com/specimen/Chakra+Petch), licensed under [OFL](https://scripts.sil.org/cms/scripts/page.php?site_id=nrsi&id=OFL)
- Player Bullet Sprites from [Kenny](https://www.kenney.nl/assets/pixel-shmup) licensed under [CC0 1.0](https://creativecommons.org/publicdomain/zero/1.0/)