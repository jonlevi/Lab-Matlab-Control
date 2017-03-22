function obj_ = loadobj(obj_)% overloaded idiot fixer for classes whose fields have changed.if isstruct(obj_)    class_name = mfilename('fullpath');    cni = strfind(class_name, '@');    class_name = class_name(cni+1:end-8);    N = size(obj_, 2);    if N>0        try            % get new fields, which are by definition valid            ostr = struct(feval(class_name, N));            % try to match old field values to new fields            for fn = intersect(fieldnames(ostr), fieldnames(obj_))'                [ostr.(fn{1})] = deal(obj_.(fn{1}));            end            % convert struct to object            obj_ = class(ostr, class_name);        catch            % ultimate failure            disp([class_name, ' is a struct'])        end    endend