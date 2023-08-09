function [a, s] = motionCorrect(a, s, m)
%MOTIONCORRECT Performs motion correction for GraFT-App
%   Utilizes various methods determined by GraFT-App Object 'GRAFT' to
%   perform motion correction on data.
%
%   Currently supports following methods:
%       - NoRMCorre: fast Non-Rigid Motion Correction.
%         [https://github.com/flatironinstitute/NoRMCorre]
%
%
% :param a: GraFT-App GRAFT
% :type a: GRAFT Class Object
%
% :param s: GraFT-App Status 
% :type s: struct
%
% :param m: Motion corrected method selected
% :type m: char
%
%
% :returns:   a : 
%           type: GRAFT Class Object
%
% :return:    s :
%           type: struct
%
%
% 07.21.23 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Input
if isempty(a.Data.pre_graft)
    data_size = a.Data.original_size;
    data_in = a.Data.original;
else
    data_size = size(a.Data.pre_graft);
    data_in = a.Data.pre_graft;
end

%% Check for Repetition
if s.is_mcor   % check app status for previous motion correction
    % if same method, return, else continue
    if strcmp(m, a.PreProcess.motco_method)
        s.is_mcor_rep = true;
        return
    else
        s.is_mcor_rep = false;
    end
end

%% Motion Correct
switch m
    case 'NoRMCorre'
        % options
        options_rigid = NoRMCorreSetParms('d1',data_size(1), ...
                                          'd2', data_size(2), ...
                                          'bin_width',50, ...
                                          'max_shift',10, ...
                                          'us_fac',2, ...
                                          'iter',5, ...
                                          'init_batch',200);
        [data_out,~,~,~,~] = normcorre(data_in, options_rigid);
end

%% Output
if ~isempty(data_out)
    % status
    s.is_mcor = true;
    % GRAFT
    a.Data.pre_graft = data_out;
    a.PreProcess.motco_method = m;
    % update flag if previous error
    s.mcor_error = false;
else
    % flag
    s.mcor_error = true;
end

end

