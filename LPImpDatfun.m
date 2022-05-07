function LPData=LPImpDatfun(tfactor_column,LPQS,PseudoQS_colors,PseudoQS_markers,plottypeindx)
% LPImpDatfun imports Data for x&y+errors, can be used to preset flags.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPImpDatfun is mainly built to convert preprocessed data from
% comma-seperation (3,2) to a decimal point separation (3.2).
% You can choose if the imported data is treated as a set of measurement
% data or as means of a set
% 
% A) set of measurement Data:
% 
% The mean calculation omits NaN, which means that in this case:
%   Matrix=[1 2 3 4  ;
%           5 6 7 NaN],
% the mean will be:
%   Mean = [ 3 4 5 4]
% 
% If you want to handle means differently, change behaviour by hand.
% 
% You can either set the uncertainties yourself, let them be calculated 
% using the formula
%       YErrorvector=tfac/sqrt(NumYDataRows)*std(yData)
% or set them all to NaN.
% 
% B) Combined Means of different sets
% 
% You can either set the uncertainties yourself, or set them all to NaN.
% 
% 
% Setting uncertainties yourself:
% Lets say we have a matx-matrix of size 2x3.
% 
% 1) If you choose one value for a matrix, the entire error vector is
%    populated with that number, f.e. 0.1
%    Then the materrorx-matrix will be = [0.1 0.1 0.1;
%                                         0.1 0.1 0.1]
% 
% 2) If you are plotting multiple means, seperate
%    specific error values using the semicolon (;), f.e. 0.1;1
%    Then the materrorx-matrix will be = [0.1 0.1 0.1;
%                                         1.0 1.0 1.0]
% 
% 3) If you are plotting multiple means, choosing one value does the same
%    as in 1)
% 
% 4) If you are setting individual values for every position, that is also
%    possible.
% 
% The number in the title of the inputdlg box stands for the number of
% values you have to enter for a full vector, i.e if you want to set
% value-specific errors, and the title is 3, you need to give three numbers
% for the errormatrix you want to set.
% 
% Syntax:
%     LPData=LPImpDatfun(tfactor_column)
%     LPData=LPImpDatfun(tfactor_column,LPQS)
%     LPData=LPImpDatfun(tfactor_column,LPQS,PseudoQS_colors)
%     LPData=LPImpDatfun(tfactor_column,LPQS,PseudoQS_colors,PseudoQS_markers)
%     LPData=LPImpDatfun(tfactor_column,LPQS,PseudoQS_colors,PseudoQS_markers,plottypeindx)
% 
% IMPORTANT: if one wants to set PseudoQS_markers, LPQS and PseudoQS_colors
% MUST be set as well. 
% LPQS, PseudoQS* are either logical or doubles with value true/1 or false/0
% PseudoQS_colors triggers QuickSketch-like behaviour of the LPColorfun2 in
% Normal mode. PseudoQS_markers does the same for LPCustommarkertypefun2
% 
% LPQS takes precedence over Pseudo*-calls in LazyPlot, meaning if you
% define LPQS as 1/true during the call to LPImpDatfun, you won't have to
% define PseudoQS* anymore.
% 
% plottypeindx is a number from 1 to 10 and is mapped as follows:
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
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Inputs (vital):
%   - tfactor_column:
%     - can be any of the following:
%       -   2 / 95 / 0.95: Choose the 95%-student-t-factor column when 
%           letting the function calculate errors
%       -   3 / 99 / 0.99: Choose the 99%-student-t-factor column when
%           letting the function calculate errors
%       - IMPORTANT: LPImpDatfun can only calculate up to the 40th degree
%                    of Freedom. If you need more values, please adjust the
%                    corresponding matrices yourself in either section
%                    called "Student_t-factors-vector"
% 
% Inputs (optional):
%   - LPQS           - 1x1 double, or 1x1 logical. If double, must be 1 or 0
%   - PseudoQScolors - 1x1 double, or 1x1 logical. If double, must be 1 or 0.
%                      used to induce LPQS-like behaviour in LPColorfun2
%   - PseudoQSmarkers- 1x1 double, or 1x1 logical. If double, must be 1 or 0
%                      used to induce LPQS-like behaviour in
%                      LPCustommarkertypefun2
%  * LPQS trumps PseudoQS-behaviour and takes precedence
% 
% Outputs:
%   LPData - structure with (possible) fields:
%            - QS (internal LPQS-flag)
%            - PseudoQS_colors
%            - PseudoQS_markers
%            - plottypeindx
% 
% Example: 
%   -
% 
% 
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - LPImpDatfun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
% See also: LPColorfun2, LPCustommarkertypefun2 LPPlottypefun2
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
% Created: 28-Jul-2020 ; Last revision: 11-Aug-2020 

