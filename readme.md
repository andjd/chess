#Readme:

This is a chess emulator built in ruby with a comand-line interface and a basic AI.

###Usage:

First, install ruby on your machine if you haven't already.

Before you can launch the game, you will need to install two gems.  In your terminal, run:

```
$ gem install colorize
$ gem install io-console
```

Then, you can navigate to the proper directory and launch the game with:

```
$ ruby chess.rb
```

This.will launch a default game where white is a human player and black is played by an easily-beaten AI. You may want to increase your font size to increase visibility of the unicode chess pieces

If you would like to play human against human, enter pry or irb and then enter:

```
> load 'chess.rb'
> Chess.new.play
```

alternatively, you can watch two computer players engage in senseless and fruitless violence by running:

```
> Chess.new(ComputerPlayer, ComputerPlayer).play
```

enjoy!

###Features to add:

[ ] castling

[ ] pawn capture en-passant

[ ] pawn promotion

[ ] smarter AI

[ ] tabbing through possible moves once a piece is selected

