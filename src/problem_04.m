%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% What if labor costs for Wool Blazers were underestimated by $80? %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% David Kraemer and William Rebelsky %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%
% Legend: %
%%%%%%%%%%%

% TWS: Tailored Wool Slacks
% CAS: Cashmere Sweater
% SB:  Silk Blouse
% SC:  Silk Camisole
% TS:  Tailored Skirt
% 
% WB:  Wool Blazer
% VP:  Velvet Pants
% CS:  Cotton Sweater
% CM:  Cotton Miniskirt
% VS:  Velvet shirt
% BB:  Button-down Blouse
% 
% W:   Wool
% A:   Acetate
% CA:  Cashmere
% S:   Silk
% R:   Rayon
% V:   Velvet
% C:   Cotton

% Sunk costs
sunkcosts = 860000 + 3 * 1200000;
% Increased cost to produce Wool Blazers
cost = 80;

% Associated revenue and costs per item.
%                   TWS CAS  SB  SC  TS  WB         VP  CS CM  VS  BB
revenue_weights  = [300 450 180 120 270 320        350 130 75 200 120];
labor_weights    = [160 150 100  60 120 140 + cost 175  60 40 160  90];
material_weights = [9 * 3 + 1.5 * 2      ... % TWS
                    60 * 1.5             ... % CAS
                    13 * 1.5             ... %  SB
                    13 * 0.5             ... %  SC
                    2.25 * 2 + 1.5 * 1.5 ... %  TS
                    9 * 2.5 + 1.5 * 1.5  ... %  WB
                    12 * 3 + 1.5 * 2     ... %  VP
                    2.5 * 1.5            ... %  CS
                    2.5 * 0.5            ... %  CM
                    12 * 1.5             ... %  VS
                    2.25 * 1.5            ]; %  BB

% Net profit per item                
net_profit_weights = revenue_weights - labor_weights - material_weights;

%%%%%%%%%%%%%%%%%%%%%%%%%%
% Matrix of Coefficients %
%%%%%%%%%%%%%%%%%%%%%%%%%%

%   TWS, CAS,  SB,  SC,  TS,  WB,  VP,  CS,  CM,  VS,  BB;
A = [ 0,   0,   0,   0,   0,   0,   1,   0,   0,   0,   0; %5500  VP
      0,   0,   0,   0,   0,   0,   0,   0,   0,   1,   0; %6000  VS
      0,   1,   0,   0,   0,   0,   0,   0,   0,   0,   0; %4000  CAS
      0,   0,   1,   0,   0,   0,   0,   0,   0,   0,   0; %12000 SB
      0,   0,   0,   1,   0,   0,   0,   0,   0,   0,   0; %15000 SC
      0,   0,   0,   0,  -1,   0,   0,   0,   0,   0,   0; %-2800 TS
      0,   0,   0,   0,   0,  -1,   0,   0,   0,   0,   0; %-3000 WB
      0,   0,   0,   0,   0,   1,   0,   0,   0,   0,   0; %5000  WB
     -1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0; %-4200 TWS
      1,   0,   0,   0,   0,   0,   0,   0,   0,   0,   0; %7000  TWS
      3,   0,   0,   0,   0, 2.5,   0,   0,   0,   0,   0; %45000 wool
      2,   0,   0,   0, 1.5, 1.5,   2,   0,   0,   0,   0; %28000 acetate
      0, 1.5,   0,   0,   0,   0,   0,   0,   0,   0,   0; %9000  cashmere
      0,   0, 1.5, 0.5,   0,   0,   0,   0,   0,   0,   0; %18000 silk
      0,   0,   0,   0,   2,   0,   0,   0,   0,   0, 1.5; %30000 rayon
      0,   0,   0,   0,   0,   0,   3,   0,   0, 1.5,   0; %20000 velvet
      0,   0,   0,   0,   0,   0,   0, 1.5, 0.5,   0,   0; %30000 cotton
      0,   0,   1,  -1,   0,   0,   0,   0,   0,   0,   0; %0     scrap
      0,   0,   0,   0,   0,   0,   0,   1,  -1,   0,   0; %0     scrap
 ];

%%%%%%%%%%%%%%%%%%%%%%%%%
% Vector of Constraints %
%%%%%%%%%%%%%%%%%%%%%%%%%
constraints = [5500, 6000,  4000, 12000, 15000, -2800, -3000,  5000, -4200, ...
               7000, 45000, 28000,  9000, 18000, 30000, 20000, 30000, 0, 0];

% lower bounds are 0, upper bounds are defined in the constraints.          
lower_bounds = zeros(1,length(net_profit_weights));
upper_bounds = [];

% The solution
bundle  = linprog(-net_profit_weights, A, constraints, ...
                  [], [], lower_bounds, upper_bounds, []);

% The solution is not an integer, so we floor it to ensure that the
% constraints are met              
bundle = floor(bundle);
% We add this vector since it is still in the solution space
x=[0;1;1;1;0;0;0;0;1;1;1];
bundle=bundle+x;

% We check to make sure that all the constraints hold
result = [constraints; (A * bundle).'];

assert(all(result(1,:) >= result(2,:)))

% If they do we calculate the net profit
profit = dot(net_profit_weights, bundle) - sunkcosts;

bundle_label = {'TWS'; 'CAS'; 'SB';  'SC';  'TS';  'WB';  'VP';  'CS';  'CM';  'VS';  'BB'};

% Return the production line and the net profit
for i = 1:length(bundle_label)
   fprintf('%s:\t%.0f\n', bundle_label{i}, bundle(i)); 
end
fprintf('Profit:\t$%.2f\n',profit);