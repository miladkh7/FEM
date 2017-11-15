classdef Section
    %SECTION Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        name;
        material;
        profile;
    end
    
    methods
        function this=Section(name,material,profile,materials,profiles)
%            materials
%            material
            try
                this.name=name;
                
                if isa(material,'Material') ; this.material=material;end
                if isa(profile,'Profile') ;this.profile=profile;end
%               materials
%               {this.Materials.name}'
                if isa(material,'char')
                  matrialIndex=find(strcmp({materials.name}',material));
                  this.material=materials(matrialIndex);   %#ok
                end
                if isa(profile,'char')
                  profileIndex=find(strcmp({profiles.name}',profile));
                  this.profile=profiles(profileIndex) ; %#ok
                end
            catch 
%                 
            end
        end
    end
    
end

