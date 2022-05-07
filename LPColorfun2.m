function LPData = LPColorfun2(LPData)
% Sets the colormatrix for LazyPlot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% LPColorfun2 creates the colormatrix necessary for LPplotfun2 and
% LPErrorbarfun2 to work. It preallocates a [NumRows 3]-sized matrix with
% zeros and fills it up to the number of rows of the matrices plotted.
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% In normal mode, you can choose between
% 1) custom colors or
% 2) normal colors (no custom colors)
%
% In case of normal colors, the following colormatrix will be repeated
% until it is big enough:
%
% old red-> old blue-> old green-> cyano-> old magenta-> old black-> 
% old yellow-> new orange-> new blue-> new green-> new lightblue-> 
% new purple-> new brown-> new yellowo
%
% In case of custom colors, you can choose between any of those colors
% repeatedly until the number of required colors is reached. Note: this
% method is not recommended if you plot many rows of your matrices, as it
% is rather slow.
%
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% In LPQS-mode, the colororder shown above as "normal colors" is repeated
% until the matrix is big enough:
% old blue-> old green-> old red-> cyano-> old black-> old yellow-> new
% blue-> new orange-> new yello-> new purple-> new green-> new lightblue->
% new brown
%~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%   LPData = LPColorfun2(LPData)
% 
% Inputs (vital):
%   LPData - structure with fields:
%            - NumRows
%            - QS (internal LPQS-flag)
% 
% Inputs (optional):
%   LPData.PseudoQScolors
% 
% Outputs:
%   LPData - structure with fields:
%            - colors
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
% See also: LPCustommarkertypefun2
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
LPData.colors=zeros([LPData.NumRows 3]);                                  % Preallocates a matrix the size of NumRows,3.
LPData.colors=[
    1 0 0;                                                                % redold
    0 0 1;                                                                % blueold
    0 1 0;                                                                % greenold
    0 1 1;                                                                % cyanold
    1 0 1;                                                                % magentaold
    0 0 0;                                                                % blackold
    1 1 0;                                                                % yellowold
    0.8500  0.3250  0.0980                                                % orangenew
    0.0000  0.4470  0.7410                                                % bluenew
    0.4660  0.6740  0.1880                                                % greennew
    0.3010  0.7450  0.9330                                                % lightbluenew
    0.4940  0.1840  0.5560                                                % purplenew
    0.6350  0.0780  0.1840                                                % brownnew                                     
    0.9290  0.6940  0.1250];                                              % yellownew
                                                                          % This means that on average, the matrix is only resized once, in the step that goes over                                                                          
                                                                          % the preallocated size, since it is enlarged in increments of 14.                                                                          
if LPData.QS==false %#ok<*BDSCA>                                          % normal Procedure
    if isfield(LPData,'PseudoQScolors')  && LPData.PseudoQScolors==true   % path for LPQS-like color presetting by defining PseudoQScolors as 1/true
        NumColorRows=size(LPData.colors,1);
        while NumColorRows<LPData.NumRows                                 % colors-matrix is duplicated till it is bigger than the number of rows.
            LPData.colors=[LPData.colors;LPData.colors];                  % Overshoots the size in general, but needs fewer loops the more objects are plotted.
            NumColorRows=size(LPData.colors,1);
        end
        disp('LPQS-like colors were chosen on normal path. [LPColorfun2]')
    else
        switch questdlg('Do we want a custom color order?','Custom c.-order?','Yes.','No.','No.')
            case 'Yes.'                                                   % Colormatrix contains all standard colors for plotting. Chosen color is added to a matrix which is used by other functions
                LPColorlist={'redold','blueold','greenold','cyanold','magentaold','blackold','yellowold','bluenew','orangenew','yellownew','purplenew','greennew','lightbluenew','brownnew'};
                for k=1:1:LPData.NumRows
                    LPData.colors(k,:)=LPData.colors(listdlg('ListString',LPColorlist,'PromptString','Select Color','SelectionMode','Single','Listsize',[160 200]),:);
                end
            case 'No.'
                NumColorRows=size(LPData.colors,1);
                while NumColorRows<LPData.NumRows                         % colors-matrix is duplicated till it is bigger than the number of rows. Overshoots the size in general, but needs fewer loops the more objects are plotted.
                    LPData.colors=[LPData.colors;LPData.colors]; %#ok<*AGROW>
                    NumColorRows=size(LPData.colors,1);
                end
            otherwise                                                     % Fallback for pressing esc/closing the window
                warning('Error occured. No user input detected. Fallback: Standard colors. [LPColorfun2]')
                NumColorRows=size(LPData.colors,1);
                while NumColorRows<LPData.NumRows                         % colors-matrix is duplicated till it is bigger than the number of rows. Overshoots the size in general, but needs fewer loops the more objects are plotted.
                    LPData.colors=[LPData.colors;LPData.colors];
                    NumColorRows=size(LPData.colors,1);
                end
        end
    end
else                                                                      % LPQS procedure=true
    NumColorRows=size(LPData.colors,1);
    while NumColorRows<LPData.NumRows                                     % colors-matrix is duplicated till it is bigger than the number of rows. Overshoots the size in general, but needs fewer loops the more objects are plotted.
        LPData.colors=[LPData.colors;LPData.colors];
        NumColorRows=size(LPData.colors,1);
    end
end
end


% ------------- END OF CODE -------------
