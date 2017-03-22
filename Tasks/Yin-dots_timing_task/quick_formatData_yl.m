function qdat_ = quick_formatData_yl(dat)%% converts trial-based data to a matrix% used by quick_fit%% input: %  dat  ... [coh correct] x trials% % returns:%  qdat ... [cohs pct_correct num_trials] x cohs% %   adapted from JIG's code%   2010-09-09:  does not discard data for intensity == 0,1 (YL)%stim = unique(dat(:,1)); % for each stim intensity, find % correctresp = zeros(1,length(stim));for i = 1:length(stim)     stimIndex = dat(:,1)==stim(i);     resp(i) = (sum(dat(stimIndex,2)))/sum(stimIndex); endqdat_(:,1) = stim;qdat_(:,2) = resp;% cbins  = unique(dat(:,1));% qdat_  = nans(length(cbins), 3);% % for cc = 1:length(cbins)%   Lc = dat(:,1) == cbins(cc);%   qdat_(cc,:) = [cbins(cc) sum(dat(Lc,2))/sum(Lc) sum(Lc)];% end% 