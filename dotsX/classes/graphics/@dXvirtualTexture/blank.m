function vt_ = blank(vt_)%blank method for class dXvirtualTexture: hide instances%   vt_ = blank(vt_)%%   All DotsX graphics classes have blank methods.  These hide class %   instances by setting their visible properties to FALSE.%%   Updated class instances are always returned.%%----------Special comments-----------------------------------------------%-%%-% Overloaded blank method for class dXvirtualTexture%-%%-% Just sets all the visible flags to 0.%----------Special comments-----------------------------------------------%%   See also blank dXvirtualTexture% Copyright 2007 by Benjamin Heasly[vt_.visible] = deal(false);