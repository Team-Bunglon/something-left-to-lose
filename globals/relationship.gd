# Determines the outcome of the game. Currently, the ammount of relationship correlate to what ending you'll received.
# relationship > 0 --> GOOD ENDING
# relationship <= 0 --> BAD ENDING
# It seems that having a whole global variable just to hold a single variable is too much but whatever.
extends Node

# The value of relationship you currently have.
var amount = 0
