function val_ = get(vt, propertyName)%get method for class dXvirtualTexture: query property values%   val_ = get(vt, propertyName)%%   All DotsX classes have a get method which returns a specified property%   for a class instance, or a struct containing the values of all the%   properties of one or more instances.%%----------Special comments-----------------------------------------------%-%%-% Overloaded get method for class dXvirtualTexture%-% get the value of a particular property from%-% the specified dXvirtualTexture object%----------Special comments-----------------------------------------------%%   See also get dXvirtualTexture% Copyright 2007 by Benjamin Heaslt%   University of Pennsylvania% just return the value of the given fieldnameval_ = vt(1).(propertyName);