function LPData=LPErrorbarfun2(LPData)
% Plot symmetrical Errorbars for LazyPlot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPErrorbarfun2 plots the errorbars (and data-points) for normal line
% plots, and uses the colors and markers specified by
% LPColorfun2 and LPCustommarkertypefun2 to do so. 
%
% In a few other cases, the plotting of data points might be covered by
% LPErrorbarfun2 as well
%
% Syntax:  
%     LPData=LPErrorbarfun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
%            - matx
%            - maty
%            - materrorx
%            - materrory
%            - colors
%            - markertype
% 
% Inputs (optional):
%   -
% 
% Outputs:
%   - plotted errorbars at positions provided by matx&maty,
%     with symmetrical x errorbars and symmetrical y errorbars, in colors
%     "colors"
%   - handles to "ErrorBar"-objects 
%   - plotted data points with markertype "markertype", in colors "colors"
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
% 
% See also: LPColorfun2, LPCustommarkertypefun2, LPPlotfun2
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
% Created: 15-May-2020 ; Last revision: 15-Aug-2020 

% ------------- BEGIN CODE --------------
hold on
for k=1:1:LPData.NumRows
    LPData.Errorbar(k)=errorbar(LPData.matx(k,:),LPData.maty(k,:),LPData.materrory(k,:),LPData.materrory(k,:),LPData.materrorx(k,:),LPData.materrorx(k,:),LPData.markertype(k),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
end
end


% ------------- END OF CODE -------------
