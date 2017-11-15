classdef Material<handle
    %MATERIALS Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name %name of material
        E    %Young modules of materails
        
    end
    
    
    methods
        
        %tabe sazande        
        function this=Material(varargin)
            p=inputParser();
            p.CaseSensitive=false;
            p.addParameter('No',1);
            p.addParameter('E',200e9);
            p.addParameter('name','Material-');  
            p.parse(varargin{:});
            this.name=p.Results.name;
            this.E=p.Results.E;
        end
    end
    
    

    
end

