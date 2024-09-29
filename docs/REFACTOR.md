# Prewords
Consistency is the must when it comes

This document will
most of the guideline here is inspired from the following videos:

# Naming Convention
- ALL NAMES MUST BE IN ENGLISH. DO NOT MIX LANGUAGES!
    - This includes everything from variables, function, comments, documentation, all the way to any interaction towards this repository.
    - Names written in other language are allowed as long as it is only treated strictly as name.
- File name must be in `snake_case`. DO NOT CAPITALIZE ANY LETTER.
    - Keep in mind that non-Windows system treats letters with different capitalization as separate things.
    - If the name
- Functions, variables, and signal must be in `snake_case` as well. Signal names should be on past tense.
- Class names and Enumeration must be in `PascalCase`.
- Constants must be in `CONSTANT_CASE`.

# Folder Structure
```
assets\
|-

chapters\
|- chapter_0\	    - Prologue
|   |- level_1\
|   |- ...
|   |- objects\
|   |- gameplay\
|- chapter_1\	    - The original three levels
|   |- cutscenes\
|   |- level_1\
|   |- level_2\
|   |- level_3\
|   |- objects\
|   |- gameplay\
|	|- button_mashing\
|	|- wire_connect\
|	|- ...
|- chapter_2\
|   |- level_1\
|   |- ...
|   |- objects\
|   |- gameplay\
|- chapter_...\

globals\

menu\
|- main_menu


scenes\
|- chapter_0\ (prologuie)
    |- asd
|- chapter_1\
    |- level_1
|- chapter_2\
```
