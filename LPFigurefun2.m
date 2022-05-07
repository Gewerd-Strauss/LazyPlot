function LPData = LPFigurefun2(LPData)
% Sets Axis limits, axes labels, Title, Position of legend, gridsetting
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPFigurefun2 will query in order:
%
% axis limits:
% Via an inputdlg, you are asked to input 4 numbers, without square or
% normal brackets. Either the decimal point (.) or comma (,) can be used to
% separate the decimals.
% I.e the input '1 4,3 2 5' (without the apostrophes) will result in the
% x axis limits being set to 1 and 4.3, and
% y axis limits being set to 2 and 5 respectively.
%
%
% Additionally, inputting either of the following keywords
% "LPquit","lpquit","LPQUIT","LPQuit"
% results in an induced Force Quit if one recognises something went wrong
% already.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Unlike LPFigurefun, LPFigurefun2 will autoscale (or rather, keep the
% autoscaled) axis limits set by LazyPlot previously, if one does not input
% any values into the axis definition inputdlg. This is the generally
% recommended method.
%
%
% Title, x- and ylabels, the location of the legend and the grid can be set
% as well.
% Any of the default legend location settings is available.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:
%     LPData = LPFigurefun2(LPData)
%
% Inputs (vital):
%   LPData - structure with fields:
%            - xlimits
%            - ylimits
%
% Inputs (optional):
%   -
%
% Outputs:
%   LPData - structure with fields:
%            - Locationstring
%
% Example:
%   -
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - LPImpDatfun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
%
% See also: LPFigurefun, legend, axis, xlabel, ylabel, grid
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
% Created: 15-May-2020 ; Last revision: 07-Dec-2020

% ------------- BEGIN CODE --------------
LPData.Axisvector=([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)]); % merge all limits into a single vector.
axis(LPData.Axisvector);
answer= inputdlg('What are the axis limits?');
if size(answer)==[0,0] %#ok<*BDSCA>
else                                                                      % User has defined axis himself
    answer=strrep(answer,',','.');
    LPData.Axisvector=str2num(answer{1}); %#ok<*ST2NM>
end
if isempty(LPData.Axisvector)                                             % Fallback for cancelled input
    LPData.Axisvector=([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)]); % merge all limits into a single vector.
end
%% Check for break commands
if contains(answer,["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK"])
    error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\n/quit/Quit/QUIT/break/BREAK or a similar expression.[LPFigurefun]','class(n)')
end
%% Check for sufficient inputs
if numel(LPData.Axisvector)==1 || numel(LPData.Axisvector)==2 || numel(LPData.Axisvector)==3 || numel(LPData.Axisvector)==5 || numel(LPData.Axisvector)>7 %Check for wrong number of inputs
    error('Error occured. \nPlease input 4 or 6 numbers, \nwith elements 2,4 and 6 being bigger than 1,3 and 5 respectively.[LPFigurefun]','class(n)')
end
if LPData.Axisvector(1,2)<LPData.Axisvector(1,1)
    error('Error occured. \nElement in position 2 must be bigger than element in position 1.[LPFigurefun]','class(n)') %#ok<*CTPCT>
elseif LPData.Axisvector(1,2)==LPData.Axisvector(1,1)
    error('Error occured. \nElement in position 2 must be bigger than element in position 1.[LPFigurefun]','class(n)')
elseif LPData.Axisvector(1,4)<LPData.Axisvector(1,3)
    error('Error occured. \nElement in position 4 must be bigger than element in position 3.[LPFigurefun]','class(n)')
elseif LPData.Axisvector(1,4)==LPData.Axisvector(1,3)
    error('Error occured. \nElement in position 4 must be bigger than element in position 3.[LPFigurefun]','class(n)')
elseif size(LPData.Axisvector,2)==6                                       % only trigger if we have 3 dimensional input
    if LPData.Axisvector(1,6)<LPData.Axisvector(1,5)
        error('Error occured. \nElement in position 6 must be bigger than element in position 5.[LPFigurefun]','class(n)')
    elseif LPData.Axisvector(1,6)==LPData.Axisvector(1,5)
        error('Error occured. \nElement in position 6 must be bigger than element in position 5.[LPFigurefun]','class(n)')
    end
