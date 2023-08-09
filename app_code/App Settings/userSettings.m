function out  = userSettings()
%USERSETTINGS 


%% Current dir
% hiddenFolder = '.graft_ui_user_settings';
% hiddenFolderPath = fullfile(pwd, hiddenFolder);
% 
% %% Check hidden folder
% if exist(hiddenFolderPath, 'dir') == 0
%     % Add the hidden folder to path
%     addpath(hiddenFolderPath);
%     
%     % Create the hidden folder
%     mkdir(hiddenFolderPath);
% end
% 
% %% Check if 'userSettings.mat' exists in supposed path
% userSettingsPath = fullfile(hiddenFolderPath, 'userSettings.mat');
% 
% if exist(userSettingsPath, 'file') == 0
%     % Save a default 'userSettings.mat' in the hidden folder
%     defaultSettings = struct();
%     defaultSettings.userResolution = 0;
%     defaultSettings.userScreenSize = 0;
%     defaultSettings.fontHandles = {};
%     defaultSettings.core_number = 'all';
%     defaultSettings.appearance_color = 'DarkMode';
%     defaultSettings.fontScale = 800.0;
% 
%     save(userSettingsPath, 'defaultSettings');
% end

%% Load
out = load('userSettings.mat');

end

