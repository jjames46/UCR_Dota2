# UCR_Dota2
Math Methods for SP

The purpose of this experiment was to determine if the UCR matrix profile could be used for atypical signal analysis.
Using win/loss data from the videogame Dota2, my goal was to make a simplistic model that generated a signal,
with several limitations and assumptions, that could be analyzed in theory with the UCR matrix profile to pull worthwhile information.

My goal was to determine if I could use the matrix profile to find when specific characters were not properly balanced, by having a bloated win/loss ratio. In theory, if a character is too strong within the confines of the game, they'll win a disproportionately high amount of the time, thus have a higher frequency of winning.

There are several pieces to this simple model. The first being the main test statistic of win/loss ratio, which is actually predicated on another factor: pick rate. How frequently a character is picked has a direct impact on their winrate, and when trying to balance a game, a character could appear to be more strong but have a very low pickrate, making the numbers seem more potent than they actually would be.

The first script, UCR_dota.m, is used to analyze the various factors in a characters winrate and pickrate. I compare two separate forms of winrate and pickrate, one within regards to the entire population of characters, and one within the confines of only the games of that character.\
Of all 111 characters (at time of data collection), how often is each character picked? And, of all games played, how often does that character win, when picked?

If the character has a bloated winrate, the frequency of wins would be inherently higher, so my thought was to use that idea to somehow generate a signal that has motifs of a specified length (which would be the number of games) and if there are too many wins in a row, it would ping the character as over-powered. This same logic applies for the discordants, where the character's string of losses indicate that they are under-powered.
