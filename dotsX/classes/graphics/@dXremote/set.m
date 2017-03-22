function r_ = set(r_, varargin)%set method for class dXremote: specify property values and recompute dependencies%   r_ = set(r_, varargin)%%   All DotsX classes have set methods which allow properties for one or%   more instances to be specified, and dependent values recomputed.%%   Updated class instances are always returned.%%----------Special comments-----------------------------------------------%-%%-% Overloaded set method for class dXremote%-%%-% Assigns properties to 'dXremote' object(s)%-% and returns the updated object(s). First time%-% through (r_.created is false), sends an "rAdd"%-% command; in this case, varargin is expected%-% to contain several initial arguments, just like rAdd:%-%     {class name, indices, {args}, ...}%-%%-% where args contains up to 4 elements:%-%     {group_name, reuse, call_set, save_set}%-%%-% Otherwise an "rSet" command is generated and sent.%-%%-% 27 June 2007: BSH moved makeString and parseVal subfunctions to%-% DotsX/utilities so others can access them (like dXscreen/set).%-%%-% 20 May 2008: BSH renamed parseVal->variable2String and%_% makeString->args2String%-%%----------Special comments-----------------------------------------------%%   See also set dXremote% Copyright 2006 by Joshua I. Gold%   University of Pennsylvania% shouldn't happenif nargin < 2    returnend% Determine whether remote client should rAdd or rSet:%   check 'created', field%   check for rAdd-style 'args' cellif r_(1).created && ~(nargin > 3 && iscell(varargin{3}))    if length(r_) > 10 && r_(end).index == length(r_)        indS = sprintf('1:%d', length(r_));    else        indS = sprintf('%d ', [r_.index]);    end    % create rSet command    if nargin == 1        % no properties to set        sendMsgH(['rSet(''' r_(1).class ''',[' indS ']);']);        return    elseif nargin == 2 && ischar(varargin{1})        % arglist is already a string...        sendMsgH(['rSet(''' r_(1).class ''',[' indS '],' ...            varargin{1} ');']);        eval(['varargin={' varargin{1} '}']);    else        % parse arglist        sendMsgH(['rSet(''' r_(1).class ''',[' indS ']' ...            args2String(varargin) ');']);    endelse    % Creating for the first time    class_name = varargin{1};    % set up the local fields    [objects, attributes] = feval(class_name, 1);    Lgood  = ~strcmp('auto', attributes(:, 2));    fields = cell2struct( ...        attributes(Lgood,4), attributes(Lgood,1), 1);    % parse first set of args...    % class_name, inds_, reuse_flag, save_flag    [r_.class]   = deal(class_name);    [r_.created] = deal(true);    inds         = varargin{2};    for ii = 1:length(r_)        r_(ii).index  = inds(ii);        r_(ii).fields = fields;    end    % create rAdd command    if nargin == 4        % no properties to set        sendMsgH(sprintf('rAdd(''%s'',%d,%s);',...            class_name, size(inds,2), variable2String(varargin{3})));        return    elseif nargin == 5 && ischar(varargin{4})        % arglist is already a string        sendMsgH(sprintf('rAdd(''%s'',%d,%s,%s);',...            class_name, size(inds,2), variable2String(varargin{3}), varargin{4}));        eval(['varargin={' varargin{4} '}']);    else        % parse arglist        sendMsgH(sprintf('rAdd(''%s'',%d,%s%s);',...            class_name, size(inds,2), variable2String(varargin{3}), ...            args2String(varargin(4:end))));        varargin = varargin(4:end);    endend% loop through the arguments, setting LOCALLY% set the fields, one at a time.. no error checkingif length(r_) == 1    % set one object    for ii = 1:2:size(varargin,2)        r_.fields.(varargin{ii}) = varargin{ii+1};    endelse    % set many objects  ... a cell means separate    %   values given for each object; otherwise    %   the same value is set for all objects    % First we get an array of "fields" structures    fields = [r_.fields];    inds=ones(size(r_));    for ii = 1:2:size(varargin,2)        % change it        if iscell(varargin{ii+1}) && ~isempty(varargin{ii+1})            [fields.(varargin{ii})] = deal(varargin{ii+1}{:});        else            [fields.(varargin{ii})] = deal(varargin{ii+inds});        end    end    % re-set fields    for ii = 1:size(r_, 2)        r_(ii).fields = fields(ii);    endend