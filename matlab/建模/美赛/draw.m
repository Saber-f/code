clear
load W


%2009可再生能源REPRB
d(:,1) = W(50,:,replace({'PATCB'}));%./W(50,:,replace({'TEPRB'})).*100;
d(:,2) = W(50,:,replace({'CLTCB'}));%./W(50,:,replace({'TETCB'})).*100;
% d(:,3) = W(50,:,replace({'GETCB'}));%./W(50,:,replace({'TETCB'})).*100;
% d(:,4) = W(50,:,replace({'WYTCB'}));%./W(50,:,replace({'TETCB'})).*100;




S(1) = {'Arizoxa'};
S(2) = {'Califorxia'};
S(3) = {'New Mexico'};
S(4) = {'Texas'};
c = categorical(S);
xlabel('Year')
bar(c,d);
ylabel('Billion Btu')
% ylabel('%')
%title('2009 Renewable energy total production and consumption.')
legend('PATCB','CLTCB')
box off