# UCR_Dota2
Math Methods for SP

The purpose of this experiment was to determine if the UCR matrix profile could be used for atypical signal analysis.
Using win/loss data from the videogame Dota2, my goal was to make a simplistic model that generated a signal,
with several limitations and assumptions, that could be analyzed in theory with the UCR matrix profile to pull worthwhile information.

My goal was to determine if I could use the matrix profile to find when specific characters were not properly balanced, by having a bloated win/loss ratio. In theory, if a character is too strong within the confines of the game, they'll win a disproportionately high amount of the time, thus have a higher frequency of winning.

Starting this project was a large deal, because I wasn’t exactly sure what I could do with a long list of binary data and a tool that finds patterns and motifs. My first instinct was to start pulling out obvious expectation values of specific things, which will require some elaboration on the background, to justify my reasoning.

The game data I pulled from the machine learning database was from the videogame Dota 2, a competitive online multiplayer game where there are two teams of five players each. Within those two teams, each player will select from a roster of 111 characters (at-time of data aquisition). Once a character is chosen, that character is no longer available for selection, i.e., it is choice without replacement. This will come up later, in the creation of my rough model. Character selection is done by taking turns, starting with a randomly chosen team to go first, then alternating between the two.

The data for each character was two-fold: 1 or -1 for which team won the game, and for each character, 1, 0, -1, to determine which team the character was on, and a 0 if the character was not picked. From this data, it was straightforward to compile a very accurate assessment of the Expected Value of character selection and the Expected Value of a win. Thus,

E(R) = r1, ... , rk, where p is either 1, 0, -1, to represent character selection, and,
E(W) = w1, ... , wk, where w is 1 or -1 to represent a character win. Of course, the likelihood of winning is more appropriately represented by,
P1(w1|p1) = w1, ... , wk.
Thus, as a first step in my project, I calculated two things, for each character. Within the loop, I did not discriminate between whether team 1 or team 2 won, I counted each win as a success, to reduce confusion for myself later. I only care how often a character won, not which team they were on when they won.

To see the  desired result, using the Game Simulator script at 10000 games and choose a particular character. I set it to Skeleton King, after adjusting his charwinrate to be .7044 instead of .5544, so that the results could be more apparent. The simulation is a bernouli distributed series of games, based on the cumulative mean winrate of each character on the team. Characters on each team are randomly picked, except the chosen character. The chosen character is always on team 2. After running the simulation, the wins for each team are stored in the t1wins and t2wins vectors.
These vectors can be dropped right in to the matrix profile, with length 500, to indicate a string of 500 straight wins in a row. Ideally, there should be no obvious string that long, because that would indicate a character is highly favored to win.
Bumping up the number of simulations and string length, it becomes easier to get a more granular image of wins.

I've uploaded images of the graphs from the UCR main analysis script, as well as the skewed and normal simulations with the chosen character.

As a brief aside, there is further analysis to be done in this regard, as teams are not playing from the same positions, but rather a reflected side of the map. As an extension of this project, it could easily be expanded upon by determining whether a character tends to perform better based on which side they play on.
