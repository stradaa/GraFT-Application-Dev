function a = saveParams(a)
%SAVEPARAMS Saves GUI parameters to GRAFT properties
%   Current values from GUI elements used for updating GRAFT class object
%   properties: Parameters and About. 
% 
% Note: Changing GUI elements names will require function update.
%
% 07.27.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% PARAMETERS
a.G.Parameters.Parameters.lambda = a.sparsityconstraintEditField.Value;
a.G.Parameters.Parameters.lamForb = a.componentregularizationEditField.Value;
a.G.Parameters.Parameters.lamCorr = a.temporalcorrelationregularizationEditField.Value;

a.G.Parameters.Parameters.n_dict = a.numberofcomponentsEditField.Value;
a.G.Parameters.Parameters.patchGraFT = a.usepatchGraFTDropDown.Value;
a.G.Parameters.Parameters.patchSize = a.patchsizeEditField.Value;
a.G.Parameters.Parameters.nneg_dict = a.nonnegativetemporalcomponentsDropDown.Value;
a.G.Parameters.Parameters.nonneg = a.nonnegativespatialcoefficientsDropDown.Value;

a.G.Parameters.Parameters.tau = a.tauEditField.Value;
a.G.Parameters.Parameters.beta = a.betaEditField.Value;
a.G.Parameters.Parameters.lamCont = a.continuityregularizationEditField.Value;
a.G.Parameters.Parameters.lamContStp = a.continuitystepsEditField.Value;
a.G.Parameters.Parameters.numreps = a.numberofRWL1GFrepsEditField.Value;

%% About
a.G.Parameters.About.author = a.AuthorEditField.Value;
a.G.Parameters.About.GraFT_Data = a.StudyEditField.Value;
a.G.Parameters.About.name = a.NameEditField.Value;
a.G.About.name = a.StudyEditField.Value;
a.G.About.author = a.AuthorEditField.Value;
end

