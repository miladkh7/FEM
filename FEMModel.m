classdef FEMModel<handle
    %FEMMODEL Summary of this class goes here
    %   Detailed explanation goes here
    
    properties(SetAccess=private)
        Parts;
        Materials;
        Profiles;
        Sections;
        
        Steps;
        Loads;
        BCs;
        nodes;
        
        pointloads;
        constraints;
        bodyloads;
        tractions;
        deleted;
        Fmatrix
        Kmatrix
        Qmatrix
        Rmatirx
        elements
        
    end
    properties(SetAccess=private)
    NumberOfNoNameParts=0;
    NumberOfNoNameMaterials=0;
    NumberOfNoNameProfiles=0;
    NumberOfNoNameSections=0;
    NumberOfParts=1;
    NumberOfMaterials=1;
    NumberOfProfiles=1;
    NumberOfSections=1;
    end
    
    methods
        %Tabe sazande
        function this=FEMModel()
         this.Parts=repmat(Part1D('name',1),0,1); 
         this.Materials=repmat(Material('NO',1),0,1);  
         this.Materials=repmat(Material('NO',1),0,1);   
         this.Profiles=repmat(Profile('NO',1),0,1); 
         this.Sections=repmat(Section('','','','',''),0,1);
        end
%% Add Property to MODEL        
    
        function CreatePart(this,type,varargin)
             checkNameResult=this.CheckName({this.Parts.name}',varargin{:});
            if checkNameResult>2;error('this Part already exist and can''t be overwritten');end
            if checkNameResult==1;this.NumberOfNoNameParts=this.NumberOfNoNameParts+1;end
            defulatname=['Part-' num2str(this.NumberOfNoNameParts)];

            switch type
                case '1D'
                    
                     partLength=cell2mat(FEMModel.FindValueInCell('lengthp',varargin{:}));
                     if partLength<=0 ;error('length of 1D part must be greeter than 1');end
                     
                     if isempty(this.Parts)
                         partStartPoint=0;
                     else
                         partStartPoint= this.Parts(length(this.Parts)).endPoint;
                     end
                     
                     partEndPoint=partStartPoint+partLength;
%                     in this state parts extend to geter
                    this.Parts(length(this.Parts)+1,1)= Part1D('name',defulatname,'startp',partStartPoint,'endp',partEndPoint,'lengthp',partLength,varargin{:});
                       
                otherwise
                    
            end
            
            this.NumberOfParts=this.NumberOfParts+1;
        end

        %Create new Material And Added it on Model
        function CreateMaterial(this,varargin)
            checkNameResult=this.CheckName({this.Materials.name}',varargin{:});
            if checkNameResult>2;error('this Material already exist and can''t be overwritten');end
            if checkNameResult==1;this.NumberOfNoNameMaterials=this.NumberOfNoNameMaterials+1;end
            defulatname=['Material-' num2str(this.NumberOfNoNameMaterials)];
            this.Materials(length(this.Materials)+1,1)=Material('name',defulatname,varargin{:});
            this.NumberOfMaterials=this.NumberOfMaterials+1;
        end
             
        %Create new Profile And Added it on Model
        function CreateProfile(this,varargin)
            
            checkNameResult=this.CheckName({this.Profiles.name}',varargin{:});
            if checkNameResult>2;error('this Profile already exist and can''t be overwritten');end
            if checkNameResult==1;this.NumberOfNoNameProfiles=this.NumberOfNoNameProfiles+1;end
            
            defulatname=['Profile-' num2str(this.NumberOfNoNameProfiles)];
            this.Profiles(length(this.Profiles)+1,1)=Profile('name',defulatname,varargin{:});
            this.NumberOfProfiles=this.NumberOfProfiles+1;
        end   
        
        %Create new Section from matrials nad profile
        function CreateSection(this,mat,prof,name)
            if nargin<4 
                this.NumberOfNoNameSections=this.NumberOfNoNameSections+1;
                name=['Section-' num2str(this.NumberOfNoNameSections)];
            end
            
            if max(strcmp({this.Sections.name}',name))>0;error('this Section already exist and can''t be overwritten');end
            this.Sections(length(this.Sections)+1,1)=Section(name,mat,prof,this.Materials,this.Profiles);
            this.NumberOfSections=this.NumberOfSections+1;
        end
        
        function AssigneSection(this,part,section)
           
            if isa(section,'char')
                sectionIndex=find(strcmp({this.Sections.name}',section));
                selectedSection=this.Sections(sectionIndex) ; %#ok
            end
            if isa(section,'Section') ;selectedSection=section;end
            if isa(part,'Parts') ; part.section=selectedSection;end
            if isa(part,'char')
                partIndex=find(strcmp({this.Parts.name}',part));
                this.Parts(partIndex).section=selectedSection;%#ok
            end

%             
  
        end
%         function ChangeMaterialName(this,material,newname)
%          material.name=newname;
%         
%         end

        
    end
    methods(Static)

        function result=CheckName(place,varargin)

            result=1;
%             nameIndex=find(strcmp(varargin,'name'));
            
%             nameValue=varargin(nameIndex+1)
            nameValue=FEMModel.FindValueInCell('name',varargin{:});
            if isempty(nameValue);return ;end%Not Define Name
            result=0;
            if isempty(place);return ;end %notDuplicate
            result=max(strcmp(place,nameValue))+2;
        end
        
           %use this function to find the pars one parameter in varargin
        function fieldvalue=FindValueInCell(fieldname,varargin)
             fieldIndex=find(strcmp(varargin,fieldname));
             fieldvalue=varargin(fieldIndex+1);
        end

    end

end

