%% Example Title
% Summary of example objective

%% Test New Class
clear;clc;close all;
A=FEMModel();
%% Create Part
A.CreatePart('1D','name','milad','lengthp',10,'name','myPart')
A.CreatePart('1D','lengthp',12)
A.CreatePart('1D','lengthp',14)
A.CreatePart('1D','lengthp',15)
%% Create Some Materials
A.CreateMaterial();
A.CreateMaterial('name','Al','E',70);
A.CreateMaterial();
A.CreateMaterial('name','Al2','E',70);
A.CreateMaterial('name','iron');
A.CreateMaterial();
A.CreateMaterial('E',120e3);
A.CreateMaterial('name','titanum');
%% Create Some Profile
A.CreateProfile();
A.CreateProfile('Type','RECT','a',10,'b',20,'name','titanum');
A.CreateProfile('Type','CRcCL','r',10);



%% Creat some Profile
A.CreateSection('Al','titanum')
A.CreateSection(A.Materials(1), A.Profiles(1),'myS')
A.CreateSection(A.Materials(2), A.Profiles(2),'m')
A.CreateSection(A.Materials(2), A.Profiles(2),'n')
A.CreateSection(A.Materials(2), A.Profiles(2))
A.CreateSection('Al', A.Profiles(2))
A.CreateSection('Al', A.Profiles(2))

%% Assigne Section
A.AssigneSection('myPart','myS')