% ------------- BEGIN CODE --------------
%% 1) Import x and y data
prompt = {'Enter x measurement values:','Enter y measurement values'};    % if 3 rows for yData is imported, and 1 row for xData, the mean is equal
dlgtitle = 'Input';                                                       % to the actual input (meanX=X), and an additional question for special
dims = [1 35];                                                            % errors of x are created.
x = inputdlg(prompt,dlgtitle,dims);
x=strrep(x,',','.');
xData=str2num(x{1}); % #ok<*ST2NM>                                        % Internal variables for storing x and y Data
yData=str2num(x{2});                                                      % are created
NumXDataRows=size(xData,1);
NumYDataRows=size(yData,1);% #ok<*ASGLU>
%% 2) Decide: is xData/yData a matrix of same-set measurements, or  the means of two different sets that are to be plotted as two different graphs?#
disp('You can either input data as a matrix of repeated measurements')
disp('or the combined rows of several measurement sets with different conditions')
switch questdlg('Is x/yData a matrix of same-set data, or combined sets?','1 Matrix or x Means?','Matrix','Means','Matrix')
    case 'Matrix'
        %% 3) Calculate mean of matrices xData and yData
        xMean=mean(xData,'omitnan')                                       % These two vectors are to be plotted. 
        yMean=mean(yData,'omitnan'); % #ok<*NASGU>                        % later on as LPData.matx and LPData.maty
        %% 4) Calculate uncertainties of matrices xData and yData
        switch questdlg('Do you want to set uncertainties yourself?','Manual Uncertainties?','Yes','No','NaN','Yes')
            case 'Yes'                                                    % Set uncertainties yourself
                prompt = {'Enter materrorx values:','Enter materrory values'};
                dims = [1 35];
                numEntries=(length(yData));
                dlgtitle=num2str(numEntries);
                x = inputdlg(prompt,dlgtitle,dims);
                x=strrep(x,',','.');
                errorxData=str2num(x{1}); %#ok<*ST2NM>
                erroryData=str2num(x{2});
                XErrorvector=errorxData;
                YErrorvector=erroryData;
                if length(XErrorvector)==numEntries                       % errorvector is of correct size (do nothing)
                elseif length(XErrorvector)==1
                    XErrorvector=repelem(XErrorvector,numEntries);
                elseif length(XErrorvector)~=numEntries && length(XErrorvector)<numEntries
                    error('Error occured.\nIf you want to set errors per row, treat them as seperate measurement sets\nby choosing the option "Means".[LPuMeanfun]','class(n)') %#ok<*CTPCT>
                elseif length(XErrorvector)~=numEntries && length(XErrorvector)>numEntries
                    error('Error occured.\nNumber of defined errors is greater than number of plotted data points.\nPlease define either one value as error to be used on all data points\nor as many individual errors as you have data points.[LPuMeanfun]','class(n)')
                end
                if length(YErrorvector)==numEntries                       % errorvector is of correct size (do nothing)
                elseif length(YErrorvector)==1
                    YErrorvector=repelem(YErrorvector,numEntries);
                elseif length(YErrorvector)~=numEntries && length(YErrorvector)<numEntries
                    error('Error occured.\nLPuMeanfun is not able to paste different errors into the right positions.\nYou can either let LPuMeanfun calculate the x error for you or define either\nan error vector the length of your matrix (in x-direction).[LPuMeanfun]. ','class(n)') %#ok<*CTPCT>
                elseif length(YErrorvector)~=numEntries && length(YErrorvector)>numEntries
                    error('Error occured.\nNumber of defined errors is greater than number of plotted data points.\nPlease define either one value as error to be used on all data points\nor as many individual errors as you have data points.[LPuMeanfun]','class(n)')
                end
            case 'No'                                                     % Let the function decide uncertainties itself.
                %% X uncertainties
                if NumXDataRows>1                                         % 2 or more repeats
                    ChosenXfactor=NumXDataRows-1;                         % this chooses the Nth-1 factor
                else                                                      % one single measurement
                    disp('We have an N of 1, so assuming 20% scale value')
                    error('Please calculate on your own. This function is currently incapable of calculating N=1 Uncertainties.[LPuMeanfun]')
                end
                if tfactor_column==1                                      % if someone chose t-fac 1, which is just the index value
                    error('Can''t choose row 1, the row contains no t-factors. If you have one measurement, assume\nuncertainty of 20%.[LPuMeanfun]','class(n)')
                end
                if ChosenXfactor>40
                    error('Student-t-factors are not available for matrices larger than N=40 number of repeats/independent measurements.\nPlease look up the corresponding t-factor and calculate on your  own, or increase\nthe size of the "Studen-t-factors"-variable.[LPuMeanfun]','class(n)') %#ok<*CTPCT>
                end
