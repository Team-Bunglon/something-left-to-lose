# Notes
1. This is a Godot 3 project. Make sure you use Godot 3 version 3.5.X.
    - Porting this game to Godot 4 is NOT adviced.
2. This document is Applicable as long as the current owner of this repository, Rayhan Ryu, still works on the project. 
    - If you are a new developer (or developer team) taking over this repository, feel free to create your own guideline but I recommend to take inspiration from this document.
    - This guideline exists to make our lives as developer easier by proritizing consistency and clean code over "getting things done ASAP". This will save you headaches in the long run and reduce technical debts for future developers.
3. Last document update: September 29th 2024

# Guidelines
1. Please only use English when involving everything within this repository (commit message, merge request, variables, comments, etc.)
    - Proper naming convention will be explained further in [REFACTOR](REFACTOR.md) document.
2. Always pull from `staging`. Do NOT directly push to `staging`. See [Merging](#merging).
    - `staging` should be merged towards `main` after some period of time.
    - If you apply the agile sprint development method, it should be merged at the end of your sprint peroid.
4. As an extention to previous rule, always base your branch with the latest commit from `staging` before pushing.
5. Try to make your changes as minimal and efficient as possible. 
6. If you need to use godot addon or external assets, make sure you have the right license or permission to use and credit them at the repo's README.
7. If you use an external editor, put any unimportant directories or files that the editor may generate into `.gitignore` (e.g. `.idea` for Intellij IDE).

# Merging
1. Create a new branch from `staging`. You can name your branch with anything (Your name, feature name, etc.)
2. After committing your changes, __always do a git pull from `staging`__. I recommend setting your pull strategy to `rebase`.
3. Once you have the latest commit from `staging` in your branch, push into the new branch.
4. Create a merge request. Any new request will be automatically notified through Discord.
    
There's no specific guideline for commit message as long as you are clear about it. However, for merge request, please list out every features and fixes you have done to make understanding your merge request easier.

# Important Note
It should be goes without saying but it's adviced to NOT modify other people's work without permission. Unlike the previous project where I have the absolute control over my repository, I only hold this project so that we can continue its development and I should respect the original code of the previous developers with the exception of refactoring their code for the sake of future developers.

# Reources
- [OpenGameArt.org](https://opengameart.org/) has a vast library of game assets we can use and this is the recommended place to find assets.
- [Kenney](https://www.kenney.nl/) also has a collection of high-quality, free assets. However, it may clashes with the game's artstyle. 
- [Youtube](https://youtube.com/) may have many free-to-use audio assets available. Make sure the creator is fine with you using their creation. A rule of thumb is that if there's no mention about using their creation for your project in the description, you do not have their permission and you should directly ask them for it.
