function s = setStatus()
%setStatus Initiates Status GraFT app property
%   Controls app behaviour by keep track of events. This function serves to
%   keep tabs on the 'Status' structure fieldnames/property.
%
% :returns: s :Status GraFT-App property:
%              Complete initialization of structure containing following
%              fieldnames:
%                           
%      .view_idx      - index for single img view pre-processing
%      .view_mode     - modes for controlling UIAxes behaviour
%      .is_mcor       - status motion corrected
%      .is_mcor_rep   - check for motion correction repetition
%      .mcor_error    - holds errors during motion correction
%      .is_crop       - status of crop
%      .mask_freehand - drawfreehand object
%      .mask_method   - mask method
%      .mask_color    - default mask color
%      .mask_flag     - mask flag for unproper load
%      .show_mask     - hide/show based on odd/even value
%      .dnoised       - status of denoising
%      .result_idx    - results index controlling ROI view behavior
%      .result_flag   - error report
%      .ready_m_load  - spatial movie playback ready
%      .m_frame       - spatial movie current frame
%      .max_m_frame   - spatial movie frame limit
%      .active_movies - array of selected movies to play
%      .m_stop        - movie stop/play indicator
%
%
% 07.20.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% PRE-Processing
% view modes
view_idx = 1;               % if 0 -> single frame
view_mode = 'Single View';  % viewing mode - preprocessing
% motion correction
is_mcor = 0;                % motion corrected
is_mcor_rep = 0;            % same method repeat selection
mcor_error = 0;             % error during motion correction
% crop
is_crop = 0;                % cropped
% mask
mask_freehand = [];         % drawfreehand object
mask_method = "";           % Free_Hand, Self_Load, Pre_Computed
mask_color = [1,0,0];       % default red
mask_flag = "";             % flag
show_mask = 0;              % show/hide mask
% denoising
dnoised = 0;                % wave denoised

%% GraFT
result_idx = 1;             
results_flag = "";
graft_time = 0;               % time GraFT-analysis took

%% Analysis
% ROIs
current_position = [];      % interactive plot mouse position
% Spatial
ready_m_load = 0;
m_frame = 1;
max_m_frame = 1;
active_movies = [];
data_movies = [];
m_stop = 0;

%% Create Structure
s = struct('view_idx', view_idx, ...
           'view_mode', view_mode, ...
           'is_mcor', is_mcor, ...
           'is_mcor_rep', is_mcor_rep, ...
           'mcor_error', mcor_error, ...
           'is_crop', is_crop, ...
           'mask_freehand', mask_freehand, ...
           'mask_method', mask_method, ...
           'mask_color', mask_color, ...
           'mask_flag', mask_flag, ...
           'show_mask', show_mask, ...
           'dnoised', dnoised, ...
           'result_idx', result_idx, ...
           'result_flag', results_flag, ...
           'graft_time', graft_time, ...
           'current_position', current_position, ...
           'ready_m_load', ready_m_load, ...
           'm_frame', m_frame, ...
           'active_movies', active_movies, ...
           'max_m_frame', max_m_frame, ...
           'data_movies', data_movies, ...
           'm_stop', m_stop);

end