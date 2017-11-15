classdef Part1D
    %PART1D Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name;
        section;
        startPoint;
        endPoint;
        lengthp;
    end
    
    methods
        %method saznde
        function this=Part1D(varargin)
            p=inputParser();
            p.CaseSensitive=false;
            p.addParameter('name','Part-');
            p.addParameter('startp',0);
            p.addParameter('endp',1);
            p.addParameter('lengthp',1);
            p.parse(varargin{:});
            this.name=p.Results.name;
            this.lengthp=p.Results.lengthp;
            if p.Results.endp>p.Results.startp 
                this.startPoint=p.Results.startp;
                this.endPoint=p.Results.endp;
            else
                warning('end Point shuld be greeter than Star Point');
            end
            
        end
    end
    
end

