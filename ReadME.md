# Connect4
## About
This is my CSC590 Connect4 project which was defined so that we would collect requirements from a costumer and then design and implement them. The project is written in swift and designed to be run on a Mac. To play the game, select the number of bots you want to use and click begin game. Then click in the middle of a square to place your piece there. The reset button clears the game and the game setup button returns to the Home Screen. If you’re not certain how to play Connect4, then click on the help button to go to a wiki how article. 

## Known Issues
When confetti appears on the screen, the message `NSHostingView is being laid out reentrantly while rendering its SwiftUI content. This is not supported and the current layout pass will be skipped`. might appear. This is a bug in the Apple library I am using and thus not fixable by me.
There is another error when playing bot vs. bot and tapping reset really fast. This creates a `BAD_ACCESS` fatal error in the bot code. The cause of this is unkown, but my guess is it's a flaw in the random number generator. This was a very niche case and bot vs. bot was not in the requirements, so this issue is still in progress.

## Given Requirements
- Mac App (swift in Xcode) 
- One character is a smiley emoji 😃, the other is a triangle 🔺 \*
- The game should be animated (like confetti when you win), can be completed using SwiftUI \*
- 1 Player \*
- Controlled by the keyboard (arrow keys)
- Random bot to play against 
- Black and white color scheme
