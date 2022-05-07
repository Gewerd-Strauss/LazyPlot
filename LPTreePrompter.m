function selection = LPTreePrompter(tree)
% LPTreePrompter is used to choose the LPFittypeindx for LazyPlot
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% tree: a table with variables 
% Node, Parent, IsLeaf, Title, Prompt, Width, Height, ReturnValue
% allowbackup: optional flag (default true)
% selection: tree.ReturnValue of selected option or empty if cancelled
% Function chooses the fittype for the fitfunction. Paths are reversible
% (except if you choose a final output)
% ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
% Syntax:  
%     selection = LPTreePrompter(tree)
% 
% Inputs (vital):
%   LPfittypeindxtable.mat
% 
% Inputs (optional):
%   -
% 
% Outputs:
%   LPData - structure with fields:
%            -fittypeindx (strictly speaking it outputs [selection], but
%            that is stored in the mainfile in a field called "fittypeindx"
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
% MAT-files required: LPfittypeindxtable.mat
% 
% See also: LPfittypeindxtable.mat
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
if nargin < 2
    allowbackup = true;
end                                                                       % todo: validate inputs. May also want to check that the tree entries are consistent       
currentrow = find(tree.Node == 0);                                        % initialise navigation
selection = [];
while true                                                                % navigate the tree
    childrenrows = find(tree.Parent == tree.Node(currentrow));            % can't use logical array as we'll need to index into the children array
    options = tree.Title(childrenrows);
    if allowbackup && tree.Node(currentrow) ~= 0                          % don't allow backup at root
        options = [options; {'Back one level'}]; %#ok<AGROW>
    end
    selectedentry = listdlg('ListString', options, ...
        'PromptString', tree.Prompt{currentrow}, ...
        'Name', tree.Title{currentrow}, ...
        'SelectionMode', 'single', ...
        'ListSize', tree{currentrow, {'Width', 'Height'}});
    if isempty(selectedentry)
        return;                                                           % user cancelled
    end
    if selectedentry > numel(childrenrows)                                % can only be back up
        currentrow = find(tree.Node == tree.Parent(currentrow));          % go back to parent
    else
        currentrow = childrenrows(selectedentry);
        if tree.IsLeaf(currentrow)                                        % navigation completed
            selection = tree.ReturnValue(currentrow);
            return;
        end
    end
end
end


% ------------- END OF CODE -------------
