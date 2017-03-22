function index_ = taskRandomContinuous(varargin)
%Decide if the next in the sequence of numbers will be greater
%
%   index_ = taskRandomContinuous(varargin)
%
%   no eye tracker
%   gamepad or kbHID choices
%
%   varargin gets passed to dXtask/set via rAdd.
%
%   index_ specifies the new instance in ROOT_STRUCT.dXtask

% copyright 2007 Benjamin Heasly University of Pennsylvania
varargin
if nargin
    arg_helpers = {varargin{1}, varargin{2}, false, varargin{5}}; % false refers to useASL
    half        = varargin(3);
    cue         = varargin(4);  
    HHvar       = varargin(5);
	twoDist     = varargin(6);
    varargin(1:6) = [];

else
    arg_helpers = {[]};
end

feedbackSelect = { ...
    'showPctGood',      false; ...
    'showNumGood',      false; ...
    'showGoodRate',     false; ...
    'showPctCorrect',   false; ...
    'showNumCorrect',   false; ...
    'showCorrectRate',  false; ...
    'showTrialCount',   false; ...
    'showMoreFeedback', true};
feedbackSelect = cell2struct(feedbackSelect(:,2), feedbackSelect(:,1), 1);

ptrs = { ...
    'estimate', 'dXtext', 2, 'string'; ...
    'start',    'dXtext', 4, 'string'};
arg_dXtask = { ...
    'statesToFIRA', { ...
    'waitMove',     3; ...
    'newNumber',    1; ...
    'end',          1}, ...
    'objectsToFIRA',    {'saveToFIRA'}, ...
    'ptrsToFIRA',       ptrs, ...
    'anyStates',        {'end'}, ...
    'wrtState',         'waitMove', ...
    'trialOrder',       'random', ...
    'timeout',          1e6, ...
    'feedbackSelect',   feedbackSelect, ...
    'moreFeedbackFunction', @errorFeedback, ...
    'showFeedback',     true, ...
    'userData',         0};

name = mfilename;
index_ = rAdd('dXtask', 1, {'root', false, true, false}, ...
    'name',	name(5:end), ...
    'blockReps', 1, ...
    'bgColor', [0,0,0], ...
    'helpers', { ...
    'gXrandomContinuous_text',        1,  true,     []; ...
    'gXrandomContinuous_helpers',     1,  true,     arg_helpers; ...
    'gXrandomContinuous_statelist',   1,  false,    {half, cue}}, ...
    arg_dXtask{:}, varargin{:});