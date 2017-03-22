function s_ = root(s_, varargin)% s_ = root(s_, varargin)%% Overloaded root method for class dXsaveToFIRA:%   set up or clean up system resources for a dXasl object%% Updated class instances are always returned.%%----------Special comments-----------------------------------------------%-%%-% Sets up and cleans up a 'dXsaveToFIRA' object, typically%-%   called by rAdd, rClear or rDone.%-%%-% Usage:%-%     root(a, 'clear')  cleans up%-%     root(a, varargin) optional list of args to send to set%----------Special comments-----------------------------------------------%% see also root, dXsaveToFIRAglobal FIRA% root(s, 'clear') means clean up%   otherwise initialize%   either way, check for FIRA and ask to saveif ~isempty(FIRA)    if isempty(s_.filename)        % open a dialog asking whether it should be saved        if strcmp('Yes', questdlg('Do you want to save the existing FIRA?', ...                'FIRA open', 'Yes', 'No', 'Cancel', 'Yes'))            [s_.filename,s_.pathname] = uiputfile('*.*', 'Select filename for writing');        end    end    if ~isempty(s_.filename) && ~strcmp(s_.filename, 'none')        saveFIRA(fullfile(s_.pathname, s_.filename));    endend    % If we are initializing, clear FIRA and call set methodif isempty(varargin) || ~(ischar(varargin{1}) && strcmp(varargin{1}, 'clear'))    clear global FIRA    s_ = set(s_, varargin{:});end