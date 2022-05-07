function LPData=LPFitfun2(LPData)
% Calculates the fits of the data in matx and maty.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPFitfun2 creates fitobjects for each row in the matx/y-matrices,
% according to the previously chosen Fittype (cf.
% Mainscript/LPTreePrompter)
% LPData.goodnessoffit and LPData.O contain additional stats on the fits,
% depending on fittype.
% The inputbox for custom simple fittypes also allows crashing the program
% if one wants to. Input any of the following strings in the inputdlg-field
% "LPquit","lpquit","LPQUIT","LPQuit"
% to quit the program.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%     LPData=LPFitfun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
%            - fittypeindx
%            - NumRows
%            - matx
%            - maty
% 
% Inputs (optional):
%   LPData - structure with fields:
%            -LPCustomfittype (not tested)
% 
% Outputs:
%   LPData - structure with fields:
%            - fits
%            - goodnessoffit
%            - O
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
% MAT-files required: (indirectly via LPTreePrompter):
% LPfittypeindxtable.mat 
% See also: LPfittypeindxtable.mat,  LPTreePrompter
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
% Created: 15-May-2020 ; Last revision: 10-Jan-2021 

% ------------- BEGIN CODE --------------
hold on
%% Safety
if isfield(LPData,'goodnessoffit')                                        % for some reason, having the field already defined when running the function another time, it will run into an error. I have no clue why. It should just be reassigned imo.
    LPData=rmfield(LPData,'goodnessoffit');
end
if isfield(LPData,'O')                                                    % it seems to sometimes happen with that field as well, so this is just a precaution.
    LPData=rmfield(LPData,'O');
end
%% Fitting
LPData.Fitlist={'poly1','poly2','poly3','poly4','poly5','poly6','poly7','poly8','poly9','exp1','exp2','fourier1','fourier2','fourier3','fourier4','fourier5','fourier6','fourier7','fourier8','gauss1','gauss2','gauss3','gauss4','gauss5','gauss6','gauss7','gauss8','power1','power2','rat01','rat02','rat03','rat04','rat05','rat11','rat12','rat13','rat14','rat15','rat21','rat22','rat23','rat24','rat25','rat31','rat32','rat33','rat34','rat35','rat41','rat42','rat43','rat44','rat45','rat51','rat52','rat53','rat54','rat55','weibull','nearestinterp','linearinterp','splineinterp','pchipinterp','sin1','sin2','sin3','sin4','sin5','sin6','sin7','sin8'};
if isfield(LPData,'weightstrigger') && LPData.weightstrigger==true
    disp('Weights are considered')
    if LPData.fittypeindx <= 72                                               % normal fits
        for k=1:1:LPData.NumRows
            fo=fitoptions;
            LPData.Weights=1./LPData.materrory.^2;
            fo.Weights=LPData.Weights(k,:);
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPData.Fitlist{LPData.fittypeindx},fo);
        end
    elseif LPData.fittypeindx == 73                                           % Simple Custom Fit
        custom_simple_fittype=inputdlg('Please specify fittype, without the apostrophes ('') around it','Sample',[1 50]);
        LPData.customsimplefittype=char(custom_simple_fittype);
        if contains(custom_simple_fittype,["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK","Break"])% Check for break commands
            error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\nor a similar expression.','class(n)') %#ok<*CTPCT>
        end
        for k=1:1:LPData.NumRows
            fo=fitoptions;
            LPData.Weights=1./LPData.materrory.^2;
            fo.Weights=LPData.Weights(k,:);
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPData.customsimplefittype,fo);
        end
    else                                                                      % Custom Fit with LPCustomfittype
        for k=1:1:LPData.NumRows
            fo=fitoptions;
            LPData.Weights=1./LPData.materrory.^2;
            fo.Weights=LPData.Weights(k,:);
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPCustomfittype,fo);
        end
    end
else
    if LPData.fittypeindx <= 72                                               % normal fits
        for k=1:1:LPData.NumRows
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPData.Fitlist{LPData.fittypeindx});
        end
    elseif LPData.fittypeindx == 73                                           % Simple Custom Fit
        custom_simple_fittype=inputdlg('Please specify fittype, without the apostrophes ('') around it','Sample',[1 50]);
        LPData.customsimplefittype=char(custom_simple_fittype);
        if contains(custom_simple_fittype,["LPquit","lpquit","LPQUIT","LPQuit","quit","Quit","QUIT","break","BREAK","Break"])% Check for break commands
            error('Force Quit induced by user inputting keyword LPquit/lpquit/LPQUIT/LPQuit\nor a similar expression.','class(n)') %#ok<*CTPCT>
        end
        for k=1:1:LPData.NumRows
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPData.customsimplefittype);
        end
    else                                                                      % Custom Fit with LPCustomfittype
        for k=1:1:LPData.NumRows
            [LPData.fits{k},LPData.goodnessoffit(k),LPData.O(k)]=fit(LPData.matx(k,:)',LPData.maty(k,:)',LPCustomfittype);
        end
    end
end
end


% ------------- END OF CODE -------------
