# toon castle
Godot game demo:
https://www.youtube.com/watch?v=Lov2zu0alTg

# backstory
Started as a client request for a Godot game demo.

Client backed out, but opted to complete as an educational exercise.

# tools / techniques
Q: How were the game characters built?
* character meshes + animations were downloaded from mixamo.com (for FREE)
* these files were then combined into a single FBX file via: https://nilooy.github.io/character-animation-combiner/
* finally, imported each character as a single FBX, with the animations baked in.

Q: How was the dialog system created?
* using this awesome plugin: https://github.com/dialogic-godot/dialogic (FREE)
* there's still some strong coupling added to the DialogManager class, but will refactor if needed for next project

Q: How do the characters know what action to take in the game?
* using this awesome plugin: https://github.com/limbonaut/limboai (FREE)
* note, while got both component-based Behaviour Tree and script-based state transitions to work properly, could NOT get them to work together.

Q: Where did the room assets come from (e.g. chairs, tables, wall fixtures...)?
* using this awesome site: https://opengameart.org/
* all music downloaded from here as well  
* will be adding credits here for any assets included 

# contact
If you'd ever like to talk shop, project work, e-music, or even politics:
contact@codebycandle.com
tyler@tylercoder.com
