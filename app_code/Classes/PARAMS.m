classdef PARAMS
    %PARAMS Constructs an entire class for GraFT parameters.
    %   Users can save, load, and name their parameters for later use 
    %   within the GraFT app.
    %
    % USAGE:
    %               obj = PARAMS(name, GraFT_data)
    %
    % :param name: user specified name (i.e "my_params")
    % :type name: string
    %
    % :param modality: original data name from GraFT app load
    % :type modality: string
    %
    % :returns: - :PARAMS Class Object: GraFT parameter properties
    %       including correlation kernel settings that are used when 
    %       running the application. Includes About property that saves 
    %       general information about the instance of parameters run.
    %
    %
    % 06.15.2023 - Alex Estrada - %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    properties
        Parameters          struct = struct     % GraFT Parameters
        About               struct = struct     % About Info
    end
    
    methods
        function obj = PARAMS(author, name, GraFT_data)

            arguments
                author      string = "Coco"
                name        string = "my_favorite_params"
                GraFT_data  string = ""
            end
            
            % Initialize general information
            obj = initAbout(obj, author, name, GraFT_data);

            % Initialize default parameters
            obj = defaultParams(obj);
            
        end
        
        function p = defaultParams(p)
            % defaultParams Sets the default values for both properties of
            % the PARAMS object. 
            %   Default values can be updated and saved within the GraFT 
            %   app. When loading in for the first time, unless specified, 
            %   an instance with following values will be selected for the
            %   user.

            %% Parameters
            % Advanced
            p.Parameters.tau               = 2;                             % Default tau values to be spatially varying
            p.Parameters.beta              = 0.01;                          % Default beta parameter to 0.09
            % Optimization
            p.Parameters.lambda            = 0.05;                          % Default lambda parameter is 0.6
            p.Parameters.lamForb           = 0.2;                           % Default Forbenius norm parameter is 0 (don't use)
            p.Parameters.lamCont           = 0.1;                           % Default Dictionary continuation term parameter is 0 (don't use)
            p.Parameters.lamContStp        = 0.9;                           % Default multiplicative change to continuation parameter is 1 (no change)
            p.Parameters.lamCorr           = 0.1;                           % Default Dictionary correlation regularization parameter is 0 (don't use)
            % GraFT construction
            p.Parameters.numreps           = 2;                             % Default number of repetitions for RWL1 is 2
            p.Parameters.n_dict            = 10;                            % Default number of dictionary elements
            p.Parameters.nneg_dict         = 'true';                        % Default to not having negativity constraints
            p.Parameters.nonneg            = 'true';                        % Default to not having negativity constraints on the coefficients
            p.Parameters.patchSize         = 50;                            % Choose the size of the patches to break up the image into (squares with patchSize pixels on each side)
            p.Parameters.mask              = [];                            % For masked images (widefield data)
            p.Parameters.crop              = [];                            % Default no crop selection
            p.Parameters.patchGraFT        = 'false';                       % Default to no patchGraFT
        end

        function obj = initAbout(obj, author, name, data_name)
            % Initializing About properties:
            %       - .name         --> string
            %       - .date_time    --> datetime
            %       - .GraFT_Data   --> string

            obj.About.author = author;
            obj.About.name = name;
            date = datetime('now', 'Format', 'yyy_MM_d_HHmm');
            obj.About.date_time = date;
            obj.About.GraFT_Data = data_name;
        end
    end
end

