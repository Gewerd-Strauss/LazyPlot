function LPData = LPPlottypefun2(LPData)
% Sets the plottype for LazyPlot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPPlottypefun2 sets the plottypeindx necessary in LPplotfun2 to decide which
% type of plot to create.
% The Order from 1 - 10 is as follows:
% 1 Line Plot
% 2 Bar Plot
% 3 Stairstep Plot
% Stem Plot
% Scatter Plot
% Polar Plot (not working)
% Loglog Plot
% Semilogx Plot
% Semilogy Plot
% Data vs Data Plot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%   LPData = LPPlottypefun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
% 
% Inputs (optional):
%   -
% 
% Outputs:
%   LPData - structure with fields:
%            - plottypeindx
% 
% Example: 
%   -
% 
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - LPImpDatfun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
% See also: LPPlotfun2, LPTreePrompter
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% For detailed documentation on how to use LazyPlot, open the
% GettingStarted-file of the LazyPlot Toolbox
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Author: Claudius S. Appel
% https://de.mathworks.com/matlabcentral/profile/authors/16470428-claudius-simon-appel
% Student at HSRW Kleve, Germany
% email: ~
% I won't react to emails, if you have problems with the toolbox or any 
% other function submitted by me, take a look at code and then post a
% question in the comment section of the FEX-page.
% I cannot confirm that I will answer immediately or at all, but I will try.
% For those who know me personally, feel free to contact me if problems
% arise.
% Created: 15-May-2020 ; Last revision: 11-Aug-2020 

% ------------- BEGIN CODE --------------
LPplotlist={'Line Plot','Bar Plot','Stairstep Plot','Stem Plot','Scatter Plot','Polar Plot (not working)','Loglog Plot','SemilogX Plot','SemilogY Plot','Data vs Data'};
typeindices=1:10;
LPData.plottypeindx=typeindices(listdlg('ListString',LPplotlist,'PromptString','Select Plottype','Name','Plottype','SelectionMode','single','ListSize',[160 145]));
end


% ------------- END OF CODE --------------