end
axis(LPData.Axisvector);
%% Set title, x-/y-label
prompt={'What is the title?','What is the x-label?','What is the y-label?'};
dlgtitle='  ';
dims=[1 35];
defans=[{char(get(gca,'title').String)},{char(get(gca,'XLabel').String)},{char(get(gca,'YLabel').String)}];
Title_Labels=inputdlg(prompt,dlgtitle,dims,defans);
if contains(Title_Labels{1},["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK"])
    error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\n/quit/Quit/QUIT/break/BREAK or a similar expression.[LPFigurefun]','class(n)')
end
if contains(Title_Labels{2},["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK"])
    error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\n/quit/Quit/QUIT/break/BREAK or a similar expression.[LPFigurefun]','class(n)')
end
if contains(Title_Labels{3},["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK"])
    error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\n/quit/Quit/QUIT/break/BREAK or a similar expression.[LPFigurefun]','class(n)')
end
title(Title_Labels{1});
xlabel(Title_Labels{2});
ylabel(Title_Labels{3});
%% Set legendlocation and grid-setting
LPLocationlist={'best','northeast','north','east','southeast','south','southwest','west','northwest','northoutside','northeastoutside','eastoutside','southeastoutside','southoutside','southwestoutside','westoutside','northwestoutside','bestoutside'};
LPData.Locationstring=LPLocationlist{listdlg('ListString',LPLocationlist,'PromptString','Select Legend location','Name','Loation-Selection','SelectionMode','Single','ListSize',[160 130])};
if isempty(LPData.Locationstring)                                         % Fallback if user cancels input
    LPData.Locationstring='best';
end
switch questdlg('Grid on or off?','Do you have grit?','On major','On minor','Off','Off')
    case 'On major'
        grid off
        grid on
    case 'On minor'
        grid off
        grid minor
    case 'Off'
        grid off
    otherwise                                                             % Fallback if user cancelled input.
        grid off
end
%% Legendentries
% Query Number of Legendentries
legend off                                                                % Necessary to toggle like this to create empty cells for all objects
legend                                                                    % in figure. This is needed later on when inputting correct number of
LPData.NumLegendRows=numel(get(gca,'legend').String);                     % legend entries // this should always have the updated number of entries


% Create LegendEntries
if isfield(LPData,'legendentries')
    if isfield(LPData,'LegendResetSwitch')
        LPData=rmfield(LPData,'LegendResetSwitch');
    end
    legend(LPData.legendentries)
    legend('Location',LPData.Locationstring)
    while ~isfield(LPData,'LegendResetSwitch') || isempty(LPData.LegendResetSwitch) % Don't allow accidental closure of input window of any kind.
        LPData.LegendResetSwitch=questdlg('Do you want new legend entries?','New Legend?','Yes','No','No');
    end
    switch LPData.LegendResetSwitch
        case 'Yes'                                                        % legend already exists, but is to be reset
            legend off                                                    % reinitialise legend, necessary in multiple-run scenario
            legend
            LPData.CurrentLegendEntries=get(gca,'legend').String;         % poll current entries from the figure directly.
            for k=1:1:numel(get(gca,'legend').String)
                LPData.legendentries(k)=inputdlg('What is the legendentry?','Legendentries',1,LPData.CurrentLegendEntries(1,k));
            end
        case 'No'                                                         % legend already exists, but is to be kept
            if numel(LPData.legendentries) == LPData.NumLegendRows
            else                                                          % Safety, if new entries need to be populated, this triggers automatically
                legend off
                legend
                LPData.CurrentLegendEntries=get(gca,'legend').String;
                for k=1:1:numel(get(gca,'legend').String)
                    LPData.legendentries(k)=inputdlg('What is the legendentry?','Legendentries',1,LPData.CurrentLegendEntries(1,k));
                end
            end
    end
else                                                                      % legendentries don't exist
    LPData.CurrentLegendEntries=get(gca,'legend').String;
    for k=1:1:numel(get(gca,'legend').String)
        LPData.legendentries(k)=inputdlg('What is the legendentry?','Legendentries',1,LPData.CurrentLegendEntries(1,k));
    end
end
legend off
legend(LPData.legendentries);
legend('Location',LPData.Locationstring)
end


% ------------- END OF CODE -------------
