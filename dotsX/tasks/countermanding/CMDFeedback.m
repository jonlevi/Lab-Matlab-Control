function feedback = CMDFeedback(dXp)
% generate a string which previews the upcoming task
%
%   This is a hack.  dXtasks probably should hold these strings.  Whatever.
%
%   feedback = randomFeedback(dXp)

% copyright 2006 Benjamin Heasly
%   University of Pennsylvania


global FIRA
global ROOT_STRUCT


if dXp.repeatAllTasks < 0
    
GTindex = getFIRA_ecc('good_trial')
CORindex = getFIRA_ecc('correct')
INCindex = getFIRA_ecc('incorrect')
TRNUMindex = getFIRA_ecc('trial_num')

%%getting data for the variables of interest

good  = FIRA.ecodes.data(:, GTindex)
cor   = FIRA.ecodes.data(:, CORindex)
inc   = FIRA.ecodes.data(:, INCindex)
trnum = FIRA.ecodes.data(:, TRNUMindex)

realcor  = ~isnan(cor)

total_income = sum(good*0.02) + sum(realcor*.02)
    
feedback = sprintf('You have earned a total of $%1.2f    -   ALL DONE', total_income);

else
    
    switch rGet('dXtask', dXp.taski, 'name')

        % discrete random numbers

        case {'VGS', 'SSD'}
            
            if isempty(FIRA)
                
                feedback = 'PULL LEVER to INITIATE TASK'
                
            else

                GTindex = getFIRA_ecc('good_trial')
                CORindex = getFIRA_ecc('correct')
                INCindex = getFIRA_ecc('incorrect')
                TRNUMindex = getFIRA_ecc('trial_num')

                %%getting data for the variables of interest

                good  = FIRA.ecodes.data(:, GTindex)
                cor   = FIRA.ecodes.data(:, CORindex)
                inc   = FIRA.ecodes.data(:, INCindex)
                trnum = FIRA.ecodes.data(:, TRNUMindex)

                realcor  = ~isnan(cor)

                total_income = sum(good*0.02) + sum(realcor*.02)  
                
                feedback = sprintf('So far you have earned a total of $%1.2f    -   PULL LEVER to INITIATE TASK', total_income);

            end
            
        otherwise

            feedback = 'Get Excited!';
    end
end  