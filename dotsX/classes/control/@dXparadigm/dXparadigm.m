function [p_, attributes_, batchMethods_] = dXparadigm(num_objects)% function [p_, attributes_, batchMethods_] = dXparadigm(num_objects)%% Creates a dXparadigm object, which defines and controls an experiment%% Arguments:%   num_objects    ... ignored (should always be one)%% Returns:%   p_             ... created paradigm object%   attributes_    ... default object attributes%   batchMethods_  ... methods that can be run in a batch (e.g., draw)%% Attributes:%% name             ... string% taskList         ... cell array (rows are tasks): %                       {<str_name_t1>, <dbl_reps_t1>, <cell_args_t1>; ...}%                      used by dXparadigm/loadTasks to creates task named %                       'str_name_t1' using cell array of arguments%                       <cell_args_t1> (sent to task-specific generator function), %                       with <dbl_reps_t1> number of repetitions (i.e., %                       used to set the value of taskProportions, below)% taskProportions  ... used as weighting values for random selection of the current task%                       for taskOrder values of 'randomTaskByTrial' and%                       'randomTaskByBlock', below.% taskOrder        ... string, determines how the next task is selected in dXparadigm/runTasks%                       'blockTasks': run each task one at a time, in order they were set up;%                                       move on to the next only after each%                                       one runs out of trials%                       'randomTaskByTrial': after each trial, randomly select a task%                                       weighed by the "taskProportions" values associated%                                       with each task (e.g., if you have two tasks with %                                       taskProportions = [1 2], the second task will be %                                       selected twice as often as the first).%                       'randomTaskByBlock': same random selection process as 'randomTaskByTrial',%                                       but done only after the current task has run%                                       out of trials (which might or might not be%                                       different for the different tasks)%                       'freeChoice': uses currrent value of ROOT_STRUCT.dXparadigm->taski%                                       (which can be set by user)%                       'repeatTrial': uses the same trial from the same task as last trial% screenMode        ... for rInit (string)%                       'remote': communicates via UDP with slave running rRemoteClient%                       'local' : all graphics are shown on the host machine (nice to have second screen)%                       'debug' : no graphics, most everything should work to set up data structures for debugging% fileSuffixMode    ... for generating ROOT and FIRA data files%                       'immediate': %                       'session'  :% timeLimit         ... (double, in minutes; default = inf) %                           time limit for running paradigm from dXparadigm/runTasks% trialLimit        ... (double, default = inf)%                           trial limit for running paradigm from dXparadigm/runTasks% Copyright 2004 by Joshua I. Gold%   University of Pennsylvania% jig changed 12/1/08: added pointer to ROOT_STRUCT dataDirdir = mfilename('fullpath');cli = strfind(dir,'/classes');rootSave = [dir(1:cli), 'tasks'];% save FIRA in some local dir '...Matlab/Data' or in ...DotsX/mati = strfind(dir,'/Matlab');if isempty(mati)    firaSave = dir(1:cli);else    firaSave = [dir(1:mati), 'Data'];end% whip up a struct to show feedback about this paradigmfeedbackSelect = { ...    'showPctGood',      false; ...    'showNumGood',      false; ...    'showGoodRate',     false; ...    'showPctCorrect',   false; ...    'showNumCorrect',   false; ...    'showCorrectRate',  false; ...    'showTrialCount',   false; ...    'showMoreFeedback', false};feedbackSelect = cell2struct(feedbackSelect(:,2), feedbackSelect(:,1), 1);% default object attributesattributes = { ...    % name                  type		ranges  default    'name',                 'string',   [],     'newParadigm'; ...    'taskList',             'cell',     [],     {}; ...    'taskProportions',      'double',   [],     []; ...    'repeatAllTasks',       'scalar',   [],     0; ...    'taskOrder',            'string',   {'blockTasks', 'randomTaskByTrial', 'randomTaskByBlock', 'freeChoice', 'repeatTrial'}, 'blockTasks'; ...    'screenMode',           'string',   {'remote', 'local', 'debug'}, 'debug'; ...    'fileSuffixMode',       'string',   {'immediate', 'session'}, 'session'; ...    'timeLimit',            'double',   [],     inf; ... % in minutes    'trialLimit',           'double',   [],     inf; ...    'goodTrialLimit',       'double',   [],     inf; ...    'saveToFIRA',           'boolean',  [],     true; ...    'showFeedback',         'boolean',  [],     false; ...    'feedbackSelect',       'struct',   [],     feedbackSelect; ...    'moreFeedback',         'string',   [],     []; ...    'moreFeedbackFunction', 'string',   [],     []; ...    'userData',             'string',   [],     []; ... % added 4/20/09 by jig    'sessionTime',          'auto',     [],     clock; ...    'totalTrials',          'auto',     [],     0; ...    'goodTrials',           'auto',     [],     0; ...    'correctTrials',        'auto',     [],     0; ...    'paradigmGUI',          'auto',     [],     false; ...    'GUISetQueue',          'auto',     [],     {}; ...    'taski',                'auto',     [],     1; ...    'iti',                  'auto',     [],     1; ... % in seconds    'proportionsCopy',      'auto',     [],     []; ...    ...    'ROOT_saveDir',         'string',   [],     rootSave; ...    'ROOT_filenameBase',    'string',   [],     'ROOT_STRUCT'; ...    'ROOT_writeInterval',   'double',   [],     60; ... % in seconds    'ROOT_doWrite',         'boolean',  [],     false; ...    'ROOT_nextWrite',       'auto',     [],     inf; ...    ...    'FIRA_saveDir',         'string',   [],     firaSave; ...    'FIRA_filenameBase',    'string',   [],     'FIRA'; ...    'FIRA_writeInterval',   'double',   [],     30; ... % in seconds    'FIRA_doWrite',         'boolean',  [],     false; ...    'FIRA_nextWrite',       'auto',     [],     inf};% make an object from a struct made from the attributes made by a person made by Godp_ = class(cell2struct(attributes(:,4), attributes(:,1), 1), 'dXparadigm');% return the attributes, if necessaryif nargout > 1    attributes_ = attributes;endif nargout > 2    batchMethods_ = {'root'};end