function app = colorMe(app,colorScheme)
%COLORME determines color scheme for GraFT App
%   Sets the color HEX values for given scheme. The goal is to support
%   multiple color options (dark mode, light mode, etc) for better
%   readability and overall usage satisfaction.

%% Color Pallete
colors = cell(20,1);
colors{1} = '#000000';  % black
colors{2} = '#FFFFFF';  % white
colors{3} = '#303C4D';  % 
colors{5} = '#0D1117';  % black background
colors{4} = '#161B22';  % gray
colors{6} = '#43A0EB';  % highlight blue
colors{7} = '#238636';  % github green

%% Determine Color Selection
% FontWeight - Bold
fwHandle = findobj(app.UIFigure, '-property', 'FontWeight',...
                                 '-property', 'FontColor');
fwBold = fwHandle(strcmp(get(fwHandle, 'FontWeight'), 'bold'));
fwNormal = fwHandle(strcmp(get(fwHandle, 'FontWeight'), 'normal'));

% Border Type - Lined
btHandle = findobj(app.UIFigure, '-property', 'BorderType');
btLined = btHandle(strcmp(get(btHandle, 'BorderType'), 'line'));

% Border Type - None
btNone = btHandle(strcmp(get(btHandle, 'BorderType'), 'none'));

% Grids Type - ALL
gdHandle = findobj(app.UIFigure, 'Type', 'uigridlayout');

% Buttons Type - ALL
bttnHandle = findobj(app.UIFigure, 'Type', 'uibutton');

% ListBoxes - ALL
lbxHandle = findobj(app.UIFigure, 'Type', 'uilistbox');

% Text Fields - ALL
txtaHandle = findobj(app.UIFigure, 'Type', 'uitextarea');

% State Buttons - ALL
stbtnHandle = findobj(app.UIFigure, 'Type', 'uistatebutton');

% Drop Downs - ALL
dbHandle = findobj(app.UIFigure, 'Type', 'uidropdown');

% Spinner - ALL
spinHandle = findobj(app.UIFigure, 'Type', 'uispinner');

% Number Edit Fields - ALL
efHandle = findobj(app.UIFigure, 'Type', 'uinumericeditfield');

% Text Edit Fields - ALL
tefHandle = findobj(app.UIFigure, 'Type', 'uieditfield');

switch colorScheme
    case 'DarkMode'
        % FontColor Label -FontWeight -Bold
        set(fwBold, {'FontColor'}, repmat(colors(2), size(fwBold)));

        % FontColor Label -FontWeight -Normal
        set(fwNormal, {'FontColor'}, repmat(colors(2), size(fwNormal)));

        % ForeGround Color -Panel -BoderType -Lined
        set(btLined, {'ForegroundColor'}, repmat(colors(6), size(btLined)));
        set(btLined, {'BackgroundColor'}, repmat(colors(4), size(btLined)));

        % ForeGround Color -Panel -BoderType -None
        set(btNone, {'ForegroundColor'}, repmat(colors(2), size(btNone)));
        set(btNone, {'BackgroundColor'}, repmat(colors(4), size(btNone)));

        % Grids
        set(gdHandle, {'BackgroundColor'}, repmat(colors(4), size(gdHandle)));

        % Buttons
        set(bttnHandle, {'BackgroundColor'}, repmat(colors(5), size(bttnHandle)));
        
        % ListBox
        set(lbxHandle, {'BackgroundColor'}, repmat(colors(5), size(lbxHandle)));

        % TextAreas
        set(txtaHandle, {'BackgroundColor'}, repmat(colors(5), size(txtaHandle)));
        
        % State Button
        set(stbtnHandle, {'BackgroundColor'}, repmat(colors(5), size(stbtnHandle)));

        % Drop Downs
        set(dbHandle, {'BackgroundColor'}, repmat(colors(4), size(dbHandle)));

        % Spinners
        set(spinHandle, {'BackgroundColor'}, repmat(colors(4), size(spinHandle)));

        % Edit Field (Numeric)
        set(efHandle, {'BackgroundColor'}, repmat(colors(4), size(efHandle)));
        
        % Edit Field (Text)
        set(tefHandle, {'BackgroundColor'}, repmat(colors(4), size(tefHandle)));
    case 'LightMode'
end

end

