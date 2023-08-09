function a = startGraFTing(a)
%STARTGRAFTING 

%% Check for PatchGraFT
if strcmp(a.G.Parameters.Parameters.patchGraFT, 'false')
    title = 'PatchGraFT Not Detected';
    msg = 'Plot intermediate results on separate window?';
    selection = uiconfirm(a.UIFigure, msg, title, 'Options', ...
                         {'Plot & Start GraFT', 'No Plot & Start GraFT', 'Cancel'}, ...
                         'DefaultOption', 1, 'CancelOption', 3);
    if strcmp(selection, 'Plot & Start GraFT')
        a.G.Parameters.Parameters.plot = true;
    else
        a.G.Parameters.Parameters.plot = false;
    end
else
    % Ensure selection
    title = 'GraFT!';
    msg = 'Confirm GraFT Start';
    selection = uiconfirm(a.UIFigure, msg, title, 'options', ...
                          {'GO', 'Cancel'},...
                          'DefaultOption', 1, 'CancelOption', 2);
end

if strcmp(selection, 'Cancel')
    return
end

%% Unchanging GraFT-App Settings
% Parameters
a.G.Parameters.Parameters.grad_type         = 'full_ls_cor';                % Default to optimizing a full optimization on all dictionary elements at each iteration
a.G.Parameters.Parameters.maxiter           = 0.01;                         % Default the maximum iteration to whenever Delta(Dictionary)<0.01
a.G.Parameters.Parameters.tolerance         = 1e-8;                         % Default tolerance for TFOCS calls is 1e-8
a.G.Parameters.Parameters.likely_form       = 'gaussian';                   % Default to a gaussian likelihood ('gaussian' or 'poisson')
a.G.Parameters.Parameters.step_s            = 1;                            % Default step to reduce the step size over time (only needed for grad_type = 'norm')
a.G.Parameters.Parameters.step_decay        = 0.995;                        % Default step size decay (only needed for grad_type = 'norm')
a.G.Parameters.Parameters.max_learn         = 50;                           % Maximum number of steps in learning is 1000 
a.G.Parameters.Parameters.learn_eps         = 5e-4;                         % Default learning tolerance: stop when Delta(Dictionary)<0.01
a.G.Parameters.Parameters.verbose           = 0;                            % Default to no verbose output
a.G.Parameters.Parameters.GD_iters          = 1;                            % Default to one GD step per iteration
a.G.Parameters.Parameters.bshow             = 0;                            % Default to no plotting
a.G.Parameters.Parameters.updateEmbed       = false;                        % Default to not updateing the graph embedding based on changes to the coefficients
a.G.Parameters.Parameters.normalizeSpatial  = true; 
% Correlation kernel
correlation_Kernel.w_time                   = 0;                            % Initialize the correlation kernel struct
correlation_Kernel.reduce_dim               = true;                         % Default to reduce dimentions
correlation_Kernel.corrType                 = 'embedding';                  % Set the correlation type to "graph embedding"

%% Fix Parameters Format
a.G.Parameters.Parameters.nneg_dict = strcmp(a.G.Parameters.Parameters.nneg_dict,'true');
a.G.Parameters.Parameters.nonneg= strcmp(a.G.Parameters.Parameters.nonneg, 'true');
a.G.Parameters.Parameters.patchGraFT = strcmp(a.G.Parameters.Parameters.patchGraFT, 'true');

%% Check Pre-Data
if isempty(a.G.Data.pre_graft)
    a.G.Data.pre_graft = a.G.Data.original;
end

%% UIProgress
d = uiprogressdlg(a.UIFigure,'Title','GraFTing',...
    'Cancelable','off', 'Indeterminate','on');

%% GRAFT
if a.G.Parameters.Parameters.patchGraFT
    [a.G.GraFTed.spatial, a.G.GraFTed.temporal] = patchGraFT(a.G.Data.pre_graft, ...
                                                  a.G.Parameters.Parameters.n_dict, ...
                                                  [], ...
                                                  correlation_Kernel, ...
                                                  a.G.Parameters.Parameters);  % Learn the dictionary using patch-based code 
else
    [a.G.GraFTed.temporal, a.G.GraFTed.spatial] = GraFT(a.G.Data.pre_graft, ...
                                                  [], ...
                                                  correlation_Kernel, ...
                                                  a.G.Parameters.Parameters);  % Learn the dictionary (no patching - will be much more memory intensive and slower)
end

% close uipgrogress
close(d)
end