%% Student_t-factors-vector
                Student_t_factors=[1 12.706 63.657;2 4.303 9.925;3 3.182 5.841; 4 2.776 4.604; 5 2.571 4.032;6 2.447 3.707;7 2.365 3.499;8 2.306 3.355;9 2.262 3.250;10 2.228 3.25;11 2.201 3.106;12 2.179 3.055;13 2.16 3.012;14 2.145 2.977;15 2.131 2.947;16 2.12 2.921;17 2.11 2.898;18 2.101 2.878;19 2.093 2.861;20 2.086 2.845;21 2.08 2.518;22 2.074 2.508;23 2.069 2.5;24 2.064 2.492;25 2.06 2.485;26 2.056 2.479;27 2.052 2.473;28 2.048 2.467;29 2.045 2.462;30 2.042 2.457;31 2.04 2.453;32 2.037 2.449;33 2.035 2.445;34 2.032 2.441;35 2.03 2.438;36 2.028 2.434;37 2.026 2.431;38 2.024 2.429;39 2.023 2.429;40 2.021 2.423];
%%                 
                if tfactor_column==2 || tfactor_column==95 || tfactor_column==0.95
                    tfactor_column=2;
                    disp('Chosen confidence: 95%')                  
                    tfac=Student_t_factors(ChosenXfactor,tfactor_column); % grab NumRows-1 element of the student_t_factor-table
                    XErrorvector=tfac/sqrt(NumXDataRows)*std(xData);
                elseif tfactor_column==3 || tfactor_column==99 || tfactorcolumn==0.99
                    tfactor_column=3;
                    disp('Chosen confidence: 99%')
                    tfac=Student_t_factors(ChosenXfactor,tfactor_column);
                    XErrorvector=tfac/sqrt(NumXDataRows)*std(xData);
                else
                    error('Wrong column, choose 2/95/0.95 or 3/99/0.99 for 95% or 99% respectively.[LPuMeanfun]')
                end
                %% Y uncertainties
                if NumYDataRows>1                                         % 2 or more repeats
                    ChosenYfactor=NumYDataRows-1;                         % this chooses the Nth-1 factor
                else                                                      % one single measurement
                    error('Please calculate on your own. This function is currently incapable of calculating N=1 Uncertainties.[LPuMeanfun]')
                end
                if tfactor_column==1                                      % if someone chose t-fac 1, which is just the index value
                    error('Can''t choose row 1, the row contains no t-factors. If you have one measurement, assume\nuncertainty of 20%.[LPuMeanfun]','class(n)')
                end
                if ChosenYfactor>40
                    error('Student-t-factors are not available for matrices larger than N=40 number of repeats/independent measurements.\nPlease look up the corresponding t-factor and calculate on your  own, or increase\nthe size of the "Studen-t-factors"-variable.[LPuMeanfun]','class(n)') %#ok<*CTPCT>
                end
%% Student_t-factors-vector
                Student_t_factors=[1 12.706 63.657;2 4.303 9.925;3 3.182 5.841; 4 2.776 4.604; 5 2.571 4.032;6 2.447 3.707;7 2.365 3.499;8 2.306 3.355;9 2.262 3.250;10 2.228 3.25;11 2.201 3.106;12 2.179 3.055;13 2.16 3.012;14 2.145 2.977;15 2.131 2.947;16 2.12 2.921;17 2.11 2.898;18 2.101 2.878;19 2.093 2.861;20 2.086 2.845;21 2.08 2.518;22 2.074 2.508;23 2.069 2.5;24 2.064 2.492;25 2.06 2.485;26 2.056 2.479;27 2.052 2.473;28 2.048 2.467;29 2.045 2.462;30 2.042 2.457;31 2.04 2.453;32 2.037 2.449;33 2.035 2.445;34 2.032 2.441;35 2.03 2.438;36 2.028 2.434;37 2.026 2.431;38 2.024 2.429;39 2.023 2.429;40 2.021 2.423];
