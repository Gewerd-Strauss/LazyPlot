function LPFigurefun
% Sets Axis limits, axes labels, Title, Position of legend, gridsetting
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPFigurefun will query in order:
%
% axis limits:
% Via an inputdlg, you are asked to input 4 numbers, without square or
% normal brackets. Either the decimal point (.) or comma (,) can be used to
% separate the decimals.
% I.e the input '1 4,3 2 5' (without the apostrophes) will result in the
% x axis limits being set to 1 and 4.3, and
% y axis limits being set to 2 and 5 respectively.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Unlike LPFigurefun2, LPFigurefun will !!!NOT!!! autoscale (or rather, not
% keep the autoscaled) axis limits set by LazyPlot previously, if one does 
% not input any values into the axis definition inputdlg. Instead, it will
% reset the figure to the axes limits [-500 5000 -500 5000]. This function
% is far imperior to LPFigurefun2. However, it can be used for any figure,
% regardless of how it was created.
%
%
% Title, x- and ylabels, the location of the legend and the grid can be set
% as well.
% Any of the default legend location settings is available.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%     LPFigurefun
% 
% Inputs (vital):
%   -
%   
% Inputs (optional):
%   -
%   
% Outputs:
%   - adjusted figure axes, title, xlabel, ylabel, legend at chosen
%     location, grid setting
%   
% Example: 
%   -
%   
% Other m-files required: none
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
% 
% See also: LPFigurefun2, legend, axis, xlabel, ylabel, grid
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
answer= inputdlg('What are the axis limits?');
if size(answer)==[0,0] %#ok<*BDSCA>
    error('Error occured. \nInputs can only be 4 or 6 numbers, \nwith elements 2,4 and 6 being bigger than 1,3 and 5 respectively.','class(n)') %#ok<*CTPCT>
end
answer=strrep(answer,',','.');
LPAxis_vector=str2num(answer{1}); %#ok<*ST2NM>
if isempty(LPAxis_vector)                                                 % Fallback for cancelled input
    LPAxis_vector=[-500 5000 -500 5000];
end
%% Check for sufficient inputs
if numel(LPAxis_vector)==1 || numel(LPAxis_vector)==2 || numel(LPAxis_vector)==3 || numel(LPAxis_vector)==5 || numel(LPAxis_vector)>7 %Check for wrong number of inputs
    error('Error occured. \nPlease input 4 or 6 numbers, \nwith elements 2,4 and 6 being bigger than 1,3 and 5 respectively.[LPFigurefun]','class(n)')
end
if LPAxis_vector(1,2)<LPAxis_vector(1,1)
    error('Error occured. \nElement in position 2 must be bigger than element in position 1.[LPFigurefun]','class(n)')
elseif LPAxis_vector(1,2)==LPAxis_vector(1,1)
    error('Error occured. \nElement in position 2 must be bigger than element in position 1.[LPFigurefun]','class(n)')
elseif LPAxis_vector(1,4)<LPAxis_vector(1,3)
    error('Error occured. \nElement in position 4 must be bigger than element in position 3.[LPFigurefun]','class(n)')
elseif LPAxis_vector(1,4)==LPAxis_vector(1,3)
    error('Error occured. \nElement in position 4 must be bigger than element in position 3.[LPFigurefun]','class(n)')
elseif size(LPAxis_vector)==[1 6]                                         % only trigger if we have 3 dimensional input
    if LPAxis_vector(1,6)<LPAxis_vector(1,5)
        error('Error occured. \nElement in position 6 must be bigger than element in position 5.[LPFigurefun]','class(n)')
    elseif LPAxis_vector(1,6)==LPAxis_vector(1,5)
        error('Error occured. \nElement in position 6 must be bigger than element in position 5.[LPFigurefun]','class(n)')
    end
end
axis(LPAxis_vector);
%% Set title, x-/y-label, legendlocation and grid-setting
title(inputdlg('What is the title?'))
xlabel(inputdlg('What is the x-label?'))
ylabel(inputdlg('What is the y-label?'))
LPLocationlist={'best','northeast','north','east','southeast','south','southwest','west','northwest','northoutside','northeastoutside','eastoutside','southeastoutside','southoutside','southwestoutside','westoutside','northwestoutside','bestoutside'};
switch listdlg('ListString',LPLocationlist,'PromptString','Select Legend location','Name','Loation-Selection','SelectionMode','Single','ListSize',[160 130])
    case 1
        legend('Location','best')
    case 2
        legend('Location','northeast')
    case 3
        legend('Location','north')
    case 4
        legend('Location','east')
    case 5
        legend('Location','southeast')
    case 6
        legend('Location','south')
    case 7
        legend('Location','southwest')
    case 8
        legend('Location','west')
    case 9
        legend('Location','northwest')
    case 10
        legend('Location','northoutside')
    case 11
        legend('Location','northeastoutside')
    case 12
        legend('Location','eastoutside')
    case 13
        legend('Location','southeastoutside')
    case 14
        legend('Location','southoutside')
    case 15
        legend('Location','southwestoutside')
    case 16
        legend('Location','westoutside')
    case 17
        legend('Location','northwestoutside')
    case 18
        legend('Location','bestoutside')
    otherwise
        legend('Location','best')
end
switch questdlg('Grid on or off?','Do you have grit?','On major only','On minor too','Off','Off')
    case 'On major only'
        grid on
    case 'On minor too'
        grid minor
    case 'Off'
        grid off
    otherwise                                                             % Fallback if user cancelled input.
        grid off
end
disp('LPFigurefun has finished running.')
end


% ------------- END OF CODE -------------
