%% Train Regression Ensemble
% Use a trained, boosted regression tree ensemble to predict the fuel
% economy of a car. Choose the number of cylinders, volume displaced by
% the cylinders, horsepower, and weight as predictors.  Then, train an
% ensemble using fewer predictors and compare its in-sample predictive
% accuracy against the first ensemble.
%%
% Load the |carsmall| data set.  Store the training data in a table.
load carsmall
Tbl = table(Cylinders,Displacement,Horsepower,Weight,MPG);
%%
% Specify a regression tree template that uses surrogate splits to impove
% predictive accuracy in the presence of |NaN| values.
t = templateTree('Surrogate','On');
%%
% Train the regression tree ensemble using LSBoost and 100 learning cycles.
Mdl1 = fitensemble(Tbl,'MPG','LSBoost',100,t);
%%
% |Mdl1| is a trained |RegressionEnsemble| regression ensemble.
% Because |MPG| is a variable in the MATLAB(R) Workspace, you can obtain the same result by entering 
%
% |Mdl1 = fitensemble(Tbl,MPG,'LSBoost',100,t);|
%
%%
% Use the trained regression ensemble to predict the fuel economy for
% a four-cylinder car with a 200-cubic inch displacement, 150 horsepower,
% and weighing 3000 lbs.
predMPG = predict(Mdl1,[4 200 150 3000])
%%
% The average fuel economy of a car with these specifications is 21.78 mpg.
%%
% Train a new ensemble using all predictors in |Tbl| except |Displacement|.
formula = 'MPG ~ Cylinders + Horsepower + Weight';
Mdl2 = fitensemble(Tbl,formula,'LSBoost',100,t);
%%
% Compare the resubstitution MSEs between |Mdl1| and |Mdl2|.
mse1 = resubLoss(Mdl1)
mse2 = resubLoss(Mdl2)
%%
% The in-sample MSE for the ensemble that trains on all predictors is
% lower.