%%
                if tfactor_column==2 || tfactor_column==95 || tfactor_column==0.95
                    tfactor_column=2;
                    disp('Chosen confidence: 95%')
                    tfac=Student_t_factors(ChosenYfactor,tfactor_column);
                    YErrorvector=tfac/sqrt(NumYDataRows)*std(yData);
                elseif tfactor_column==3 || tfactor_column==99 || tfactorcolumn==0.99
                    tfactor_column=3;
                    disp('Chosen confidence: 99%')
                    tfac=Student_t_factors(ChosenYfactor,tfactor_column);
                    YErrorvector=tfac/sqrt(NumYDataRows)*std(yData);
                else
                    error('Wrong column, choose 2 or 3 for 95% or 99% respectively.[LPuMeanfun]')
                end
            case 'NaN'
                XErrorvector=NaN(size(xData));
                YErrorvector=NaN(size(yData));
        end
        %% 5) Import Data into correct fields
        LPData.materrorx=XErrorvector;
        LPData.materrory=YErrorvector;
        LPData.matx=xMean;                                                % contains calculated means for LazyPlot
        LPData.maty=yMean;
        LPData.xData=yData;                                               % contains original input
        LPData.yData=yData;
        %% 6) Fallback import for one data row cases
        if size(LPData.matx)==[1,1] %#ok<*BDSCA>                          % in case we only have one row of data, the mean would be a single value.
            LPData.matx=xData;                                            % Fallback: since we only have one row of input data, we just plot that
        end
        if size(LPData.maty)==[1,1]
            LPData.maty=yData;
        end
    case 'Means'
        %% 3) Assign matx and maty & query uncertainties
        LPData.matx=xData;                                                % since we are importing different means of same dimensions to be
        LPData.maty=yData;                                                % plotted as different graphs&datapoint-sets, we don't need any processing here anymore.
                                                                          % However, in this case it is assumed that the errors/uncertainties
                                                                          % are known, and have to be imported manually, for each row
                                                                          % seperately.
        disp('Since means of different data sets are merged into LPmatx&LPmaty, the')
        disp('corresponding uncertainties need to be imported as well, or set to NaN''s.')
        switch questdlg ('Do you want to set uncertainties yourself?','Manual Uncertainties?','Yes','NaN','Yes')
            case 'Yes'                                                    % Set uncertainties yourself
                prompt = {'Enter materrorx values:','Enter materrory values'};
                dims = [1 35];
                numEntries=(length(yData));
                dlgtitle=num2str(numEntries);
                x = inputdlg(prompt,dlgtitle,dims);
                x=strrep(x,',','.');
                errorxData=str2num(x{1}); %#ok<*ST2NM>
                erroryData=str2num(x{2});
                XErrorvector=errorxData;
                YErrorvector=erroryData;
                % X Errors:
                if size(XErrorvector)==[1,1]               %#ok<*BDSCA>   % 1) X:  all positions equal to one value, over both sets of data we set same uncertainty
                    LPData.materrorx=zeros(size(yData))+XErrorvector;
                elseif size(XErrorvector)==[NumXDataRows,1]               % 2) X: each row has own error across itself
                    LPData.materrorx=zeros(size(yData))+XErrorvector;
                else                                                      % 3) Every element of LPData.matx has an individual error calculated before.
                    LPData.materrorx=XErrorvector;                        %    Do nothing, as we have all data imported properly.
                end
                % Y Errors:
                if size(YErrorvector)==[1,1]                              % 1) X:  all positions equal to one value, over both sets of data we set same uncertainty
                    LPData.materrory=zeros(size(yData))+YErrorvector;
                elseif size(YErrorvector)==[NumXDataRows,1]               % 2) X: each row has own error across itself
                    LPData.materrory=zeros(size(yData))+YErrorvector;
                else                                                      % 3) Every element of LPData.matx has an individual error calculated before.
                    LPData.materrory=YErrorvector;                        %    Do nothing, as we have all data imported properly.
                end
            case 'NaN'
                LPData.materrorx=nan(size(LPData.maty));
                LPData.materrory=nan(size(LPData.maty));
        end
        %% Input additional arguments for presetting LazyPlot
        if nargin>=2
            LPData.QS=LPQS;
        end
        if nargin>=3                                                      % case for prededefining only colors
            LPData.PseudoQScolors=PseudoQS_colors;
        end
        if nargin>=4                                                      % case for prededefining also markers
            LPData.PseudoQSmarkers=PseudoQS_markers;
        end
        if nargin>=5                                                      % case for prededefining also plottypeindx
            LPData.plottypeindx=plottypeindx;
        end
        %%% TODO:
        %%% create an input for assuming 20% uncertainty inside the function
       
end


% ------------- END OF CODE -------------
