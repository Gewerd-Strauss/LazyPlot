function LPFinished
% A joke. Play Zero Escape: Virtue's Last Reward to maybe get it. 
% Also, the entire trilogy is great, if you're into such games. Great
% stories, although the missing budget in the third one is noticeable - it
% got funded by fan donations who wanted the third game to happen.
% Thank you Uchikoshi for the awesome Zero Escape Trilogy, as well as 
% "AI: The Somnium Files". Play that as well, hilarious game.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Most unnecessary function, mostly a joke and an opportunity to display a
% small joke maybe 0,005% of the users might possibly get. Aside from that, 
% it exists as a way to show people who don't look at their command window
% that LazyPlot has finished running. Can be simply deactivated in the
% mainfile in the section "Procedure has finished". Probably better so.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%     LPFinished
% 
% Inputs (vital):
%   -
%
% Inputs (optional):
%   -
%  
% Outputs:
%   -
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
% See also: LazyPlot, section "Procedure has finished", 
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
d = dialog('Position',[500 300 250 250],'Name','Finished');
uicontrol('Parent',d,...
    'Style','text',...
    'Position',[20 80 210 110],...
    'String','"Lettuce review what we''ve learned!"');
uicontrol('Parent',d,...
    'Position',[85 20 70 50],...
    'String','Close',...
    'Callback','delete(gcf)');
end


% ------------- END OF CODE -------------
