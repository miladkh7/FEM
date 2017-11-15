classdef Profile
    %PROFILE Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name; %name of profile
        
        %type of profile such as RECT or Circle Or Sepecific
        type; 
        area; %Area of profile
        a; % width of REC
        b; % heigh of REC
        r; %radio of Circle
    end
    
    methods
        
      %Method Sazande
      function this=Profile(varargin)          
            p=inputParser();
            p.CaseSensitive=false;
            p.addParameter('No',1);
            p.addParameter('type','RECT');
            p.addParameter('area',.1);
            p.addParameter('name','Profile-');
            p.addParameter('a',.01); 
            p.addParameter('b',.01); 
            p.addParameter('r',.01); 
            p.parse(varargin{:});
            this.name=p.Results.name;
            switch p.Results.type
                case 'RECT'
                   this.type='RECT';
                   this.a=p.Results.a;
                   this.b=p.Results.b;
                   this.area=this.a*this.b;
                case 'CRIC'
                    this.type='CRIC';
                    this.r=p.Results.r;
                    this.area=pi()*this.r^2;
                case 'SPC'
                  this.type='SPC'; 
                  this.area=p.Results.Area; 
                otherwise
                   this.type='RECT';
                   this.a=p.Results.a;
                   this.b=p.Results.b;
                   this.area=this.a*this.b;   
            end
          
          
      end
      
    end
    
end

