classdef GRAFT
    %GRAFT Constructs an entire class for GraFT application results.
    %   Enable app users to view, edit, and share GraFT results with 
    %   comments about their analysis. The goal of creating this class is 
    %   to better standardize GraFT results and improve app functionality.
    %
    % USAGE:
    %               obj = GRAFT()
    %
    % :param -: None
    % :type -: None
    %
    % :returns: - :GRAFT Class Object: 
    %
    %
    % 06.15.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    properties
        Data        struct  = struct
        PreProcess  struct  = struct
        GraFTed     struct  = struct
        Parameters  PARAMS  = PARAMS
        Log         struct  = struct
        About       struct  = struct
        Encoding    struct  = struct
    end
    
    methods
        function obj = GRAFT()
            %GRAFT 

            % Data
            obj = initData(obj);

            % Pre-Process
            obj = initPreprocess(obj);

            % Processed
            obj = initGraFTed(obj);

            % Parameters
            obj = initParameters(obj);

            % Log and comments
            obj = initLog(obj);

            % About
            obj = initAbout(obj);

            % Encoding
            obj = initEncoding(obj);
        end
        
        function d = initData(d)
            d.Data.original             = [];
            d.Data.pre_graft            = [];
            d.Data.original_size        = [];
            d.Data.projection           = [];
        end
        
        function p = initPreprocess(p)
            % Motion Correction
            p.PreProcess.motco_method   = 'NoRMCorre';
            % Wavelet Denoising
            p.PreProcess.wav_method     = 'BlockJS';
            p.PreProcess.wav_fam        = 'sym';
            p.PreProcess.wav_order      = 2;
            p.PreProcess.wav_lvl        = 4;
            p.PreProcess.wav_noise_est  = 'Level Independent';
            p.PreProcess.wav_thresh     = 'James-Stein';
            p.PreProcess.preprocess_log = cell(20,2); % later cell2table
        end

        function p = initGraFTed(p)
            p.GraFTed.spatial         = [];
            p.GraFTed.temporal        = [];
            p.GraFTed.dl_reconstruct  = [];
            p.GraFTed.spatial_dl_diff = [];
            p.GraFTed.ROIs            = [];
            p.GraFTed.artifacts       = [];
            p.GraFTed.plot_image      = [];
            p.GraFTed.plot_line       = [];
            p.GraFTed.projection      = [];
            p.GraFTed.projection_cols = [];
        end

        function p = initParameters(p)
            % default parameters
            p.Parameters = PARAMS();
        end
        
        function l = initLog(l)
            l.Log.pre_processed    = [];
            l.Log.parameters       = [];
            l.Log.analysis         = [];
        end

        function obj = initAbout(obj)
            % Initializing About properties:
            %       - .name         --> string
            %       - .author       --> string
            %       - .date_time    --> datetime

            date = datetime('now', 'Format', 'yyy_MM_d_HHmm');
            obj.About.name      = "";
            obj.About.author    = "";
            obj.About.date_time = date;
        end

        function e = initEncoding(e)
            e.Encoding.data_path        = [0 0];
            e.Encoding.loading_type     = [];
            e.Encoding.temp_load        = [];
            e.Encoding.files            = [];
            e.Encoding.flag             = "";
            e.Encoding.last_val_load    = [];
            e.Encoding.nest             = struct;
        end
    end
end

