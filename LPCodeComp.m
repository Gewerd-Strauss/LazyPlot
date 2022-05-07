%% Normal Code: This is how you'd plot the example normally. It works.

% wd=[0.25 1.00 2.25 4.00];
% uwd=[0.001 0.001 0.001 0.001];
% J_1=[0.004482938641	0.006391417971 0.009277047706 0.01299910418];
% uJ_1=[0.0007472972927 0.0002425672566 0.000244447623 0.0001757093571];
% J_2=[0.005069407322 0.008369961302 0.01402633152 0.02162471742];
% uJ_2=[0.00009375195973 0.00004638236948 0.0005688667782	0.0007134557535];
% hold on;
% axis([0 4.5 0 0.03]);
% %This is the original code to plot it with for comparison
% %errorbars for f1,f2
% errorbar(wd,J_1,uJ_1,uJ_1,uwd,uwd,'or');
% errorbar(wd,J_2,uJ_2,uJ_2,uwd,uwd,'ob');
% f1 = fit (wd',J_1','poly1');
% f2 = fit (wd',J_2','poly1');
% plot (f1,'r');
% plot (f2,'b');
% hold off
%% Example 1: Normal Call
%clear variables
% It is HIGHLY recommended to predefine the matrices LPmatx and LPmaty (in
% case of errorbars also either or all of them) before calling LazyPlot.
% Regarding the LPQS-variable: It enables a shortened mode of LazyPlot
% which disables certain features/options in order to give you a quiReck
% preview of the actual figure you're plotting. Type "help LazyPlot" for
% more details on what is disabled.
% IMPORTANT: the mode stays active as long as LPQS exists. If you wish to
% return to the normal mode, delete LPQS from your variables.
% It is also recommended to take a look at the changelog.txt file, which
% will give you an overview over 
%ccc
wd=[0.25 1.00 2.25 4.00];
uwd=[0.001 0.001 0.001 0.001];  
J_1=[0.004482938641	0.006391417971 0.009277047706 0.01299910418];
uJ_1=[0.0007472972927 0.0002425672566 0.000244447623 0.0001757093571];
J_2=[0.005069407322 0.008369961302 0.01402633152 0.0216247172];
uJ_2=[0.00009375195973 0.00004638236948 0.0005688667782	0.0007134557535];
LPmatx=wd;
% Exclusive to the LPmatx-matrix: You can define only one vector of the matrix, given that it would be the same for all repeats.
% You can also define different x-vectors for one plot, given all matrix
% dimensions line up.

LPmaty=[J_1;J_2]; %#ok<*NASGU>
LPmaterrorx=[uwd;uwd];
%LPmaterrorx=[NaN NaN NaN NaN;NaN NaN NaN NaN];
%LPmaterrorx=[uwd;NaN NaN NaN NaN];
LPmaterrorx=[0.0007472972927 NaN 0.000244447623 0.0001757093571;uwd]; % If you zoom in on the second data point of the red line, you'll see that it only has one errorbar, due to the NaN.
LPmaterrory=[uJ_1;uJ_2];
clc
%clear LPQS
LPQS=1;
%%
clc
LazyPlot

%% Example 2: Using NaN to block out certain positions in vectors/matrices if said data is missing. 
% clear variables
% 
% wd=[0.25 1.00 2.25 4.00];
% uwd=[0.001 0.001 0.001 0.001];
% J_1=[0.004482938641	0.006391417971 0.009277047706 0.01299910418];
% uJ_1=[0.0007472972927 0.0002425672566 0.000244447623 0.0001757093571];
% J_2=[0.005069407322 0.008369961302 0.01402633152 0.0216247172];
% uJ_2=[0.00009375195973 0.00004638236948 0.0005688667782	0.0007134557535];
% LPmatx=[wd;0.25 1.00 2.25 NaN]; this would not work. NaN values can only
% be used for errorbars (LPmaterrorx,LPmaterrory)
% LPmaterrorx=[uwd;uwd];
% LPmaterrorx=[NaN NaN NaN NaN;NaN NaN NaN NaN]; % This on the other hand does work
% LPmaterrorx=[uwd;NaN NaN NaN NaN];
% LPmaterrorx=[0.0007472972927 NaN 0.000244447623 0.0001757093571;uwd]; % If you zoom in on the second data point of the red line, you'll see that it only has one errorbar, due to the NaN.
% LPmaty=[J_1;J_2];
% LPmaterrory=[uJ_1;uJ_2];
% clc
% LPQS=1
% LazyPlot
%% 
 clear variables
x=rand(4,5);
y1=rand(4,5);
%y2=rand(4,10);
%y3=rand(4,10);
%y4=rand(4,10);
LPmatx=x;
LPmaty=y1;
% LazyPlot
% %%
% x=rand(1,20);
% y1=rand(1,20);
% y2=rand(1,20);
% y3=rand(1,20);
% y4=rand(1,20);
% LPmatx=[x,x,x,x];
% LPmaty=[y1,y2,y3,y4];
% LPmaterrorx=LPmatx;
% LPQS=1;
% LazyPlot

%%
% Part of the LazyPlot-Toolbox by Claudius Appel.
% For more information, open the main script LazyPlot.