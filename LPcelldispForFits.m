function LPcelldispForFits(someCell) 
% LPcelldispForFits - inserts difference error-to-mainval to fits in cell
% array
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% If someCell contains solely fits, celldispForFits will calculate the
% value
% (upperBound - mainValue) 
% and insert that value behind the standard display of lower and upper
% bound of te corresponding fit parameter. 
% 
% Syntax:
%     celldispForFits(someCell) 
%
% Inputs (vital):
%   - someCell:
%       - cell, contains the fits to be edited and displayed.
% 
%   - someCell
%       - cfit, lets celldispForFits operate on a single cfit-object.
%   
% Inputs (optional):
%   -
%   
% Outputs:
%   - display edited fits message.
%   
% Example:
%   -
% 
% Other m-files required: none
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Subfunctions: editMessage
% MAT-files required: none
%
% See also: - 
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Author: Uday Pradhan, on MATLAB Answers
% Link to the answer:
% https://de.mathworks.com/matlabcentral/answers/588658-calculating-and-printing-uncertainties-of-fits-after-the-normal-display-of-fit-parameters#answer_490582
%
%
% Retrieved: 06-Sep-2020 ; Last revision: 19-Dec-2020

% ------------- BEGIN CODE --------------


s = inputname(1);
if class(someCell) == 'cfit' %#ok<*BDSCA>
    for i = 1:numel(someCell)
        modelDetails=evalc('disp(someCell)'); %get the display message as a char array
        strMessage = editMessage(modelDetails,someCell); %get the updated message
        fprintf('\nFit ');
        disp([s subs(i,size(someCell)) ' =']) %taken this from the original celldisp function
        fprintf('\n');
        disp(strMessage);
    end
elseif class(someCell) == 'cell'
    for i = 1:numel(someCell)
        modelDetails=evalc('disp(someCell{i})'); %get the display message as a char array
        strMessage = editMessage(modelDetails,someCell{i}); %get the updated message
        fprintf('\nFit ');
        disp([s subs(i,size(someCell)) ' =']) %taken this from the original celldisp function
        fprintf('\n');
        disp(strMessage);    
    end
end
function s = subs(i,siz)
    %SUBS Display subscripts
    if length(siz)==2 && any(any(siz==1))
        v = cell(1,1);
    else
        v = cell(size(siz));
    end
    [v{1:end}] = ind2sub(siz,i);
    s = ['{' int2str(v{1})];
    for i=2:length(v)
        s = [s ',' int2str(v{i})]; %#ok<*AGROW>
    end
    s = [s '}'];
end
end


function s = editMessage(modelDetails,f) %f = fit Object, modelDetails the original displayed message

displayStr = split(modelDetails,newline); %split the message with respect to newline delimiter
displayStr = displayStr(~cellfun('isempty',displayStr)); %remove the empty arrays that may occur
var = 4; %line number in the message from which editing is required

for i = 1 : numel(displayStr) %loop through each line in the message
    k = 1;
    while displayStr{i}(k) == ' '
        k = k + 1; %for each line search for the first word
    end
    str = "";
    while displayStr{i}(k) ~= ' '
        str = str + displayStr{i}(k);
        k = k + 1;  %get the first word in the line
    end
    if str == "Coefficients"
        var = i + 1; %if the word is Coefficients store the next line number
        break; %this is the line number from which we need to start editing the message
    end
end

coeffVals = coeffvalues(f);
confidenceInt = confint(f);
toAdd = [""]; %#ok<NBRAK> %new edits to be inserted

for i = 1:numel(coeffVals)
    
    if confidenceInt(2,i) - coeffVals(i) > 0e4 || confidenceInt(2,i) - coeffVals(i) <0e-4
        toAdd(i) = num2str(confidenceInt(2,i) - coeffVals(i),'%10.4e');
    else
        toAdd(i) = num2str(confidenceInt(2,i) - coeffVals(i));
    end



%this stores each value in exponential format with two decimal places
end

idx = 1;

for i = var : numel(displayStr) %from the line number in var till the end
    displayStr{i} = displayStr{i} + "  +-  " +  toAdd(idx); %make the required edits
    idx = idx + 1;
end

finalStr = "";

for i = 1:numel(displayStr)
    finalStr = finalStr + displayStr(i) + newline; %create the new message to display
end

s = finalStr;

end

% ------------- END OF CODE -------------
