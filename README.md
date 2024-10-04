# Toon Castle
https://www.youtube.com/watch?v=Lov2zu0alTg

# about
Started as a client request for a Godot game demo.

Client backed out, so opted to complete as an educational exercise.

# faq
Q: How were the game characters built?
* character meshes + animations were downloaded from https://mixamo.com (FREE)
* these files were then combined into a single GLTF via: https://nilooy.github.io/character-animation-combiner/ (FREE)
* finally, imported each character with the animations baked in.

Q: How was the dialog system created?
* using this awesome plugin: https://github.com/dialogic-godot/dialogic (FREE)
* there's still some strong coupling added to the DialogManager class, but will refactor if needed for next project

Q: How do the characters know what action to take in the game?
* using this awesome plugin: https://github.com/limbonaut/limboai (FREE)
* while got component-based Behaviour Tree and script-based state transitions to work properly, could NOT get working together

Q: Where did the room assets come from (e.g. chairs, tables, wall fixtures...)?
* using this awesome site: https://opengameart.org/ (FREE)
* all music / sfx downloaded as well  
* will be adding credits here for any assets included 

Q: Why do the NPC characters seem to "clumb up" at the end while walking?
* was playing with "avoidance" settings (etc) on NavAgents, but may need further polish

Q: Where did you get the Flame and ItemFound particle fx?
* built from scratch; thanks, https://youtube.com (FREE)

Q: How did you make the wavy line effect in the title screen background?
* used a cool "canvas" shader from https://godotshaders.com/ (FREE)

Q: How did you create the simple quest UI (top right)?
* downloaded "outlined" images from https://images.google.com (FREE)
* made "filled" versions using image editor: https://www.gimp.org/ (FREE) 

Q: How did you texture the walls, ceiling, and floor?
* using this awesome app: https://materialmaker.org/ (FREE)
* leveraged the "import from website" option to browse exsiting materials

# contact
If you'd ever like to talk tech, projects, e-music, or politics:
* contact@codebycandle.com
* tyler@tylercoder.com
