function LPData=LPSavefigfun(LPData)
% Save the struct. LPData as a .mat-file and current figure as a .fig-file.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% The Name of both files will be identical, and any name that MATLAB can
% save. The files can be differentiated by their file-suffix .mat/.fig.
% If the figure has a title, it is provided in a inputdlg-window as a
% suggestion name, which would have to be stripped of any character that
% MATLAB cannot save as a filename-character.
% If the figure has no title, an empty inputdlg-window is opened and one
% can proceed to enter a name for figure and structure. The saved figure is 
% still editable afterwards.
% Syntax:  
%     LPData=LPSavefigfun(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields
%   
% Inputs (optional):
%   -
% 
% Outputs:
%   - saved Figure.fig and LPstructure.mat-file with custom, but identical
%     name.
% Example: 
% %   -
% 
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - LPImpDatfun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
% See also: none
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
% Created: 14-Jun-2020 ; Last revision: 07-Dec-2020 

% ------------- BEGIN CODE --------------
%% Update LegendEntriesField
LPData.CurrentLegendEntries=get(gca,'legend').String;

CurrentFigureTitle=get(gca,'title');
if isempty(CurrentFigureTitle.String)
    switch questdlg('Save Figure and current Data?','Save figure/data','Yes','No','No')
        case 'Yes'
            defaultanswer=" ";
            options.Interpreter='tex';
            Savestring=inputdlg('Please specify file names for figure&data','Input name',1,defaultanswer,options);
            LPData.Savestring=Savestring;
            save(char(Savestring),"LPData");
            savefig(char(Savestring));
            disp('Data and Figure have been saved under the figures'' title-name:')
            disp(Savestring)
        case 'No'
    end
else
    Savestring=CurrentFigureTitle.String; %#ok<*NASGU>
    if exist('Savestring','var')
        switch questdlg('Save Figure and current Data?','Save figure/data','Yes','No','No')
            case 'Yes'
                CurrentFigureTitle=get(gca,'title');
                defaultanswer=CurrentFigureTitle.String;
                options.Interpreter='tex';
                Savestring=inputdlg('Please specify file names for figure&data','Input name',1,{defaultanswer},options);
                LPData.Savestring=Savestring;
                save(char(Savestring),"LPData");
                savefig(char(Savestring));
                disp('Data and Figure have been saved under the figures'' title-name:')
                disp(Savestring)
            case 'No'
        end
    else
        error('Error occured. \nTitle does not exist. Please define title before attempting to save figure.[Savefigfun]','class(n)')
    end
end
end


% ------------- END OF CODE -------------
