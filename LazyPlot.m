%% LazyPlot 
% Extensive toolbox for fitting & plotting data.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LazyPlot allows plotting any number of data sets (given they are of equal
% total size) in one call into a single figure. No subplots possible.
% If wanted, color and markerstyle can be changed during call.
% Errorbars are plotted symmetrically in all directions, if the
% correspoding error vectors are existant.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% List of LazyPlot-functions, scripts & files
%   Changelog.txt
%   LazyPlot.m
%       LPColorfun2.m
%       LPCustommarkertypefun2.m
%       LPErrorbarfun2.m
%       LPFigurefun.m
%       LPFigurefun2.m
%       LPFinished.m
%       LPFitfun2.m
%       LPFittypeindxtable.mat
%       LPImpDatfun.m
%       LPPlotfun2.m
%       LPPlottypefun2.m
%       LPSavefigfun2.m
%       LPTreePrompter.m
%   LPCodeComp.m
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:
%    LazyPlot
%    (Optional Flag LPQS must be defined beforehand, cf. Inputs (optional)
%    (All Inputs must be defined beforehand.
%
% Inputs (vital):
%    LPmatx         - matrix, class double, must be defined for LazyPlot to
%                     work
%    LPmaty         - matrix, class double, must be defined for LazyPlot to
%                     work
%
% Inputs (optional):
%    LPmaterrorx    - matrix, class double, don't define if you wish no
%                     errorbar in the corresponding direction.
%    LPmaterrory    - matrix, class double, don't define if you wish no
%                     errorbar in the corresponding direction
%    LPQS           - 1x1 double, or 1x1 logical. If double, must be 1 or 0
%   *PseudoQScolors - 1x1 double, or 1x1 logical. If double, must be 1 or 0,
%                     used to induce LPQS-like behaviour in LPColorfun2
%   *PseudoQSmarkers- 1x1 double, or 1x1 logical. If double, must be 1 or 0,
%                     used to induce LPQS-like behaviour in
%                     LPCustommarkertypefun2
%  * LPQS trumps PseudoQS-behaviour and takes precedence
%
% Outputs:
%    LPData         - structure combining all inputs/outputs/settings set
%                     during the call to LazyPlot (can differ between QS- &
%                     normal mode.
%    Figure         - figure contains all plotted data in the chosen way.
%
%
% Example: (old experimental data from an experiment, I use it just for
%          quick creation of usable data.
%    wd=[0.25 1.00 2.25 4.00];
%    uwd=[0.001 0.001 0.001 0.001];
%    J_1=[0.004482938641	0.006391417971 0.009277047706 0.01299910418];
%    uJ_1=[0.0007472972927 0.0002425672566 0.000244447623 0.0001757093571];
%    J_2=[0.005069407322 0.008369961302 0.01402633152 0.0216247172];
%    uJ_2=[0.00009375195973 0.00004638236948 0.0005688667782	0.0007134557535];
%    LPmatx=[wd];
%    LPmaty=[J_1;J_2];
%    LPmaterrorx=[uwd;uwd];
%    LPQS=1
%    LazyPlot
%
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - (LPImpDatfun)*
%
% * Not an integral part of LazyPlot, but rather a helperfunction for
% data-import
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Functions required, with corresponding syntax:
% If no specific syntax given, they obey this syntax:
% LPData=[function_name](LPData)
%
%
% LPData=LPColorfun2(LPData)
% LPData=LPCustommarkertypefun2(LPData)
% LPData=LPErrrorbarfun2(LPData)
% LPData=LPFigurefun2(LPData)                                             **
% LPData=LPFitfun2(LPData)
% LPData=LPPlotfun2(LPData)
% LPData=LPPlottypefun2(LPData)
% LPData=LPSavefigfun(LPData)
% LPData=LPTreePrompter(LPData.fittypeindxtable.LPfittypeindxtable)
%
% LPFigurefun(no input/output, and not recommended)                       *
% LPFinished(no input/output, can be disabled
% in section "Procedure has finished")
%
% * no longer maintained, might be removed
% ** Updated version of LPFigurefun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: LPfittypeindxtable.mat, component of the toolbox
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% For detailed documentation on how to use LazyPlot, open the
% GettingStarted-file of the LazyPlot Toolbox
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Toolbox on Matlab File Exchange (FEX):
% https://de.mathworks.com/matlabcentral/fileexchange/75515-lazyplot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Credit for the LPTreePrompter goes to Guillaume
% https://de.mathworks.com/matlabcentral/answers/512221-function-overwrites-output-with-a-different-number#answer_421822
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Author: Claudius S. Appel
% https://de.mathworks.com/matlabcentral/profile/authors/16470428-claudius-simon-appel
% Student at HSRW Kleve, Germany
% email: ~
% I won't react to emails, if you have problems with the toolbox or any
% other function submitted by me, take a
% look at code and then post a question in the comment section of the FEX-page.
% I cannot confirm that I will answer immediately or at all, but I will try.
% For those who know me personally, feel free to contact me if problems
% arise.
% Created: 15-May-2020 ; Last revision: 05-Apr-2022
% Public version: 09-Dec-2020

% ------------- BEGIN CODE --------------
clc                                                                       % only clc in entire toolbox, so I won't miss any warnings.
fprintf('LazyPlot version: %s.\n','2.0.2.6')                              % Mostly for keeping track of multiple instances for author

%% Load the LPfittypeindxtable.mat-file 
warning('on')                                                             % mostly for myself to catch stuff I try that might be removed in the future
LPData.fittypeindxtable=load('LPfittypeindxtable.mat');

%% Importing existing data into the structure 
if exist('LPmatx','var')
    LPData.matx=LPmatx;
elseif exist('matx','var')
    LPData.matx=matx;
elseif exist('mx','var')
    LPData.matx=mx;
end
if exist('LPmaty','var')
    LPData.maty=LPmaty;
elseif exist('maty','var')
    LPData.maty=maty;
elseif exist('my','var')
    LPData.maty=my;
end
if exist('LPmaterrorx','var')
    LPData.materrorx=LPmaterrorx;
elseif exist('materrorx','var')
    LPData.materrorx=materrorx;
elseif exist('mex','var')
    LPData.materrorx=mex;
end
if exist('LPmaterrory','var')
    LPData.materrory=LPmaterrory;
elseif exist('materrory','var')
    LPData.materrory=materrory;
elseif exist('mey','var')
    LPData.materrory=mey;
end
if exist('LPweights','var')
    LPData.weightstrigger=true;
else
    LPData.weightstrigger=false;
end
if exist('LPQMP','var')
    LPData.PseudoQScolors=true;                                           % case for prededefining colors
    LPData.PseudoQSmarkers=true;                                          % case for prededefining markers
else
    LPData.PseudoQScolors=false;
    LPData.PseudoQSmarkers=false;
    if isfield(LPData,'plottypeindx')
        if LPData.plottypeindx==true
            LPData=rmfield(LPData,'plottypeindx');
        end
    end
end

%% New Verification method 
if exist('LPQS','Var')                                                    % This makes sure that LPQS is actually 0/false or 1/true.
    if LPQS==true
        LPData.QS=true;
    elseif LPQS==false
        LPData.QS=false;
    else
        error('Error occured.\nLPQS can only be "true"/1 or "false"/0.Please define LPQS as either of those.\nNote: It does not have to be a logical 1 or 0, defining it as a simple variable\nalso works. [LazyPlot]','class(n)')
    end
else                                                                      % If it doesn't exist, assume normal path
    LPData.QS=false;
end
if exist('LPCustomfittype','var')                                         % if a custom fittype has been defined, import it.
    LPData.Customfittype=LPCustomfittype;
end
% If certain data does not exist, the according error is thrown later on (next section)

%% Checking for existence of usable data matrices 
% Check for existance of vital matrices matx and maty
if isfield(LPData,'maty') && isfield(LPData,'matx')                       % both exist
    LPData.NumRows=size(LPData.maty,1);                                   % Necessary for loop-control, otherwise LazyPlot won't leave this section anyways
    if ~isequal(size(LPData.maty),size(LPData.matx))                      % they are of equal size
        for k=1:1:LPData.NumRows                                          % they are not of equal size
            LPData.matx(k,:)=LPData.matx(1,:); %#ok<*SAGROW>              % matx-matrix is rebuilt to the same y-size as the maty-matrix.
        end
        if ~(size(LPData.maty) == size(LPData.matx))                      % if matrices have same number of rows, but different rows of columns after the previous step --> user inputted invalid data.
            error('Error occured.\nVital Matrices LPmatx and LPmaty do not agree.\nCheck for different number of columns or rows.\n[LazyPlot]','class(n)')
        end
    end
elseif isfield(LPData,'maty') && ~isfield(LPData,'matx')                  % only y exists
    error('Error occured.\nVital Matrix LPmatx does not exist. Please define LPmatx before calling LazyPlot.\n[LazyPlot]','class(n)')
elseif isfield(LPData,'matx') && ~isfield(LPData,'maty')                  % only x exists
    error('Error occured.\nVital Matrix LPmaty does not exist. Please define LPmaty before calling LazyPlot.\n[LazyPlot]','class(n)')
else                                                                      % neither exist
    error('Error occured.\nBoth LPmatx and LPmaty do not exist. Please define LPmatx and LPmaty before calling LazyPlot.\n[LazyPlot]','class(n)')
end
% Check for correct class of matx, maty
if ~isa(LPData.matx,'double')                                             % LPmatx must be of class double
    error('Error occured. \nLPmatx is not of class "double", but of class %s.',class(LPData.matx))
end
if ~isa(LPData.maty,'double')                                             % LPmaty must be of class double
    error('Error occured. \nLPmaty is not of class "double", but of class %s.',class(LPData.maty))
end
%Check for NaN-values in vital matrices matx and maty
if sum(isnan(LPData.matx(:)))>0                                           % Check for NaNs in LPmatx
    error('Error occured.\nVital matrix LPmatx contains NaN-elements.\nPlease remove them.\nNaN may only be used in LPmaterrorx and LPmaterrory','class(n)')
end
if sum(isnan(LPData.maty(:)))>0                                       % Check for NaNs in LPmaty
    error('Error occured.\nVital matrix LPmaty contains NaN-elements.\nPlease remove them.\nNaN may only be used in LPmaterrorx and LPmaterrory','class(n)')
end
% Check for same dimensions of matx and maty
if ~isequal(size(LPData.matx),size(LPData.maty))
    error('Error occured. \nMatrix Dimensions of LPmatx and LPmaty do not agree.\nCheck for different number of columns.\n[LazyPlot]','class(n)')
end
% Check existance of errormatrices and create supplementary nan-matrices
if isfield(LPData,'materrorx') &&~ isfield(LPData,'materrory')            % materrorx exists --> create materrory
    LPData.materrory=nan(size(LPData.maty));
end
if isfield(LPData,'materrory') &&~ isfield(LPData,'materrorx')            % materrory exists --> create materrorx
    LPData.materrorx=nan(size(LPData.maty));
end
if isfield(LPData,'materrory') && isfield(LPData,'materrorx')             % both exist
    % Check materrory
    if ~isequal(size(LPData.materrory),size(LPData.maty))                 % sizes are not equal, therefore change
        if all(isnan(LPData.materrory))                                   % materrory is all nan, but wrong size --> we can just resize
            LPData.materrory=nan(size(LPData.maty));
        else                                                              % materrory is not all nan, and wrong size --> throw error, ask for
            error('Error occured.\nMatrix dimensions of LPmaterrory and LPmaty do not agree.\nCheck for different dimensions.\n[LazyPlot]','class(n)')
        end
    end
    % Check materrorx
    if ~isequal(size(LPData.materrorx),size(LPData.matx))                 % sizes are not equal, therefore change
        if all(isnan(LPData.materrorx))                                   % materrorx is all nan, but wrong size --> we can just resize
            LPData.materrorx=nan(size(LPData.maty));
        else                                                              % materrorx is not all nan, and wrong size --> throw error, ask for
            error('Error occured.\nMatrix dimensions of LPmaterrorx and LPmaty do not agree.\nCheck for different dimensions.\n[LazyPlot]','class(n)')
        end
    end
else                                                                      % neither of them exist, create supplementary error-matrices, assuming no error
    LPData.materrorx=nan(size(LPData.maty));
    LPData.materrory=nan(size(LPData.maty));
end
% Check for correct class of materrorx, materrory
if ~isa(LPData.materrorx,'double')                                        % LPmaterrorx must be of class double
    error('Error occured. \nLPmaterrorx is not of class "double", but of class %s.',class(LPData.materrorx))
end
if ~isa(LPData.materrory,'double')                                        % LPmaterrory must be of class double
    error('Error occured. \nLPmaterrory is not of class "double", but of class %s.',class(LPData.materrory))
end
% Check for correct dimensions of materrorx, materrory
if ~isequal(size(LPData.materrorx),size(LPData.maty))                     % error x, they don't agree
    error('Error occured. \nMatrix Dimensions of LPmaterrorx and LPmaty do not agree.\nCheck for different number of columns.\n[LazyPlot]','class(n)')
end
if ~isequal(size(LPData.materrory),size(LPData.maty))                     % error y, they don't agree
    error('Error occured. \nMatrix Dimensions of LPmaterrory and LPmaty do not agree.\nCheck for different number of columns.\n[LazyPlot]','class(n)')
end

%% Creating dynamic axis ranges, setting PreSketchFactor 
if ~sum(sum(~isnan(LPData.materrorx)))               % check if materrorx only contains NaNs
    LPData.xlimits=([min(min(LPData.matx)),max(max(LPData.matx))] + [-1,1]*0.05*range(LPData.matx,'all')); % change the .05 in front of the range command to change the overhang on each side.
else
    LPData.xlimits=([min(min(LPData.matx))-(abs(max(max(LPData.materrorx)))),max(max(LPData.matx))+(abs(max(max(LPData.materrorx))))] + [-1,1]*0.05*range(LPData.matx,'all')); % change the .05 in front of the range command to change the overhang on each side.
end
if ~sum(sum(~isnan(LPData.materrory)))               % check if materrory only contains NaNs
    LPData.ylimits=([min(min(LPData.maty)),max(max(LPData.maty))] + [-1,1]*0.05*range(LPData.maty,'all')); % remove change the [-1,1] to scale by a different linear factor, or deactivate scaling of one direction.
else
    LPData.ylimits=([min(min(LPData.maty))-(abs(max(max(LPData.materrory)))),max(max(LPData.maty))+(abs(max(max(LPData.materrory))))] + [-1,1]*0.05*range(LPData.maty,'all')); % remove change the [-1,1] to scale by a different linear factor, or deactivate scaling of one direction.
end
LPData.FixOrigin=questdlg("Do you want to fix the lower left corner to 0/0?","Fix to origin?");
switch LPData.FixOrigin
    case "Yes"
    LPData.xlimits(1)=0;
    LPData.ylimits(1)=0;
end
if range(LPData.maty,'all')==0
    LPData.ylimits=([min(min(LPData.maty)),max(max(LPData.maty))] + [-1,1].*0.05.*[LPData.maty(1,1),LPData.maty(1,1)]);
end
if range(LPData.matx,'all')==0
    LPData.xlimits=([min(min(LPData.matx)),max(max(LPData.matx))] + [-1,1].*0.05.*[LPData.matx(1,1),LPData.matx(1,1)]);
end                                                                       % PresketchFactor is used to scale the Presketch-axes in LPPlotfun2
LPData.PresketchFactor=5;                                                 % Default: 50
                                                                          % Higher values tends to result in rougher plots, which will (visually)
                                                                          % resemble the actual Data Set fitted less and less.

%% Split LPQS vs Normal Mode 
if isfield(LPData,'QS') && LPData.QS==true                                % double check that makes it simpler to deactivate QS-mode, just by setting QS=false
    %% QuickSketch
    close all
    disp('QuickSketch mode: On')
    
    % Defining plottypeindx                                               % LPQS-mode only supports line-plots so far/by default.
    LPData.plottypeindx=1;                                                % this results in a line plot later on
    
    
    % Defining the colororder used
    if ~isfield(LPData,'colors')
        LPData=LPColorfun2(LPData);
    end
    
    
    % Defining markertype
    LPData=LPCustommarkertypefun2(LPData);
    
    
    
    % Preview of plot
    hold on
    LPData.Previewfig=figure('Name','Preview of Data points');
    axis([LPData.xlimits(1,1)*1000 LPData.xlimits(1,2)*1000 LPData.ylimits(1,1)*1000 LPData.ylimits(1,2)*1000])
    for k=1:1:LPData.NumRows
        hold on
        plot(LPData.matx(k,:),LPData.maty(k,:),LPData.markertype(k),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
        plot(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
    axis([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)])
    title('Preview of Data points')
    
    
    % Defining Fittype and fitting the data
    LPData.LPTreePrompterCallNo=0;
    while ~isfield(LPData,'fittypeindx') || isempty(LPData.fittypeindx) || isfield(LPData,'LPTreePrompterCallNo') % Repeat when window is closed, escape is pressed or the "Cancel"-button is pressed in main menu.
        LPData.fittypeindx=LPTreePrompter(LPData.fittypeindxtable.LPfittypeindxtable); % Third condition resets loop to be engaged again if approached first time in the call to lazyplot (in case someone doesn't clear LPData)
        if isfield(LPData,'fittypeindx') && ~isempty(LPData.fittypeindx)
            LPData=rmfield(LPData,'LPTreePrompterCallNo');
        end
    end
    close(LPData.Previewfig)                                              % closes preview-data figure
    
    
    % Check for existing fitobject LPCustomfittype
    if LPData.fittypeindx==74
        if ~isfield(LPData,'LPCustomfittype')
            error('Error occured.\nLPCustomfittype does not exist. Please define a fittype named LPCustomfittype\nbefore calling LazyPlot again. For more information on custom fittypes,\nvisit the matlab help.\n[LazyPlot]','class(n)') %#ok<*CTPCT>
        end
    end
    [LPData]=LPFitfun2(LPData);
    
    
    % Plotting errorbars and data points
    LPData=LPErrorbarfun2(LPData);
    
    
    % Plotting everything
    LPData=LPPlotfun2(LPData);
    
    
    % Setting Figure properties:
    grid off
    axis([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)])
    
    
    legend off                                                            % Necessary to toggle like this to create empty cells for all objects
    legend;                                                               % in figure. This is needed later on when inputting correct number of
    if isfield(LPData,'Locationstring')                                   % legend entries
        legend('Location',LPData.Locationstring)
    end
    
    
    if isfield(LPData,'legendentries')                                    % Although not natively supported or intended, LPQS mode can implement
        legend(LPData.legendentries);                                     % a legend if it has been created before calling LazyPlot in LPQS mode.
    end                                                                   % Legend Location is preset to "best" in QS-mode.
    if isfield(LPData,'Locationstring')
        legend('Location',LPData.Locationstring)
    elseif isfield(LPData,'legendentries')                                % For some reason it won't position at "best" location if
        legend off
        legend('Location','best');                                        % the position is set in first creation of the legend, so
    else
        legend('Location','best');
    end                                                                   % this is a separate call for setting location.
    
    
    % Creating the actual gof-cell for the struct
    for k=1:1:LPData.NumRows
        LPData.gof{k}=LPData.goodnessoffit(k);
    end
    
    
    % Creating the additional fit-information cells for the struct
    if isfield(LPData,'O') && ~isempty(LPData.O)
        for k=1:1:LPData.NumRows
            LPData.AddFitInfo{k}=LPData.O(k);
        end
    end
    
    
    % Sorting the cellarrays containing the fit- and gof-data properly.
    if size(LPData.fits,1) ~= LPData.NumRows                              % if they are horizontal, else do nothing
        LPData.fits=transpose(LPData.fits);
    end
    if size(LPData.gof,1) ~= LPData.NumRows                               % if they are horizontal, else do nothing
        LPData.gof=transpose(LPData.gof);
    end
    if isfield(LPData,'O') || ~isempty(LPData.O)
        if size(LPData.AddFitInfo,1) ~= LPData.NumRows                    % if they are horizontal, else do nothing
            LPData.AddFitInfo=transpose(LPData.AddFitInfo);
        end
    end
    
    
    %%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%
    % END LPQS PROCEDURE %
    %%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%
else
    %% Normal Procedure
    disp('QuickSketch mode: Off')
    LPData.QS=false;
    
    
    % Decide if figure is closed, reused or newly created
    LPData.g = groot;
    LPData.Figurecheck=isempty(LPData.g.Children);                        % "1"/True if there are no open graphics objects, false otherwise
    if isfield(LPData,'Figurecheck')
        if LPData.Figurecheck==0                                          % a figure exists
            while ~isfield(LPData,'close_all')
                LPData.close_all=questdlg('Close all existing figures?','Close figures?','Yes.','No.','New one.','New one.');
            end
            switch LPData.close_all
                case 'Yes.'
                    close all
                case 'New one.'
                    figure;
            end
            LPData=rmfield(LPData,'close_all');
        end
    end
    LPData=rmfield(LPData,'Figurecheck');
    
    
    % Setting Colors
    if isfield(LPData,'colors')
        switch questdlg('Want new colors?','New colors?','Yes','No','No')
            case 'Yes'
                LPData=LPColorfun2(LPData);
        end
    else
        LPData=LPColorfun2(LPData);
    end
    
    
    % Setting markers
    if isfield(LPData,'markertype')
        switch questdlg('Want new markers?','New markers?','Yes','No','No')
            case 'Yes'
                LPData=LPCustommarkertypefun2(LPData);
        end
    else
        LPData=LPCustommarkertypefun2(LPData);
    end
    

    % Resetting Plottype
    if isfield(LPData,'plottypeindx')
        switch questdlg('Want a different Plottype?','New Plottype?','Yes','No','No')
            case 'Yes'                                                    % Want a different plottype
                LPData=rmfield(LPData,'plottypeindx');
        end                                                               % Want the same plottype
    end

    
    % Setting Plottype
    if exist('plottypeindx','var') && ~isfield(LPData,'plottypeindx')     % this allows to bypass the plottypefun2 if one presets the plottypeindx
        LPData.plottypeindx=plottypeindx;
    elseif isfield(LPData,'plottypeindx')
    else                                                                  % don't allow empty inputs (pressing esc, Cancel or closing the window)
        while ~isfield(LPData,'plottypeindx') || isempty(LPData.plottypeindx)
            LPData=LPPlottypefun2(LPData);
        end
    end
    
    
    % Setting Fittype
    if LPData.plottypeindx==1
        
        
        % Preview of Data for fit estimation
        hold on
        LPData.Previewfig=figure('Name','Preview of Data points');
        axis([LPData.xlimits(1,1)*1000 LPData.xlimits(1,2)*1000 LPData.ylimits(1,1)*1000 LPData.ylimits(1,2)*1000])
        for k=1:1:LPData.NumRows
            hold on
            plot(LPData.matx(k,:),LPData.maty(k,:),LPData.markertype(k),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
            plot(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
        end
        axis([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)]);
        title('Preview of Data points');
        
        
        % Choosing fittypeindx
        LPData.LPTreePrompterCallNo=1;
        while ~isfield(LPData,'fittypeindx') || isempty(LPData.fittypeindx)  || isfield(LPData,'LPTreePrompterCallNo') % Repeat when window is closed, escape is pressed or the "Cancel"-button is pressed in main menu.
            LPData.fittypeindx=LPTreePrompter(LPData.fittypeindxtable.LPfittypeindxtable); % Third condition resets loop to be engaged again if approached first time in the call to lazyplot (in case someone doesn't clear LPData)
            if isfield(LPData,'fittypeindx') && ~isempty(LPData.fittypeindx)
                LPData=rmfield(LPData,'LPTreePrompterCallNo');
            end
        end
        close (LPData.Previewfig)                                         % closes preview-data figure
        if LPData.fittypeindx==74                                         % Checking for existing custom fittype
            if ~isfield(LPData,'LPCustomfittype')
                error('Error occured.\nLPCustomfittype does not exist. Please define a fittype named LPCustomfittype\nbefore calling LazyPlot again. For more information on custom fittypes,\nvisit the matlab help.\n[LazyPlot]','class(n)') %#ok<*CTPCT>
            end
        end
        LPData=LPFitfun2(LPData);
    else                                                                  % These 2 lines create placeholder variables so certain functions down the line don't break if one does
        LPData.fits=cell.empty;                                           % choose something beside lineplots. In that case, fitobjects won't be needed, but are still necessary for
        LPData.goodnessoffit='Placeholder';                               % some functions to work
    end
    
    
    % Plotting Errorbars and Datapoints (only for line plots and if activated specifically, like for datavdata and scatter plots)
    if LPData.plottypeindx==1
        LPData=LPErrorbarfun2(LPData);
    end
    
    
    % Plotting graphs
    fig = get(groot,'CurrentFigure');
    LPData=LPPlotfun2(LPData);
    
    
    if isfield(LPData,'Errorbarflag')                                     % second method for other plottypes that might need errorbars:
        if LPData.Errorbarflag==1                                         % currently only scatter and datavdata plots
            LPErrorbarfun2(LPData)
        end
    end
    
    
    %web('https://de.mathworks.com/help/matlab/creating_plots/greek-letters-and-special-characters-in-graph-text.html#bux4rpf');
    %   LPFigurefun                                                       % This is the old function used for adjusting axis, title, 
    LPData=LPFigurefun2(LPData);                                          % labels legend and grid setting. It is highly suggested to not
                                                                          % use the old function, as it contains some mistakes, and will no 
                                                                          % longer be updated. Some of the functionality of LPFigurefun2 cannot
                                                                          % be implemented without data input
    % Creating the actual gof-cell for the struct
    for k=1:1:LPData.NumRows
        LPData.gof{k}=LPData.goodnessoffit(k);
    end
    
    
    % Creating the additional fit-information cells for the struct
    if isfield(LPData,'O') && LPData.plottypeindx<10                      % If one plots Data vs Data, no LPData.O/AddFitInfo is created
        if  ~isempty(LPData.O)
            for k=1:1:LPData.NumRows
                LPData.AddFitInfo{k}=LPData.O(k);
            end
        end
    end
    
    
    % Sorting the cellarrays containing the fit- and gof-data properly.
    if isfield(LPData,'fits')
        if size(LPData.fits,1) ~= LPData.NumRows                          % if they are horizontal, else do nothing
            LPData.fits=transpose(LPData.fits);
        end
    end
    
    
    if isfield(LPData,'gof')
        if size(LPData.gof,1) ~= LPData.NumRows                           % if they are horizontal, else do nothing
            LPData.gof=transpose(LPData.gof);
        end
    end
    
    
    if isfield(LPData,'O') && ~isempty(LPData.O)
        if size(LPData.AddFitInfo,1) ~= LPData.NumRows                    % if they are horizontal, else do nothing
            LPData.AddFitInfo=transpose(LPData.AddFitInfo);
        end
    end
    

    % Only display fits&other information if they actually exist
    if ~isempty(LPData.fits) && ~isempty(LPData.gof) && ~isempty(LPData.AddFitInfo) % Actual fit-, gof- and additional data exists
        celldisp(LPData.AddFitInfo,'Additional Info on Fit')
        celldisp(LPData.gof,'Goodness of Fit')
        LPcelldispForFits(LPData.fits)
    end
    disp('Just want to adjust figure properties? Call "LPFigurefun2"')

    
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%
    % END NORMAL PROCEDURE %
    %%%%%%%%%%%%%%%%%%%%%%%%
    %%%%%%%%%%%%%%%%%%%%%%%%
end

%% Cleanup 
if isfield(LPData,'NumColorRows')
    LPData=rmfield(LPData,'NumColorRows');
end
if isfield(LPData,'NumMarkerRows')
    LPData=rmfield(LPData,'NumMarkerRows');
end
% if isfield(LPData,'plottypeindx')
%     LPData=rmfield(LPData,'plottypeindx');
% end
if isfield(LPData,'fittypeinx')
    LPData=rmfield(LPData,'fittypeindx');
end
if isfield(LPData,'Initialisation')
    LPData=rmfield(LPData,'Initialisation');
end
if isfield(LPData,'(goodnessoffit')
    LPData=rmfield(LPData,'goodnessoffit');
end
if isfield(LPData,'markertype')
    LPData=rmfield(LPData,'markertype');
end
if isfield(LPData,'ColorResetSwitch')
    LPData=rmfield(LPData,'ColorResetSwitch');
end
if isfield(LPData,'LegendResetSwitch')
    LPData=rmfield(LPData,'LegendResetSwitch');
end
if isfield(LPData,'Axischangeflag')
    LPData=rmfield(LPData,'Axischangeflag');
end
if isfield(LPData,'Previewfig')
    LPData=rmfield(LPData,'Previewfig');
end
if isfield(LPData,'O')
    LPData=rmfield(LPData,'O');
end
clear k j

%% Save figures and LPData 
LPData=LPSavefigfun(LPData);

%% Procedure has finished 
if LPData.QS==false
    LPFinished
end
disp('Why are you lazy?')
why

%% Overview over possible fields of LPData at the end of a call to LazyPlot 
% fittypeindxtable | LPQS | Normal |
% matx             | LPQS | Normal |
% maty             | LPQS | Normal |
% materrorx        | LPQS | Normal |
% materrory        | LPQS | Normal |
% QS               | LPQS | Normal |
% ylimitspresketch | LPQS | Normal |
% fittypeindx      | LPQS | Normal |
% fits             | LPQS | Normal |
% colors           | LPQS | Normal |
% custom_markertype| LPQS | Normal |
% NumRows          | LPQS | Normal |
% xlimits          | LPQS | Normal |
% ylimits          | LPQS | Normal |
% xlimitspresketch | LPQS | Normal |
% answer           | LPQS | Normal |
% Axisvector       | LPQS | Normal |
% gof              | LPQS | Normal |
% legendentries    |      | Normal |
% LPData

%% END ALL PROCEDURE 
disp('LazyPlot has finished running.')
% ------------- END OF CODE -------------