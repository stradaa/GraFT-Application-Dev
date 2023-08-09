function a = setPreProcess(a)
%setPreProcess sets pre-process default values for GraFT-App
%   Sets default values for pre-process tab.
%
% :param a:
% :type a:
%
% :returns: a :
%
% 07.20.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Default Values
p = a.G.PreProcess;

% Motion Correction Tab
a.MethodDropDown.Value = p.motco_method;  
% Wavelet Denoising
a.DenoisingMethodDropDown.Value = p.wav_method;
a.WaveletDropDown.Value = p.wav_fam;
a.OrderEditField.Value = p.wav_order;
a.LevelSpinner.Value = p.wav_lvl;
a.NoiseEstimateDropDown.Value = p.wav_noise_est;
a.ThresholdRuleDropDown.Value = p.wav_thresh;

end

