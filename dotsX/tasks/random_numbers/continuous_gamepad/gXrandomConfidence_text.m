function text_ = gXrandomConfidence_text

% text and lines for the continuous/gamepad task

% tick marks
n = 5;
maxDeg = 30;
maxEarn = 20;

% make log spacing for graphics and earnings
%tickEarn = maxEarn-fliplr([0, (2.^(0:n-2))*maxEarn/(2.^(n-2))]);
%tickDeg = (maxDeg*tickEarn/maxEarn) - maxDeg/2;
 tickEarn = (maxEarn./n).*(linspace(0, n, 5))
 tickDeg  = (maxDeg*tickEarn/maxEarn) - maxDeg/2


% #1 = randomly generated number
% #2 = subject's estimate of the "average"
% #3 = error between 1 and 2
% #4 = holder for randomly generated alpha value
% #5 = constant label for 3
% #6-? = lables for earnings tick marks    *color=black=poor mans delete
% #6+n = text storage of confidence estimate   * this is off the screen


arg_dXtext = { ...
    'size',     num2cell([60, 60, 40, 1, 40, 30*ones(1,n), 1]), ...
    'string',   cat(2, {'', '0', '', 'start', 'last error'}, num2cell(tickEarn), '0'),...
    'x',        num2cell([-16, -16, -666, 100, -666, tickDeg, 100]), ...
    'y',        num2cell([5, -3, 666, 100, 666, -1000*ones(1,n), 100]), ...
    'visible',  true, ...
    'color',    num2cell( ...
    [0 0 200; 255 255 0; 0 255 255; 0 0 0; 0 255 255;...
    repmat([192 0 0], n, 1); 255 255 0], 2)};

% #1 = randomly generated number
% #2 = subject's estimate of the "average"
% #3 = error between 1 and 2
% #4,5 = constant lines
% #6 growing bar for total session earnings            
% #7-7+n-1 = tick marks for possible session earnings  
% #7+n = confidence line   --12--
% #13-24 = confidence ticks
NUM_LINES = 30;
arg_dXline = { ...
    'x1',       num2cell([-15, -15, 0, -15, -15, tickDeg(1), tickDeg, -15,ones(1,NUM_LINES).*18]), ...
    'y1',       num2cell([1, 0, .5, 2, -1, -11.5, -11*ones(1,n), -2,ones(1,NUM_LINES).*-1.8]), ...
    'x2',       num2cell([-15, -15, 0, 15, 15, tickDeg(1), tickDeg, -15,ones(1,NUM_LINES).*18]), ...
    'y2',       num2cell([2, -1, .5, 2, -1 -11.5, -12*ones(1,n), -2, ones(1,NUM_LINES).*-2.2]), ...
    'visible',  true, ...
    'penWidth', num2cell([5, 5, 5, 3, 3, 20, 2*ones(1,n), 5, ones(1,NUM_LINES).*3]), ...
    'color',    num2cell( ...
    [0 0 255; 255 255 0; 0 255 255; 255 255 255; 255 255 255; ...
    0 192 0; repmat([192,0,0], n, 1); 255 255 0; repmat([255,255,0], NUM_LINES, 1);] ...
   , 2)'};



tony = {'current', false, true, true};
text_ = { ...
    'dXtext',  6+n,	tony,	arg_dXtext; ...
    'dXline',  7+n+NUM_LINES,	tony,	arg_dXline; ...
    };
