%% file import
full = csvread('dota2Full.csv');
[~,txt,~] = xlsread('dota2Full.xls','','A2:Dk2');

%% variable creation
charpicks = full(:,5:end);
winvect = full(:,1);
names = txt(:,5:end);

%The for-loop checks if a win matches up with the selected character, so if
%the left team, -1, won, and if the charater was selected for that team, it
%counted that towards the total number of wins that character participated
%in and was stored in "charwins"
for j = 1:111
    for i = 1:length(charpicks)
        if charpicks(i,j) == winvect(i)
            charwins(i,j) = abs(winvect(i));
        end
    end
end

%% This is Stddev, Var, Mean data calculation

%Given the dataset, which has only whether or not the character was
%selected, and for which team, this is used to determine the average time
%this character was picked out of the total number of games
charpickcount = sum(abs(charpicks));
charpickrate  = mean(abs(charpicks));
%Take the total number of wins collected by the for-loop for each%character, and divide that by the total number of times that character was
%chosen, thus giving us a win-rate for that character
charwincount  = sum(charwins);
charwinrate   = (charwincount./charpickcount);

%These are our primary estimators, winrate and pickrate, which we can
%calculate the variance and determine if the estimators are biased in
%anyway
varcpr = var(charpicks);
varcwr = var(charwins);
stddevcpr = std(charpickrate);
stddevcwr = std(charwinrate);

pdcpr = makedist('normal','mu',mean(charpickrate),'sigma',stddevcpr);
pdfcpr = pdf(pdcpr,charpickrate);
pdcwr = makedist('normal','mu',mean(charwinrate),'sigma',stddevcwr);
pdfcwr = pdf(pdcwr,charwinrate);

%% graphing the PDF and CDF of charwinrate and charpickrate
figure(1)
subplot(2,1,1)
hold on
title('Character Pick Rate Distribution')
errorbar((charpickrate),(pdfcpr),varcpr,'vertical','c.')
scatter(charpickrate,pdfcpr,'b')
scatter(mean(charpickrate),max(pdfcpr),'r','filled')
xlabel('Character Pick Rate')
ylabel('F(x)')

vline(mean(charpickrate),'r--')
vline((mean(charpickrate)-stddevcpr),'g')
vline((mean(charpickrate)+stddevcpr),'g')
vline((mean(charpickrate)+ 2*stddevcpr),'g')
axis([0 max(charpickrate)+.1 0 max(pdfcpr)+.5])

subplot(2,1,2)
hold on
title('Character Win Rate Distribution')
errorbar((charwinrate),(pdfcwr),varcwr,'vertical','c.')
scatter(charwinrate,pdfcwr,'b')
scatter(mean(charwinrate),max(pdfcwr),'r','filled')
vline(mean(charwinrate),'r--')
vline((mean(charwinrate)-stddevcwr),'g')
vline((mean(charwinrate)+stddevcwr),'g')
vline((mean(charwinrate)+ 2*stddevcwr),'g')
vline((mean(charwinrate)- 2*stddevcwr),'g')
xlabel('Character Win Rate')
ylabel('F(x)')

%% ECDF & FFT Examination
%the following examination is to see if there's any strange signals or
%occurrences that pop out when looking at the data, as well as pulling any
%information out of the CDF of the character selection and character
%winrate data.

%ideally, all the FFTs should look like noise, thus implying that
%characters are equally picked, and equally likely to win

figure(2)

subplot(2,1,1)
hold on
title('CDF of Pickrate and Winrate')
ecdf(charpickrate)
ecdf(charwinrate)
legend('Pickrate','Winrate')

subplot(2,1,2)
hold on
title('FFT of Picks and Wins')

plot([1:111],fft(abs((charpickcount))),'b.-');
plot([1:111],fft(abs((charwincount))),'r.-');
legend('Pick Freq','Win Freq')



%% Now we're going to narrow our focus on to one specific character:

