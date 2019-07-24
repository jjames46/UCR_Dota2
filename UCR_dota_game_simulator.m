%% UCR_dota.m Game simulator

clc
t1wins=[];
t2wins=[];

%this will select 10 random heroes, with no replacement
%the unfortunate part is that I cannot have both weighted selection and no
%replacement, and adding this functionality would take far too much time to
%implement before the due date of this project

%The complexity would also increase, because likelihood of selection would
%change based on which heroes were available and which were not, this is
%barring any level of strategic complexity with counter-picking certain
%characters; also ignoring selection based on the lane positioning of each
%hero

%thus, this simulation only accounts for the win percentage of the randomly
%selected heroes, with equal likelihood of selection
games = 10000;

%pick a character from the NAMES variable!
chosencharacter = {'skeleton king'};
simnames = names;
idx = strcmp(simnames, chosencharacter);
simnames(idx) = [];

for g = 1:games+1

    teams = datasample(simnames,9,'Replace',false);
    team1 = teams(1:5);
    team2 = teams(6:end);
    team2(end+1) = chosencharacter;

        %this loops through the team and pulls out the team winrate data, and the
        %pickrate data for fun, to determine which team has the higher likelihood
        %of winning based on the mean

        for k = 1:5;
            team1index(k) = [find(strcmp(names,team1(k)))];
            team2index(k) = [find(strcmp(names,team2(k)))];

            team1pickrate(k) = [charpickrate((team1index(k)))];
            team2pickrate(k) = [charpickrate((team2index(k)))];

            team1winrate(k) = [charwinrate((team1index(k)))];
            team2winrate(k) = [charwinrate((team2index(k)))];
        end


    if (mean(team1winrate) > mean(team2winrate))
        t1wins(g) = (mean(team1winrate));
        t2wins(g) = 0;
    end
    
    if (mean(team1winrate) < mean(team2winrate))
        t1wins(g) = 0;
        t2wins(g) = (mean(team2winrate));
    end
    
end

figure(5)
subplot(2,2,1)
hold on
scatter(1:games+1,t1wins,'b.')
title('Team1 Wins')
xlabel('Simulations')
ylabel('Likelihood of Success, Displayed On Win')

subplot(2,2,2)
hold on
plot(1:games+1,t1wins,'b--')
title('Team1 Wins')
xlabel('Simulations')
ylabel('Likelihood of Success, Displayed On Win')

subplot(2,2,3)
hold on
scatter(1:games+1,t2wins,'r.')
title('Team2 Wins')
xlabel('Simulations')
ylabel('Likelihood of Success, Displayed On Win')

subplot(2,2,4)
hold on
plot(1:games+1,t2wins,'r--')
title('Team2 Wins')
xlabel('Simulations')
ylabel('Likelihood of Success, Displayed On Win')
