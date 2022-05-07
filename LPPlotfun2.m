function LPData=LPPlotfun2(LPData)
% Plots the data in different ways, depending on what was chosen.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Plots data depending on plottype chosen by LPPlottypefun2. Uses colors
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%   LPData=LPPlotfun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
%            - NumRows
%            - fits
%            - plottypeindx
%            - PresketchFactor
%            - colors
%            - markertype*
% 
% * only DatavsData: "Graph + Datapoints"
% 
% Inputs (optional):
%   -
% 
% Outputs:
%   LPData - structure with fields:
%            - h
%            - h.color
%            - Errorbarflag
%            - handle  to objects plotted. Named after Plottype (i.e.
%              "Line", "bar" etc)
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
% See also:
% LPPlottypefun2,LPFitfun2,LPColorfun2,LPMarkertypefun2,LPErrorbarfun2
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
% Created: 15-May-2020 ; Last revision: 15-Aug-2020 

% ------------- BEGIN CODE --------------
hold on
if isfield(LPData,'fits')                                                 % Check for correct size of LPData.fits
    if size(LPData.fits)==[LPData.NumRows,1]
        LPData.fits=transpose(LPData.fits);
    end
end
%% Setting presketch axes for certain plottypes only
if LPData.plottypeindx==1 || LPData.plottypeindx==3 || LPData.plottypeindx>=5
    LPData.xlimitspresketch=([min(min(LPData.matx)),max(max(LPData.matx))] + [-1,1]*LPData.PresketchFactor*range(LPData.matx,'all')); % If this factor is set too big, the graphs might look worse when LazyPlot scales them down again.
    LPData.ylimitspresketch=([min(min(LPData.maty)),max(max(LPData.maty))] + [-1,1]*LPData.PresketchFactor*range(LPData.maty,'all'));
    if range(LPData.maty,'all')==0
        LPData.ylimitspresketch=([min(min(LPData.maty)),max(max(LPData.maty))] + [-1,1].*LPData.PresketchFactor.*[LPData.maty(1,1),LPData.maty(1,1)]);
    end
    if range(LPData.matx,'all')==0
        LPData.xlimitspresketch=([min(min(LPData.matx)),max(max(LPData.matx))] + [-1,1].*LPData.PresketchFactor.*[LPData.matx(1,1),LPData.matx(1,1)]);
    end
    axis([LPData.xlimitspresketch(1,1) LPData.xlimitspresketch(1,2) LPData.ylimitspresketch(1,1) LPData.ylimitspresketch(1,2)]);
end
%% Plotting
if LPData.plottypeindx==1                                                 % Line plot
    for k=1:1:LPData.NumRows
        hold on
        LPData.line(k) = plot(LPData.fits{1,k});                          % these two lines are necessary for the colours to match up
        LPData.line(k).Color = LPData.colors(rem(k-1,LPData.NumRows)+1,:);
    end
elseif LPData.plottypeindx==2                                             % Bar plot
    LPbarstylelist={'grouped','stacked','histogram 2'};
    switch listdlg('ListString',LPbarstylelist,'PromptString','Select Bartype','Name','Bartype','SelectionMode','single','ListSize',[160 145])
        case 1                                                            % grouped bar plot
            LPData.bar=bar(LPData.matx',LPData.maty','grouped');          % the user adjusts the axes himself.
        case 2                                                            % stacked bar plot
            LPData.bar(LPData.matx',LPData.maty','stacked')
        case 3                                                            % histogram2
            NumBins=[10 10];
            warning('Standard number of bins is [10 10]. Adjust manually in line 45. [LPPlotfun2]')
            LPData.bar=histogram2(LPData.matx,LPData.maty,'Facecolor','flat','ShowEmptyBins','off','NumBins',NumBins,'EdgeColor',[0 0 0],'FaceColor','flat');
    end
