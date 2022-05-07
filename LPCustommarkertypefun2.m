function LPData = LPCustommarkertypefun2(LPData)
% Sets the markers for LazyPlot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPCustommarkertypefun2 creates the markertype-character array containing
% the markertype-symbol used by LPErrorbarfun2 (and in some edge cases,
% LPPlotfun2) to mark the position of data points.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% In normal mode, you can choose between
% 1) Line-exclusive custom markers
% 2) Unified custom markers
% 3) no custom markers
%
% 1) Line-exclusive:
% In case of Line-exclusive custom markers, you can choose either one of
% the following markertypes for each set of datapoints+regression line:
% 'o' - Circle
% '+' - Plus Sign
% '*' - Asterisk
% '.' - Point
% 'x' - Cross
% 's' - Square
% 'd' - Diamond
% '^' - up arrow tip
% 'v' - down arror tip
% '>' - right arrow tip
% '<' - left arrow tip
% 'p' - pentagram
% 'h' - hexagram
%
% 2) Unified:
% In this case, you can choose one of the markers above, and all data sets
% will be displayed with that marker.
%
% 3) No custom markers
% In this case, the order above is followed, and each type is repeated 14
% times. This ensures that if one chose no custom colors, each set of data
% point can be identified by a unique combination of colors and markers -
% until you plot more than 192 sets. At that point, it will just loop back
% to the beginning. But one must be crazy to plot anything close to 192
% sets of data points in my opinion.
%
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% In LPQS-mode, method "3) No custom markers" is applied.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:
%   LPData = LPCustommarkertypefun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
%            - NumRows
%            - QS (internal LPQS-flag)
%
% Inputs (optional):
%   LPData - structure with fields:
%            - PseudoQSmarkers
%
% Outputs:
%   LPData - structure with fields:
%            - markertype
%
% Example: 
%  -
% 
% Other m-files required: All Components of the toolbox LazyPlot, except:
% - LPCodeComp
% - Changelog.txt
% - LPImpDatfun
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: none
% MAT-files required: none
% See also: LPColorfun2
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
if LPData.QS==false                                                       % normal path
    if isfield(LPData,'PseudoQSmarkers')  && LPData.PseudoQSmarkers==true
        LPData.markertype=['o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h'];
        NumMarkerRows=size(LPData.markertype,1);
        while NumMarkerRows<LPData.NumRows
            LPData.markertype=[LPData.markertype;LPData.markertype];
            NumMarkerRows=size(LPData.markertype,1);
        end
        disp('LPQS-like markers were chosen on normal path. [LPCustommarkertypefun2]')
    else
        markers=['o';'+';'*';'.';'x';'s';'d';'^';'v';'>';'<';'p';'h'];
        switch questdlg('Do you want custom markers?','Marker','Line-exclusive','Unified','No','No')
            case 'Unified'                                                % Unified custom marker for every line
                LPMarkerlist={'Circle','Plus Sign','Asterisk (*)','Point','Cross (x)','Square','Diamond','^','v','>','<','pentagram (5-point star)','hexagram (6-point star)'};
                markertype=char(markers(listdlg('ListString',LPMarkerlist,'PromptString','Select Legend location','Name','Loation-Selection','SelectionMode','Single','ListSize',[160 190])));
                for k=1:1:LPData.NumRows
                    LPData.markertype(k,:)=markertype;
                end
            case 'Line-exclusive'                                         % Exclusive markertype for every line
                for k=1:1:LPData.NumRows
                    LPMarkerlist={'Circle','Plus Sign','Asterisk (*)','Point','Cross (x)','Square','Diamond','^','v','>','<','pentagram (5-point star)','hexagram (6-point star)'};
                    LPData.markertype(k,:)=char(markers(listdlg('ListString',LPMarkerlist,'PromptString','Select Legend location','Name','Loation-Selection','SelectionMode','Single','ListSize',[160 190])));
                end
            case 'No'
                LPData.markertype=['o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h'];
                NumMarkerRows=size(LPData.markertype,1);                  % Initialise Counter
                while NumMarkerRows<LPData.NumRows
                    LPData.markertype=[LPData.markertype;LPData.markertype];
                    NumMarkerRows=size(LPData.markertype,1);
                end
            otherwise                                                     % Fallback for pressing esc/closing the window
                warning('Error occured. No user input detected. Fallback: Standard markers. [LPCustommarkertypefun2]')
                LPData.markertype=['o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h'];
                NumMarkerRows=size(LPData.markertype,1);
                while NumMarkerRows<LPData.NumRows
                    LPData.markertype=[LPData.markertype;LPData.markertype];
                    NumMarkerRows=size(LPData.markertype,1);
                end
        end
    end
else                                                                      % LPQS
LPData.markertype=['o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'o';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'x';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'+';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'*';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'.';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'d';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'s';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'^';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'v';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'>';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'<';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'p';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h';'h']; 
    NumMarkerRows=size(LPData.markertype,1);
    while NumMarkerRows<LPData.NumRows
        LPData.markertype=[LPData.markertype;LPData.markertype];
        NumMarkerRows=size(LPData.markertype,1);
    end
end
end


% ------------- END OF CODE -------------
