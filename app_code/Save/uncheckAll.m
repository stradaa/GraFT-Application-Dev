function uncheckAll(a, tag)
% allSelected(app, tag) responsible for 'all' UN-checkbox behavior
%
% tag = id for each of the sections to save under

switch tag
    case 'data'
        a.ALLCheckBox.Value = 0;
    case 'pre_process'
        a.ALLCheckBox_2.Value = 0;
    case 'graft_results'
        a.ALLCheckBox_3.Value = 0;
    case 'log'
        a.ALLCheckBox_4.Value = 0;
    case 'about'
        a.ALLCheckBox_5.Value = 0;
end

