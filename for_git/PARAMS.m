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
    % 06.15.2023 - Alex Estrada
    
    properties
        Parameters          struct = struct     % GraFT Parameters
        Correlation_Kernel  struct = struct     % GraFT Correlation Kernel 
        About               struct = struct     % About Info
    end
    
    methods
        function obj = PARAMS(name, GraFT_data)

            arguments
                name        string = "Default_Params"
                GraFT_data  string = ""
            end
            
            % Initialize general information
            obj = initAbout(obj, name, GraFT_data);

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

            % Parameters
            p.Parameters.tau    = 1;                                        % Default tau values to be spatially varying
            p.Parameters.lambda            = 0.05;                          % Default lambda parameter is 0.6
            p.Parameters.lamForb           = 0.2;                           % Default Forbenius norm parameter is 0 (don't use)
            p.Parameters.lamCont           = 0.1;                           % Default Dictionary continuation term parameter is 0 (don't use)
            p.Parameters.lamContStp        = 0.9;                           % Default multiplicative change to continuation parameter is 1 (no change)
            p.Parameters.lamCorr           = 0.1;                           % Default Dictionary correlation regularization parameter is 0 (don't use)
            p.Parameters.beta              = 0.09;                          % Default beta parameter to 0.09
            p.Parameters.maxiter           = 0.01;                          % Default the maximum iteration to whenever Delta(Dictionary)<0.01
            p.Parameters.numreps           = 2;                             % Default number of repetitions for RWL1 is 2
            p.Parameters.tolerance         = 1e-8;                          % Default tolerance for TFOCS calls is 1e-8
            p.Parameters.verbose           = 0;                             % Default to full verbosity level
            p.Parameters.likely_form       = 'gaussian';                    % Default to a gaussian likelihood ('gaussian' or 'poisson')
            p.Parameters.step_s            = 1;                             % Default step to reduce the step size over time (only needed for grad_type = 'norm')
            p.Parameters.step_decay        = 0.995;                         % Default step size decay (only needed for grad_type = 'norm')
            p.Parameters.max_learn         = 1e3;                           % Maximum number of steps in learning is 1000 
            p.Parameters.learn_eps         = 0.01;                          % Default learning tolerance: stop when Delta(Dictionary)<0.01
            p.Parameters.n_dict            = 10;                            % Default number of dictionary elements
            p.Parameters.verb              = 1;                             % Default to no verbose output
            p.Parameters.grad_type         = 'full_ls_cor';                 % Default to optimizing a full optimization on all dictionary elements at each iteration
            p.Parameters.GD_iters          = 1;                             % Default to one GD step per iteration
            p.Parameters.bshow             = 0;                             % Default to no plotting
            p.Parameters.nneg_dict         = 1;                             % Default to not having negativity constraints
            p.Parameters.nonneg            = true;                          % Default to not having negativity constraints on the coefficients
            p.Parameters.plot              = false;                         % Default to not plot spatial components during the learning
            p.Parameters.updateEmbed       = false;                         % Default to not updateing the graph embedding based on changes to the coefficients
            p.Parameters.mask              = [];                            % For masked images (widefield data)
            p.Parameters.normalizeSpatial  = true;                          % Default behavior - time-traces are unit norm. when true, spatial maps normalized to max one and time-traces are not normalized
            p.Parameters.patchSize         = 50;                            % Choose the size of the patches to break up the image into (squares with patchSize pixels on each side)
            
            % Correlation kernel
            p.Correlation_Kernel.w_time     = 0;                            % Initialize the correlation kernel struct
            p.Correlation_Kernel.reduce_dim = true;                         % Default to reduce dimentions
            p.Correlation_Kernel.corrType   = 'embedding';                  % Set the correlation type to "graph embedding"
        end

        function obj = initAbout(obj, name, data_name)
            % Initializing About properties:
            %       - .name         --> string
            %       - .date_time    --> datetime
            %       - .GraFT_Data   --> string

            obj.About.name = name;
            date = datetime('now', 'Format', 'yyy_MM_d_HHmm');
            obj.About.date_time = date;
            obj.About.GraFT_Data = data_name;
        end
    end
end

