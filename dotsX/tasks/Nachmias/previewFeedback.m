function feedback = previewFeedback(dXp)
% generate a string which previews the upcoming task
%
%   This is a hack.  dXtasks probably should hold these strings.  Whatever.
%
%   feedback = previewFeedback(dXp)

% copyright 2006 Benjamin Heasly
%   University of Pennsylvania

global ROOT_STRUCT

if dXp.repeatAllTasks < 0

    feedback = 'All done.';

else

    switch rGet('dXtask', dXp.taski, 'name')

        % Dots
        case 'DetectLDots'
            feedback = 'Next: pick "certainly left"(left lever) or "not certain"(both levers)';

        case 'DetectRDots'
            feedback = 'Next: pick "certainly right"(right lever) or "not certain"(both levers)';

        case 'Discrim2afcDots'
            feedback = 'Next: pick "left"(left lever) or "right"(right lever)';

        case 'Discrim3afcDots'
            feedback = 'Next: pick "left"(left lever), "right"(right lever), or "I can only guess"(both levers)';

            % Contrast
        case 'DetectDownContrast'
            feedback = 'Next: pick "certainly dark"(left lever) or "not certain"(both levers)';

        case 'DetectUpContrast'
            feedback = 'Next: pick "certainly bright"(right lever) or "not certain"(both levers)';

        case 'Discrim2afcContrast'
            feedback = 'Next: pick "dark"(left lever) or "bright"(right lever)';

        case 'Discrim3afcContrast'
            feedback = 'Next: pick "bright"(right lever), "dark"(left lever), or "I can only guess"(both levers)';

        case 'ModalityEye'
            feedback = 'Next: respond by looking at the targets.';

        case 'ModalityLever'
            feedback = 'Next: respond by pulling the levers.';

        otherwise
            feedback = 'Next: Unknown task!';
    end
end  