%This determine what the appropriate estimator for the chance of being
%picked, as well as the chance for winning the game, for the simulation

%the character we're going to analyze will be Skeleton King, because he's
%my personal favorite. He is indexed at #41 in the dataset:
skpicks = abs(charpicks(:,41));
skwins  = charwins(:,41);

sktotalpicks = charpickcount(41);
sktotalwins  = charwincount(41);
skpickrate = charpickrate(41);
skwinrate  = charwinrate(41);

skpickvar = var(skpicks);
skwinvar  = var(skwins);
skstddevpick = std(skpicks);
skstddevwin  = std(skwins);

%Skel. King pickrate prob. dist.
skprpd = makedist('normal','mu',mean(skpicks),'sigma',skstddevpick);
%Skel. King prob. density func. for pickrate
skpdfpr = pdf(skprpd,skpickrate);

%see above for variable naming convention:
skwrpd = makedist('normal','mu',mean(skwins),'sigma',skstddevwin);
skpdfwr = pdf(skwrpd,skwinrate);

% This will plot all of our Skeleton King data we calculated
figure(3)
subplot(2,1,1)
hold on
title('SK Pick Rate Distribution')
errorbar((skpickrate),(skpdfpr),skpickvar,'vertical','c.')
scatter(skpickrate,skpdfpr,'b')
scatter((skpickrate),max(skpdfpr),'r','filled')

vline((skpickrate),'r--')
vline(((skpickrate)-skstddevpick),'g')
vline(((skpickrate)+skstddevpick),'g')
vline(((skpickrate)+ 2*skstddevpick),'g')

subplot(2,1,2)
hold on
title('SK Win Rate Distribution')
errorbar((skwinrate),(skpdfwr),skwinvar,'vertical','c.')
scatter(skwinrate,skpdfwr,'b')
scatter((skwinrate),max(skpdfwr),'r','filled')
vline((skwinrate),'r--')
vline(((skwinrate)-skstddevwin),'g')
vline(((skwinrate)+skstddevwin),'g')
vline(((skwinrate)+ 2*skstddevwin),'g')
vline(((skwinrate)- 2*skstddevwin),'g')

%% A For-Loop for each character

%this will generate the data we found for Skeleton King, but cycle through
%for each character, and setup an array with all the appropriate
%information, as well as plot it to find the appropriate estimator for that
%specific characters pickrate and winrate

for m = 1:111;
    big_array(m,:) = [abs(charpicks(:,m));...
        charwins(:,m);...
        charpickcount(m);...
        charwincount(m);...
        charpickrate(m);...
        charwinrate(m);];
    
        pickrateprobdist(m) = fitdist((abs(charpicks(:,m))),'Normal');
        winrateprobdist(m) = fitdist(((charwins(:,m))),'Normal');
end


for n = 1:111;
    pickrateestimation(n) = pdf(pickrateprobdist(n),big_array(n,end-1));
    winrateestimation(n) = pdf(winrateprobdist(n),big_array(n,end));  
end


%%
figure(4)
hold on

subplot(2,2,1)
hold on
title('Character Pick Rate Distribution')
plot(big_array(:,end-1),pickrateestimation,'bo')
scatter(skpickrate,skpdfpr,'g','filled')

subplot(2,2,2)
title('Character PickCount vs WinCount Distribution')
% scatter(charpickcount,charwincount,'c')
histogram(pickrateestimation)

subplot(2,2,3)
hold on
title('Character Win Rate Distribution')
scatter(big_array(:,end),winrateestimation,'ro')
% errorbar(big_array(:,end),winrateestimation,var(big_array(:,end),0,2),'c')
scatter(skwinrate,skpdfwr,'g','filled')

subplot(2,2,4)
title('Character PickRate vs WinRate Distribution')
% scatter(pickrateestimation,winrateestimation,'c')
histogram(winrateestimation)
