clc
%time stepping
t = ([1:100])';
window = [1 max(t) -1 1];
%pick a character from the NAMES variable!
chosencharacter = 'skeleton king';

%signal creation, there is a signal for each team, then a signal for a
%specfic character's winrate and pickrate average. This is meant to
%simulate the character being picked, then winning the game
sc = .5*sin(charwinrate(find(strcmp(names,chosencharacter)))*t);
st1 = .5*sin(mean(t1wins)*t);
st2 = .5*sin(mean(t2wins)*t);

%this is the composition of all three signals, which is ideally going to
%represent when a team wins, and is likely to have the chosen character on
%their side
scomp = sc + st1 + st2;

%this adds some normally distributed noise, to make things slightly more
%obfuscated and potentially changed
yn = .5*(sc + 0.5*randn(size(t)));

figure(6)
subplot(2,2,1)
plot(t,sc)
title('Chosen Character Pick Frequency')
xlabel('Pick Simulations')
ylabel('Peak: Character is Picked')
axis(window)

subplot(2,2,2)
hold on
plot(t,st1,'b')
plot(t,st2,'r')
title('Team1 and Team2 Win Frequency')
xlabel('Samples')
ylabel('Peak: Team1/Team2 Won a Game')
axis(window)

subplot(2,2,3:4)
plot(t,yn)
title('Chosen Character Pick Frequency')
xlabel('Game Simulations')
ylabel('Peak: Team1/Team2 Won a Game with Chosen Character')
axis(window)