elseif LPData.plottypeindx==3                                             % Stairstep plot
    for k=1:1:LPData.NumRows
        LPData.stairs(k)=stairs(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
elseif LPData.plottypeindx==4                                             % Stem plot
    [LPData.NumRows,LPNumCols]=size(LPData.maty);                         % conversion for proper plotting of stem plots.
    LPstemstylelist={'empty markers','filled markers'};
    switch listdlg('ListString',LPstemstylelist,'PromptString','Select Stemtype','Name','Stemtype','SelectionMode','single','ListSize',[160 145])
        case 1
            if size(LPData.maty)==[LPData.NumRows,LPNumCols] %#ok<*BDSCA> % size is LPNumRowsxLPNumCols, so transpose for the plot,
                LPData.matx=transpose(LPData.matx);                       % then retranspose for normal operations
                LPData.maty=transpose(LPData.maty);
                LPData.stem=stem(LPData.matx,LPData.maty);
                LPData.matx=transpose(LPData.matx); %#ok<*NASGU>
                LPData.maty=transpose(LPData.maty);
            else                                                          % fallback: size is correct for this purpose, so plot & retranspose to normal operations
                LPData.stem=stem(LPData.matx,LPData.maty);
                LPData.matx=transpose(LPData.matx);
                LPData.maty=transpose(LPData.maty);
            end
        case 2
            if size(LPData.maty)==[LPData.NumRows,LPNumCols]              % size is LPNumRows*LPNumCols, so transpose for the plot,
                LPData.matx=transpose(LPData.matx);
                LPData.maty=transpose(LPData.maty);
                LPData.stem=stem(LPData.matx,LPData.maty,'filled');
                LPData.matx=transpose(LPData.matx);
                LPData.maty=transpose(LPData.maty);
            else                                                          % fallback: size is correct for the plot, so plot & retranspose to normal operations
                LPData.stem=stem(LPData.matx,LPData.maty,'filled');
                LPData.matx=transpose(LPData.matx);
                LPData.maty=transpose(LPData.maty);
            end
    end
elseif LPData.plottypeindx==5 % Scatter plot
    switch questdlg('Do you want errorbars?','Errorbars','Yes','No','No')
        case 'Yes'                                                        % if we want errorbars, we actually use the LPErrorbarfun2 to plot data points and errorbars
            LPData.Errorbarflag=1;
        case 'No'                                                         % if  we only want data points scattered, without errorbars, we actually use the scatter command
            for k=1:1:LPData.NumRows
                                                                          % Set axis to higher values if you want to see more before adjusting the axes yourself.
                LPData.scatter(k)=scatter(LPData.matx(k,:),LPData.maty(k,:),'Marker',LPData.markertype(rem(k-1,LPData.NumRows)+1,:),'CData',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
            end
    end
elseif LPData.plottypeindx==6                                             % Polar Plot %% not redesigned yet
    for k=1:1:LPData.NumRows
        LPData.polar(k)=polarplot(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
elseif LPData.plottypeindx==7                                             % Loglog Plot %% not redesigned yet
    for k=1:1:LPData.NumRows
        LPData.loglog(k)=loglog(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
elseif LPData.plottypeindx==8                                             % SemilogX Plot %% not redesigned yet
    for k=1:1:LPData.NumRows
        LPData.semilogx(k)=semilogx(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
elseif LPData.plottypeindx==9                                             % SemilogY Plot %% not redesigned yet
    for k=1:1:LPData.NumRows
        LPData.semilogy(k)=semilogy(LPData.matx(k,:),LPData.maty(k,:),'Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
    end
else                                                                      % Plot of Data vs Data, non-fitted graphs
    LPDatavDatalist={'Graph only','Graph + Datapoints'};
    switch listdlg('ListString',LPDatavDatalist,'PromptString','Select Graphtype','Name','Graphtype','SelectionMode','single','ListSize',[160 145])
        case 1                                                            % Graph only
            for k=1:1:LPData.NumRows
                LPData.line(k)=plot(LPData.matx(k,:)',LPData.maty(k,:)','Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
            end
        case 2                                                            % Graph and DataMarkers
            for k=1:1:LPData.NumRows
                LPData.line(k)=plot(LPData.matx(k,:)',LPData.maty(k,:)','Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:));
            end
    end
    switch questdlg('Do you want errorbars?','Errorbars','Yes','No','No')
        case 'Yes'
            LPData.Errorbarflag=1;
        case 'No'
            if isfield(LPData,'Errorbarflag')
                LPData=rmfield(LPData,'Errorbarflag');
            end
            for k=1:1:LPData.NumRows
                LPData.Points(k)=plot(LPData.matx(k,:)',LPData.maty(k,:)','Color',LPData.colors(rem(k-1,LPData.NumRows)+1,:),'Marker',LPData.markertype(rem(k-1,LPData.NumRows)+1,:));
            end
    end
end
if LPData.plottypeindx==1 || LPData.plottypeindx==3 || LPData.plottypeindx>=5 % this block autscales the axis according to the data used.
    axis([LPData.xlimits(1,1) LPData.xlimits(1,2) LPData.ylimits(1,1) LPData.ylimits(1,2)])
end
end


% ------------- END OF CODE -------------
