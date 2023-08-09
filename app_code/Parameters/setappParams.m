function a = setappParams(a, s)
%SETPARAMS Sets current GraFT-App parameters to respective fields
%   Allows for the updating of GUI parameter edit fields and drop down
%   values given by the GRAFT .Parameters fieldname. If input with string
%   'Reset' is used, it will use the default parameters determined by
%   PARAMS.m class.
%
% :param s: Option to reset to default parameters
% :type s: string
%
% :returns: a : GraFT-App
%       type a: UIFigure
%
%
% Note: Changing GUI elements names will require function update.
%
% 07.27.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Option
if strcmp(s, 'Reset')
    d = PARAMS();
    a.G.Parameters.Parameters = d.Parameters;
end

%% Set 
a.sparsityconstraintEditField.Value = a.G.Parameters.Parameters.lambda;
a.componentregularizationEditField.Value = a.G.Parameters.Parameters.lamForb;
a.temporalcorrelationregularizationEditField.Value = a.G.Parameters.Parameters.lamCorr;

a.numberofcomponentsEditField.Value = a.G.Parameters.Parameters.n_dict;
a.patchsizeEditField.Value = a.G.Parameters.Parameters.patchSize;
a.usepatchGraFTDropDown.Value = a.G.Parameters.Parameters.patchGraFT;
a.nonnegativetemporalcomponentsDropDown.Value = a.G.Parameters.Parameters.nneg_dict;
a.nonnegativespatialcoefficientsDropDown.Value = a.G.Parameters.Parameters.nonneg;

a.tauEditField.Value = a.G.Parameters.Parameters.tau;
a.betaEditField.Value = a.G.Parameters.Parameters.beta;
a.continuityregularizationEditField.Value = a.G.Parameters.Parameters.lamCont;
a.continuitystepsEditField.Value = a.G.Parameters.Parameters.lamContStp;
a.numberofRWL1GFrepsEditField.Value = a.G.Parameters.Parameters.numreps;

end

