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
    % 06.15.2023 - Alex Estrada
    
    properties
        Data        struct  = struct
        GraFTed     struct  = struct
        Parameters  PARAMS  = PARAMS
        Comments    struct  = struct
        About       struct  = struct
        Encoding    struct  = struct
    end
    
    methods
        function obj = GRAFT()
            %GRAFT 

            % Data
            obj = initData(obj);

            % Processed
            obj = initGraFTed(obj);

            % Parameters
            obj = initParameters(obj);

            % Comments
            obj = initComments(obj);

            % About
            obj = initAbout(obj);

            % Encoding
            obj = initEncoding(obj);
        end
        
        function d = initData(d)
            d.Data.original             = [];
            d.Data.motion_corrected     = [];
            d.Data.projection           = [];
            d.Data.mask                 = [];
            d.Data.crop                 = [];
        end

        function p = initGraFTed(p)
            p.GraFTed.spatial         = [];
            p.GraFTed.temporal        = [];
            p.GraFTed.ROIs            = [];
            p.GraFTed.plot_image      = [];
            p.GraFTed.plot_line       = [];
            p.GraFTed.projection      = [];
        end

        function p = initParameters(p)
            % default parameters
            p.Parameters = PARAMS();
        end
        
        function c = initComments(c)
            c.Comments.pre_processed    = [];
            c.Comments.processed        = [];
            c.Comments.post_processed   = [];
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
            e.Encoding.files            = [];
            e.Encoding.flag             = "";
            e.Encoding.last_val_load    = [];
            e.Encoding.mat_struct       = struct;
        end
    end
end

