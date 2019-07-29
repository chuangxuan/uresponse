function varargout = uresponse(varargin)
% URESPONSE MATLAB code for uresponse.fig
%      URESPONSE, by itself, creates a new URESPONSE or raises the existing
%      singleton*.
%
%      H = URESPONSE returns the handle to a new URESPONSE or the handle to
%      the existing singleton*.
%
%      URESPONSE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in URESPONSE.M with the given input arguments.
%
%      URESPONSE('Property','Value',...) creates a new URESPONSE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before uresponse_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to uresponse_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help uresponse

% Last Modified by GUIDE v2.5 13-Jun-2019 20:04:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @uresponse_OpeningFcn, ...
                   'gui_OutputFcn',  @uresponse_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
end% End initialization code - DO NOT EDIT

% --- Executes just before uresponse is made visible.
function uresponse_OpeningFcn(hObject, eventdata, handles, varargin)

set(handles.axesMain, 'Visible', 'on'); % axes4 is the big axis
set(handles.axesMain , 'xlim' , [0 150], 'ylim', [0 1], 'XTick',[],'YTick', [], ...
              'YTickLabel', '', 'XTickLabel','', 'box', 'on','color', 'none'); 
hold(handles.axesMain, 'off');
handles.axes4position = get(handles.axesMain, 'position');

set(handles.axesGrid , 'xlim' , [0 1], 'ylim', [0 1], 'XTick',[],'YTick', [], ...
              'YTickLabel', '', 'XTickLabel','', 'box', 'on','color', 'w'); 

% default styles for plotting
handles.lineColor  = {[0       0      0],...     % 14 black, rem(14, 14)+ 1 = 1
    [0       0      1],...     % 1  blue,  rem(1,  14)+ 1 = 2
    [0       0.5    0],...     % 2  dark green
    [1       0      0],...     % 3  red
    [0.75    0      0.75],...  % 4  dark purple
    [0.7     0.7    0.7],...   % 5  gray
    [0       0.75   0.75],...  % 6  cyan
    [0.87    0.49   0],...     % 7  orange
    [0.75    0.75   0],...     % 8  yellow green
    [0       1      0], ...    % 9  green
    [0.08    0.17   0.55],...  % 10 dark blue
    [1       1      0],...     % 11 yellow
    [0.6     0.2    0],...     % 12 dark orange
    [1       0      1]};       % 13 purple
handles.nColor = length(handles.lineColor); % used in eval
handles.plotCurveSetting.marker          = 'o';
handles.plotCurveSetting.markersize      = 5;
handles.plotCurveSetting.markerfacecolor = [0.7 0.7 0.7]; % used in eval

handles.beforeDeconSetting.marker          = 'o';
handles.beforeDeconSetting.markersize      = 5;
handles.beforeDeconSetting.markerfacecolor = [0.7 0.7 0.7];
handles.beforeDeconSetting.color           = 'b';  % used in eval

handles.afterDeconSetting.marker           = 's';
handles.afterDeconSetting.markersize       = 5;
handles.afterDeconSetting.markerfacecolor  = [0.7 0.7 0.7];
handles.afterDeconSetting.color            = 'r';  % used in eval

handles.horizonLineSetting.color           = 'k';
handles.horizonLineSetting.linestyle       = '-.';
handles.horizonLineSetting.linewidth       = 1;

handles.verticalLineSetting.color          = 'k';
handles.verticalLineSetting.linestyle      = '-.';
handles.verticalLineSetting.linewidth      = 1;

handles.responsePlotSetting.markersize     = 4;
handles.responsePlotSetting.markerfacecolor= [0.7 0.7 0.7];
handles.responsePlotSetting.linewidth      = 1;

set(handles.checkboxXraw, 'value', 1);
set(handles.checkboxYraw, 'value', 1);
set(handles.checkboxZraw, 'value', 1);

set(handles.checkboxXraw, 'enable', 'on');
set(handles.checkboxYraw, 'enable', 'on');
set(handles.checkboxZraw, 'enable', 'on');

set(handles.checkboxXX,  'value', 1);
set(handles.checkboxXY, 'value', 1);
set(handles.checkboxXZ, 'value', 1);
set(handles.checkboxYY, 'value', 1);
set(handles.checkboxYX, 'value', 1);
set(handles.checkboxYZ, 'value', 1);
set(handles.checkboxZX, 'value', 1);
set(handles.checkboxZY, 'value', 1);
set(handles.checkboxZZ, 'value', 1);

set(handles.checkboxXX, 'enable', 'off');
set(handles.checkboxXY, 'enable', 'off');
set(handles.checkboxXZ, 'enable', 'off');
set(handles.checkboxYY, 'enable', 'off');
set(handles.checkboxYX, 'enable', 'off');
set(handles.checkboxYZ, 'enable', 'off');
set(handles.checkboxZX, 'enable', 'off');
set(handles.checkboxZY, 'enable', 'off');
set(handles.checkboxZZ, 'enable', 'off');

handles.output = hObject;
guidata(hObject, handles);
end
% --- Outputs from this function are returned to the command line.
function varargout = uresponse_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
end

% =========================== Toolbar functions =========================
% --------------------------------------------------------------------
function uipushtoolOpenSumFile_ClickedCallback(hObject, eventdata, handles)
% go to last used folder
currentFolder = pwd; % record current folder
if exist('lastFolder.mat', 'file')
    load lastFolder;
    if exist(lastFolder, 'dir') == 0
        lastFolder = currentFolder;
    end
else
    lastFolder = currentFolder;
end
cd(lastFolder);

% pick a file from last used folder
[sumFileName, sumFilePath] = uigetfile(...
    {'*.xlsx;*.XLSX', 'Response Measurement Summary File (*.xlsx;*.XLSX)';...
    '*.xlsx', 'Response Measurement Summary File (*.xlsx)';...
    '*.XLSX', 'Response Measurement Summary File (*.XLSX)';...
    '*.*'  , 'All Files (*.*)'},...
    'Load Response Measurement Summary File');
cd(currentFolder); % go back to current folder (where ucheck is located)

if  ~isequal(sumFileName, 0) % User selected a file
    
    % update LastUsedFolder with the new folder used
    lastFolder = sumFilePath;
    save lastFolder lastFolder;
    
    handles.sumFile = read_sum_file([sumFilePath, sumFileName]);
    
    handles.sumFileName = sumFileName;
    handles.sumFilePath = sumFilePath;
    
    handles.currentFile = 1;
    set(handles.textSummaryFileName,   'String', sumFileName);
    set(handles.listboxMeasurement , 'String',  handles.sumFile.fileLabel);
    set(handles.listboxMeasurement , 'Value' , handles.currentFile);
     
    % read and prepare formatString and columnNames
    [handles.nHeader, handles.formatString, handles.columnNames, handles.missingColumns] = readformatfile(handles.sumFile.measurementFormatFile);
    
    if isempty(handles.formatString)
        msgbox('Measurement format file indicated does not exist, please check line 20 of the summary file.',...
            'Format file not found','error'); return
    end

    % read all data files   
    for iFile = 1:handles.sumFile.nFile
        
        fileData = readpmagfile([handles.sumFile.measurementDataFolder, handles.sumFile.fileNames{iFile}], ...
                         handles.formatString, handles.columnNames, handles.nHeader, handles.missingColumns);
       %  check if the file exists
       if isempty(fileData)
          msgbox('Measurement file indicated does not exist, please check file names and path.',...
            'Measurement file not found','error'); return
       end
       
       measurement = makestructureudecon(fileData);
       
       handles.measurement(iFile).position = measurement.sample(1).run.position;
       handles.measurement(iFile).x = measurement.sample(1).run.xcorr;
       handles.measurement(iFile).y = measurement.sample(1).run.ycorr;
       handles.measurement(iFile).z = measurement.sample(1).run.zcorr;
       
    end
    
    % assuming all positions from different runs are idential vector 
   % organise data in 3d VOLUME fomrat (X, Y, Z, M)
    [handles.m3d.x, handles.m3d.y, handles.m3d.z] = meshgrid(handles.sumFile.gridXcordVector,...
        handles.sumFile.gridYcordVector, handles.measurement(1).position);
    handles.m3d.position = handles.measurement(1).position;
    
    % make sure files are sorted by x cord, then y cord, and finally z
    % orientation (in prep for 3d structure)
    sortColumns = zeros(handles.sumFile.nFile, 3); 
    for iFile = 1:handles.sumFile.nFile
         sortColumns(iFile, 1) = handles.sumFile.gridXcord(iFile);
         sortColumns(iFile, 2) = handles.sumFile.gridYcord(iFile);
         switch handles.sumFile.pointSourceOrientation{iFile}
             case '+X'
                sortColumns(iFile, 3) = 1; 
             case '+Y'
                sortColumns(iFile, 3) = 2;                 
             case '+Z'
                sortColumns(iFile, 3) = 3; 
         end
    end
    [~, sortIndex] = sortrows(sortColumns, [1, 2, 3]);
    
    % construct 3d data matrix
    handles.m3d.xx = zeros(size(handles.m3d.x));
    handles.m3d.xy = zeros(size(handles.m3d.x));
    handles.m3d.xz = zeros(size(handles.m3d.x));
    
    handles.m3d.yx = zeros(size(handles.m3d.x));
    handles.m3d.yy = zeros(size(handles.m3d.x));
    handles.m3d.yz = zeros(size(handles.m3d.x));
    
    handles.m3d.zx = zeros(size(handles.m3d.x));
    handles.m3d.zy = zeros(size(handles.m3d.x));
    handles.m3d.zz = zeros(size(handles.m3d.x));
    
    nxGrids = length(handles.sumFile.gridXcordVector);
    nyGrids = length(handles.sumFile.gridYcordVector);
    
    for ix = 1: nxGrids
        for iy = 1:nyGrids
            currentGrid = (ix-1)*nxGrids + iy; 
            correspondingXorientedFile = sortIndex((currentGrid-1)*3+1);
            correspondingYorientedFile = sortIndex((currentGrid-1)*3+2);
            correspondingZorientedFile = sortIndex((currentGrid-1)*3+3);
            
            handles.m3d.xx(ix, iy, :) = handles.measurement(correspondingXorientedFile).x;
            handles.m3d.xy(ix, iy, :) = handles.measurement(correspondingXorientedFile).y;
            handles.m3d.xz(ix, iy, :) = handles.measurement(correspondingXorientedFile).z;
            
            handles.m3d.yx(ix, iy, :) = handles.measurement(correspondingYorientedFile).x;
            handles.m3d.yy(ix, iy, :) = handles.measurement(correspondingYorientedFile).y;
            handles.m3d.yz(ix, iy, :) = handles.measurement(correspondingYorientedFile).z;
            
            handles.m3d.zx(ix, iy, :) = handles.measurement(correspondingZorientedFile).x;
            handles.m3d.zy(ix, iy, :) = handles.measurement(correspondingZorientedFile).y;
            handles.m3d.zz(ix, iy, :) = handles.measurement(correspondingZorientedFile).z;
        end
    end
   
    guidata(hObject, handles); % update GUI data
    updatemeasurementplot(handles);     % Show default plot
    updategridplot(handles);
   
else % User did not select a file
    msgbox('A response measurement summary file must be loaded in order to use URESPONSE.',...
        'Response Measurement Summary File Not Loaded','warn'); return
end
end
function uipushExport_ClickedCallback(hObject, eventdata, handles)
[fileName, pathName] = uiputfile({'*.txt','TXT file (*.txt)'},...
    'Save selected response function data as',...
    [handles.sumFilePath, strtok(handles.sumFileName, '.'),'.uresponse']);

if  ~isequal(fileName, 0) % User selected a file    
    currentResponseVal = get(handles.listboxResponse, 'value');
    writeresponsefile([pathName, filesep, fileName], handles.response(currentResponseVal));
    msgbox('Selected response data saved successfully.',...
        'Response Data Saved','help');
else
    msgbox('File saving cancelled by user.',...
           'File Not Saved','warn'); return 
end
end
function uipushtoolPrintFigure_ClickedCallback(hObject, eventdata, handles)

[fileName, pathName] =  uiputfile({'*.pdf','PDF file (*.pdf)'},...
    'Print figure as PDF file',...
    [handles.sumFilePath, strtok(handles.sumFileName, '.'),'.uresponse.pdf']);
if  ~isequal(fileName,0)
    set(gcf,'Units','inches');
    screenposition = get(gcf,'Position');
    set(gcf,...
        'PaperPosition',[0 0 screenposition(3:4)],...
        'PaperSize',screenposition(3:4));
    print([pathName, filesep, fileName],'-dpdf', '-painters'); % add '-noui' to avoid UI
    
end
end
function uitoggletoolLegend_ClickedCallback(hObject, eventdata, handles)
if strcmp(get(handles.checkboxXraw, 'enable'), 'on')
    updatemeasurementplot(handles);
else
    updateresponseplot(handles);
end
end
function uitoggletoolGrid_ClickedCallback(hObject, eventdata, handles)
if strcmp(get(handles.checkboxXraw, 'enable'), 'on')
    updatemeasurementplot(handles);
else
    updateresponseplot(handles);
end
end

% ========================== "Measurement" Listbox ==========================
function listboxMeasurement_Callback(hObject, eventdata, handles)
updatemeasurementplot(handles);     % Show default plot
updategridplot(handles);
end
function listboxMeasurement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxMeasurement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end

% ========================= "Response" Listbox =======================
function listboxResponse_Callback(hObject, eventdata, handles)
addcrosssection(handles)
updateresponseplot(handles)
updateresponseparameter(handles)


end
function listboxResponse_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listboxResponse (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function listboxResponse_KeyPressFcn(hObject, eventdata, handles)
switch eventdata.Key
    
    case 'backspace'
        
        % find current response selected
        currentResponseVal = get(handles.listboxResponse, 'value');
        
        % find total response estimates
        nResponse = length(handles.response);
        
        % remove current selected response estimate
        handles.response(currentResponseVal) = [];
        
        % update list of response estimates
        responseListUpdated = [repmat('Response Estimate ', nResponse-1, 1), num2str((1:nResponse-1)', '%2.0d')];
        set(handles.listboxResponse, 'string', responseListUpdated);
        
        % if selected response was the last, then reduce it my 1 (as 1
        % response will have been removed)
        if currentResponseVal == nResponse
            currentResponseVal = currentResponseVal - 1;
        end
          set(handles.listboxResponse, 'value', currentResponseVal);
          
        % save data  
        guidata(hObject, handles);
        
        % update crosssection plot, response plot, and response parameter
        % boxes
        addcrosssection(handles)
        updateresponseplot(handles)
        updateresponseparameter(handles)
end
end

function checkbox_ShowNormalised_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox_ShowNormalised (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% if get(handles.checkbox_ShowNormalised, 'value')==1
%     set(handles.checkbox_ShowNormalised, 'value', 0);
% else
%     set(handles.checkbox_ShowNormalised, 'value', 1);   
% end
updateresponseplot(handles)
% Hint: get(hObject,'Value') returns toggle state of checkbox_ShowNormalised
end

% ======================== "Terms" panel ===========================
function checkboxXraw_Callback(hObject, eventdata, handles)
updatemeasurementplot(handles);
end
function checkboxYraw_Callback(hObject, eventdata, handles)
updatemeasurementplot(handles);
end
function checkboxZraw_Callback(hObject, eventdata, handles)
updatemeasurementplot(handles);
end
function checkboxXX_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxXY_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxXZ_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxYX_Callback(hObject, eventdata, handles)
updateresponseplot(handles)

end
function checkboxYY_Callback(hObject, eventdata, handles)
updateresponseplot(handles)

end
function checkboxYZ_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxZX_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxZY_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end
function checkboxZZ_Callback(hObject, eventdata, handles)
updateresponseplot(handles)
end

% ======================== "Parameter" panel ===========================
function editInterpResolutionTrack_Callback(hObject, eventdata, handles)
% hObject    handle to editInterpResolutionTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editInterpResolutionTrack as text
%        str2double(get(hObject,'String')) returns contents of editInterpResolutionTrack as a double
end
function editInterpResolutionTrack_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpResolutionTrack (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editInterpResolutionCross_Callback(hObject, eventdata, handles)
end
function editInterpResolutionCross_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editInterpResolutionCross (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editHorizontalOffset_Callback(hObject, eventdata, handles)
% hObject    handle to editHorizontalOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editHorizontalOffset as text
%        str2double(get(hObject,'String')) returns contents of editHorizontalOffset as a double
end
function editHorizontalOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editHorizontalOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editVerticalOffset_Callback(hObject, eventdata, handles)
% hObject    handle to editVerticalOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editVerticalOffset as text
%        str2double(get(hObject,'String')) returns contents of editVerticalOffset as a double
end
function editVerticalOffset_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editVerticalOffset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editCrossSecHeight_Callback(hObject, eventdata, handles)
% hObject    handle to editCrossSecHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCrossSecHeight as text
%        str2double(get(hObject,'String')) returns contents of editCrossSecHeight as a double
end
function editCrossSecHeight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCrossSecHeight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editCrossSecWidth_Callback(hObject, eventdata, handles)
% hObject    handle to editCrossSecWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editCrossSecWidth as text
%        str2double(get(hObject,'String')) returns contents of editCrossSecWidth as a double
end
function editCrossSecWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editCrossSecWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function editLength_Callback(hObject, eventdata, handles)
% hObject    handle to editLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of editLength as text
%        str2double(get(hObject,'String')) returns contents of editLength as a double
end
function editLength_CreateFcn(hObject, eventdata, handles)
% hObject    handle to editLength (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
end
function radiobutton_maxVal_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_maxVal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.radiobutton_maxVal, 'value', 1);
set(handles.radiobutton_MPS, 'value', 0);
% Hint: get(hObject,'Value') returns toggle state of radiobutton_maxVal
end
function radiobutton_MPS_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton_MPS (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% check if MPS value exists
if isfield(handles, 'sumFile')
    
    if ~isnan(handles.sumFile.pointSourceMoment)
        set(handles.radiobutton_maxVal, 'value', 0);
        set(handles.radiobutton_MPS, 'value', 1);
    else
        set(handles.radiobutton_maxVal, 'value', 1);
        set(handles.radiobutton_MPS, 'value', 0);
        msgbox('Point Source Value not found!', 'Error','error')
    end
    
else
    set(handles.radiobutton_maxVal, 'value', 1);
    set(handles.radiobutton_MPS, 'value', 0);
    msgbox('Point Source Value not found!', 'Error','error')
end

% Hint: get(hObject,'Value') returns toggle state of radiobutton_MPS
end

% ======================== pushbutton "Calculate Response"  ============
function pushbuttonCalculateResponse_Callback(hObject, eventdata, handles)
% get relevant parameter values
parameters.yCenter = str2double(get(handles.editHorizontalOffset, 'string'));
parameters.xCenter = str2double(get(handles.editVerticalOffset, 'string'));
parameters.xHeight = str2double(get(handles.editCrossSecHeight, 'string'));
parameters.yWidth = str2double(get(handles.editCrossSecWidth, 'string'));
parameters.interpResCross =  str2double(get(handles.editInterpResolutionCross, 'string'));
parameters.interpResTrack =  str2double(get(handles.editInterpResolutionTrack, 'string'));
parameters.integrationLength = str2double(get(handles.editLength, 'string'));
parameters.pointSourceMoment = handles.sumFile.pointSourceMoment;
parameters.pointSourcePosition = handles.sumFile.pointSourcePosition;
 
% add interpolation grids
parameters.gridHorizontal = parameters.yCenter-parameters.yWidth/2:parameters.interpResCross:parameters.yCenter+parameters.yWidth/2;
parameters.gridVertical =  (parameters.xCenter-parameters.xHeight/2:parameters.interpResCross:parameters.xCenter+parameters.xHeight/2)'; 
parameters.gridXm = repmat(parameters.gridHorizontal, length(parameters.gridVertical), 1);
parameters.gridYm = repmat(parameters.gridVertical, 1, length(parameters.gridHorizontal));

if get(handles.radiobutton_MPS, 'value') == 1
    parameters.normOption = 1;
else
    parameters.normOption = 0;
end

if isfield(handles, 'response')
    nResponseExist = length(handles.response);
    handles.response(nResponseExist+1) = getresponse(handles.m3d, parameters);
else % first time 
    handles.response = getresponse(handles.m3d, parameters);
end

% PUT BREAKPOINTS BELOW THEN SAVE handles.reponse DATA IF NEEDED
% update response list
currentResponseVal = length(handles.response);
responseList = [repmat('Response Estimate ', currentResponseVal, 1), num2str((1:currentResponseVal)', '%2.0d')];
set(handles.listboxResponse, 'string', responseList);
set(handles.listboxResponse, 'value', currentResponseVal);

% update grid plot with cross section
addcrosssection(handles);

% update main axes plot
updateresponseplot(handles)

% update handles data
guidata(hObject, handles);

end

% ======================== uresponse support functions ===============
% ---------- file and data control 
function [nHeader, formatString, columnNames, missingColumns] = readformatfile(filePathName)
   
fid = fopen(filePathName);
       headerInfo = textscan(fid, '%s  %f', 1, 'delimiter'   , ':', 'headerlines', 23); 
       formatData = textscan(fid, '%f  %s  %s', 'delimiter'   , '\t'); 
fclose(fid);
    
nHeader   = headerInfo{2};
rawString = formatData{2};
columnNames  = formatData{3}; 
nColumn = length(columnNames);

% check if all required columns are there
requiredColumns = {'sampleID', 'position', 'afz', 'declination', 'inclination',...
                  'intensity', 'xcorr', 'ycorr', 'zcorr', 'leaderLength', 'trailerLength','runNumber'};            
nRequired = length(requiredColumns);
checkMark = nan(nRequired, 1);

for iRequired = 1:nRequired  
    for iColumn = 1:nColumn
        if strcmp(requiredColumns{iRequired}, columnNames{iColumn})
            checkMark(iRequired) = 1;
            break
        end        
    end    
end

if any(isnan(checkMark([2 3 7 8 9]))) % required ones missing
   missingColumns = [];
   formatString = [];
   warning('Required column(s) missing.')  
elseif any(isnan(checkMark([1 4 5 6 10 11 12]))) % optional ones missing
    missingColumns = requiredColumns(isnan(checkMark));
    formatString = rawString{1};
    for iRow = 2:length(rawString)
        formatString = [formatString, '   ', rawString{iRow}];
    end 
    
else % no missing columns
    missingColumns = [];
    formatString = rawString{1};
    for iRow = 2:length(rawString)
        formatString = [formatString, '   ', rawString{iRow}];
    end 
    
end

% missingColumns = find(checkMark == 0);
% if isempty(missingColumns)
%     
%     formatString = rawString{1};
%     for iRow = 2:length(rawString)
%         formatString = [formatString, '   ', rawString{iRow}];
%     end
%     
% else 
%    missingNames = [' ''', requiredColumns{missingColumns(1)}, ''''];
%    nMissing = length(missingColumns);
%    if nMissing > 1
%        for iMissing = 2:nMissing
%            missingNames = [missingNames, ' ''', requiredColumns{missingColumns(iMissing)}, ''''];             
%        end
%    end
%    formatString = [];
%    msgbox(['The following required columns are missing: ', missingNames, '. Please check the format file. '...
%            'If these columns are not present in the measurement file, you will need '...
%            ' to calculate and add them to the measurement file, and update your format file accordingly. You may also consider modifying '...
%            ' configuration in the Long Core software to include these columns for future measruements.'],...
%        'Format File Error','error');
%    
% end

end
function sumFile = read_sum_file(filePathName)

sumFile.pathName = filePathName;
[filePath, ~, ~] = fileparts(filePathName);
[~, ~, raw] = xlsread(filePathName, '', '', 'basic');
[nRow, ~] = size(raw);

sumFile.lab = raw{3, 2};
sumFile.srmModel = raw{4, 2};
sumFile.installationDate = raw{5, 2};
sumFile.positiveX = raw{6, 2};
sumFile.positiveY = raw{7, 2};
sumFile.positiveZ = raw{8, 2};

sumFile.pointSourceID = raw{11, 2};
sumFile.measurementDate = raw{12, 2};
sumFile.pointSourceMoment = raw{13, 2};
sumFile.positiveTracking = raw{14, 2};
sumFile.gridShape = raw{15, 2};
sumFile.nGrid = raw{16, 2};
sumFile.gridCenter2tray = raw{17, 2};
sumFile.measurementStartPosition = raw{18, 2};
sumFile.measurementResolution = raw{19, 2};
sumFile.measurementEndPosition = raw{20, 2};
sumFile.pointSourcePosition   = raw{21, 2};
sumFile.measurementFormatFile = [filePath, filesep, raw{22, 2}];
sumFile.measurementDataFolder = [filePath, filesep, raw{23, 2}, filesep];

gridNo = raw(26:nRow, 1);
gridXcord = raw(26:nRow, 2);
gridYcord = raw(26:nRow, 3);
sumFile.pointSourceOrientation = raw(26:nRow, 4);
sumFile.fileNames = raw(26:nRow, 5);
sumFile.nFile = nRow-26+1;
sumFile.fileLabel = cell(sumFile.nFile, 1);
sumFile.gridNo = zeros(sumFile.nFile, 1);
sumFile.gridXcord = zeros(sumFile.nFile, 1);
sumFile.gridYcord = zeros(sumFile.nFile, 1);

for iFile = 1:sumFile.nFile
      sumFile.fileLabel{iFile} = ['Grid: ', num2str(gridNo{iFile}), '; Orientation: ', sumFile.pointSourceOrientation{iFile}];
      sumFile.gridNo(iFile) = gridNo{iFile};
      sumFile.gridXcord(iFile) = gridXcord{iFile};
      sumFile.gridYcord(iFile) = gridYcord{iFile};
end

[ sumFile.gridNoUnique, sumFile.uniqueGridIndex, ~] = unique(sumFile.gridNo);
sumFile.gridXcordUnique = sumFile.gridXcord(sumFile.uniqueGridIndex);
sumFile.gridYcordUnique = sumFile.gridYcord(sumFile.uniqueGridIndex);
sumFile.gridXcordVector = unique(sumFile.gridXcordUnique);
sumFile.gridYcordVector = unique(sumFile.gridYcordUnique);

end
function fileData = readpmagfile(filePathName, formatString, columnNames, nHeader, missingColumns)               
    % READPMAGFILE extract pmag data from a 2g formated measurement file, and
    % store each column data in the file to a field of the structure variable
    % 'fielData'
    %
    % Created by Chuang Xuan 
    
    % test reading measurement file as string 
    fid = fopen(filePathName);
        testReadData = textscan(fid, '%s', 'delimiter'   , '\n',...
                           'headerlines', nHeader ); 
    fclose(fid); 
    
    nRow = length(testReadData{1});
    firstRow = testReadData{1}{1};
    nTab = 1;
    for iCol = 1:length(firstRow) 
        if strcmp(firstRow(iCol), '	')
           nTab = nTab + 1;        
        end
    end
    
    if nTab ~= length(columnNames) 
       msgbox(['Number of columns in the measurement file does not match that '...
              'indicated by the format file. Check your format file, make ',...
              'sure all columns in measurement file are listed in the format file '...
              '(not just the required ones). Also, make sure measurement file is tab-delimited.'],...
       'Measurement File Reading Error','error');
       fileData = [];
       return
    end

    % read data from file
    fid = fopen(filePathName);
        rawData = textscan(fid, formatString, 'delimiter'   , '\t',...% used in eval
                           'headerlines', nHeader , 'TreatAsEmpty', 'NA'); 
        fseek(fid, 0, 'bof');
        fileHeader = textscan(fid, '%s', nHeader, 'delimiter', '\n'); 
    fclose(fid);

    % check if measurement file reading was successful. 
    nRowLoaded = length(rawData{1});
    
    if nRow ~= nRowLoaded 
       msgbox(['Error occured while reading the measurement file.'...
              'Check your format file, make sure all columns in measurement file are listed in the format file '...
              '(not just the required ones), and format string (i.e. %f for numbers, %s for strings) '...
              'is appropriately assigned for each column. Also, make sure measurement file is tab-delimited.'],...
       'Measurement File Reading Error','error'); 
       fileData = [];
       return;
    end
    
    % store data to a structure variable 'fileData'
    fileData.fileHeader   = fileHeader;
    fileData.columnNames  = columnNames;
        
    for iField = 1:length(columnNames)
        eval(['fileData.',columnNames{iField},' = rawData{',num2str(iField), '};'])
    end     
    
    % deal with missing columns    
    if ~isempty(missingColumns)
       for iMissing = 1:length(missingColumns)
           
           switch missingColumns{iMissing}
               case 'sampleID'
                   fileData.sampleID = repmat('SampleIDnotDefined', nRow, 1);     
               case 'declination'
                   [fileData.declination, ~, ~] = calculate_xyz2dii(fileData.xcorr, fileData.ycorr, fileData.zcorr);
               case 'inclination'
                   [~, fileData.inclination, ~] = calculate_xyz2dii(fileData.xcorr, fileData.ycorr, fileData.zcorr);
               case 'intensity'
                   [~, ~, fileData.intensity] = calculate_xyz2dii(fileData.xcorr, fileData.ycorr, fileData.zcorr);
               case 'leaderLength'
                   % get data from user
                   prompt = {'Leader Length (cm): '};
                   title = 'Leader Length Info';
                   dims = [1 35];
                   definput = {'10'};
                   answer = inputdlg(prompt, title, dims, definput);
                   fileData.leaderLength = repmat(answer, nRow, 1);
                   
               case 'trailerLength'
                   % get data from user
                   prompt = {'Trailer Length (cm): '};
                   title = 'Trailer Length Info';
                   dims = [1 35];
                   definput = {'10'};
                   answer = inputdlg(prompt, title, dims, definput);
                   fileData.leaderLength = repmat(answer, nRow, 1);
                   
               case 'runNumber'
                   fileData.runNumber = fileData.afz;
           end
       end   
    end
         
    % check if xintensity, yintensity, and zintensity were read. If not,
    % calculate them
    
    if ~isfield(fileData, 'xintensity')
        fileData.xintensity  =  fileData.intensity.*cosd(fileData.inclination).*cosd(fileData.declination); % 'north'    component
    end
    
    if ~isfield(fileData, 'yintensity')
        fileData.yintensity  =  fileData.intensity.*cosd(fileData.inclination).*sind(fileData.declination); % 'east'     component
    end
    
    if ~isfield(fileData, 'zintensity')
        fileData.zintensity  =  fileData.intensity.*sind(fileData.inclination);            % 'vertical' component 
    end
  
end
function measurement = makestructureudecon(fileData)               
% MAKESTRUCTUREUDECON transform the raw measurement data organized by columns
% to a strurcture based system: measurement.sample(i).run(j).
%
% Different from 'makestructure', MAKESTRUCTUREBASIC only keep udecon used
% esstinal/basic data from the file in the structure. measurement has the
% following fields: nSample, uniqueSampleID, sample. sample
% has the following fields: nRun, uniqueRuns, uniqueRunsDemagZ,
% treatmentString, run. And run has the following fields: sampleID,
% position, xcorr, ycorr, zcorr, declination, inclination, intensity,
% leaderLength, trailerLength.
% 
% Created by Chuang Xuan on Jan. 23, 2013

% extracting sample information
fileTotalRows = size(fileData.sampleID, 1);
[uniqueSampleID, sampleFirstOcc] = unique(fileData.sampleID, 'first');

% list unique sample in the measured order
[sampleFirstOcc, ix]  =  sort(sampleFirstOcc);
uniqueSampleID        =  uniqueSampleID(ix); 
nSample               =  size(uniqueSampleID, 1);
sampleFirstOcc        =  [sampleFirstOcc; fileTotalRows + 1]; %last element 
                         % added to facilitate iSampleRows construction below

% add useful measurement info to the structure
measurement.nSample         = nSample;
measurement.uniqueSampleID  = uniqueSampleID;

% map sample and run info 
for iSample = 1:nSample,       
    
    % identify rows associate with the current loop sample
    iSampleRows     = (sampleFirstOcc(iSample):sampleFirstOcc(iSample+1)-1)';
    [uniqueRuns, runsFirstOcc] = ...
        unique(fileData.runNumber(iSampleRows), 'first');
    nRun            =  size(uniqueRuns, 1);
    runsFirstOcc    =  [iSampleRows(runsFirstOcc); iSampleRows(end)+1];
    uniqueDemagZ    =  fileData.afz(runsFirstOcc(1:end-1));
    treatmentString = [repmat(' ', nRun, 1),...
                       num2str(uniqueDemagZ, '%-4.0f'),...
                       repmat(' [Run#: ', nRun, 1),...
                       num2str(uniqueRuns, '%-5.0f'),...
                       repmat(']', nRun, 1)];   
    % add useful sample run info to the structure
    measurement.sample(iSample).nRun             = nRun;
    measurement.sample(iSample).uniqueRuns       = uniqueRuns;
    measurement.sample(iSample).uniqueRunsDemagZ = uniqueDemagZ;
    measurement.sample(iSample).treatmentString  = treatmentString;  
    
    for iRun = 1:nRun,             
        % identify rows associate with the current run
        iRunRows = (runsFirstOcc(iRun):runsFirstOcc(iRun+1)-1)';
        
        % parameters used for deconvolution calculation
        measurement.sample(iSample).run(iRun).sampleID = ...
            fileData.sampleID(iRunRows);
        measurement.sample(iSample).run(iRun).runNumber = ...
            fileData.runNumber(iRunRows);
        measurement.sample(iSample).run(iRun).afz = ...
            fileData.afz(iRunRows);
        measurement.sample(iSample).run(iRun).position = ...
            fileData.position(iRunRows);  
        measurement.sample(iSample).run(iRun).leaderLength = ...
            fileData.leaderLength(iRunRows);        
        measurement.sample(iSample).run(iRun).trailerLength = ...
            fileData.trailerLength(iRunRows);  
        measurement.sample(iSample).run(iRun).xcorr = ...
            fileData.xcorr(iRunRows);  
        measurement.sample(iSample).run(iRun).ycorr = ...
            fileData.ycorr(iRunRows);        
        measurement.sample(iSample).run(iRun).zcorr = ...
            fileData.zcorr(iRunRows);   
        
        % parameters used for comparison with decon results 
        measurement.sample(iSample).run(iRun).xintensity = ...
            fileData.xintensity(iRunRows);       
        measurement.sample(iSample).run(iRun).yintensity = ...
            fileData.yintensity(iRunRows); 
        measurement.sample(iSample).run(iRun).zintensity = ...
            fileData.zintensity(iRunRows);    
        measurement.sample(iSample).run(iRun).declination = ...
            fileData.declination(iRunRows);        
        measurement.sample(iSample).run(iRun).inclination = ...
            fileData.inclination(iRunRows);        
        measurement.sample(iSample).run(iRun).intensity = ...
            fileData.intensity(iRunRows);
   
    end %for iRun    
end % for iSample   
end
function writeresponsefile(fileNamePath, response)

header = 'Position	XX	XY	XZ	YX	YY	YZ	ZX	ZY	ZZ';
formatString = ['%5.2f', repmat('	%14.7E', 1, 9), '\n'];  
fileID = fopen(fileNamePath, 'w');
    % Write file header
%     fprintf(fileID, '%s\n', ['Integrated area (square cm) on cross section: ', num2str(response.area, '%4.2f'),...
%         ' (height (cm): ', num2str(response.parameters.xHeight, '%4.2f'),...
%         ' , width (cm): ', num2str(response.parameters.yWidth, '%4.2f'),...
%         ', horizontal offset (cm): ',  num2str(response.parameters.yCenter, '%4.2f'),...
%         ' vertical offset (cm): ',  num2str(response.parameters.xCenter, '%4.2f'),...
%         '); Integrated length along track (cm): ', num2str(response.parameters.integrationLength, '%4.2f')]); % write the headline
%     fprintf(fileID, '%s\n', ['Measurement interval thickness (cm): ', num2str(response.intervalThickness, '%3.1f'),...
%         '; Interpolation resolution on cross-section (cm): ',  num2str(response.parameters.interpResCross, '%3.1f')]); % write the headline
%     fprintf(fileID, '%s\n', ['Number of measured points on one side of the center (excluding the center): ', num2str(response.lr, '%3i')]); % write the headline
%     fprintf(fileID, '%s\n', ['Created by URESPONSE software on ', date]); 
 
    fprintf(fileID, '%s\n', ['Integrated area (square cm) on cross section: ', num2str(response.area, '%4.2f')]); % write the headline
    fprintf(fileID, '%s\n', ['Measurement interval thickness (cm): ', num2str(response.intervalThickness, '%3.1f')]); % write the headline
    fprintf(fileID, '%s\n', ['Number of measured points on one side of the center (excluding the center): ', num2str(response.lr, '%3i')]); % write the headline
    fprintf(fileID, '%s\n', ['Created by URESPONSE software on ', date]); 
    
    fprintf(fileID, '%s\n', 'ij is i-oriented magnetization response on j-axis, where i = X, Y, or Z, and j = X, Y, or Z.'); % write the headline
    fprintf(fileID, '%s\n', header);
    nRow = length(response.position);
    
    for iRow = 1:nRow
        fprintf(fileID, formatString, ...
               [response.position(iRow), ...
                response.norm.xx(iRow), ...
                response.norm.xy(iRow), ...
                response.norm.xz(iRow),...
                response.norm.yx(iRow), ...
                response.norm.yy(iRow), ...
                response.norm.yz(iRow),...
                response.norm.zx(iRow), ...
                response.norm.zy(iRow), ...
                response.norm.zz(iRow)]);
    end    
fclose(fileID);
end


% ---------- update relevant plots
function updatemeasurementplot(handles)
% enable xyz raw, disable other 9 terms
set(handles.checkboxXraw, 'enable', 'on');
set(handles.checkboxYraw, 'enable', 'on');
set(handles.checkboxZraw, 'enable', 'on');

set(handles.checkboxXX, 'enable', 'off');
set(handles.checkboxXY, 'enable', 'off');
set(handles.checkboxXZ, 'enable', 'off');
set(handles.checkboxYY, 'enable', 'off');
set(handles.checkboxYX, 'enable', 'off');
set(handles.checkboxYZ, 'enable', 'off');
set(handles.checkboxZX, 'enable', 'off');
set(handles.checkboxZY, 'enable', 'off');
set(handles.checkboxZZ, 'enable', 'off');

% find out which files are selected
currentFiles = get(handles.listboxMeasurement, 'value');

% initialise legend string
legendStringAll = cell(3*length(currentFiles));
for iFile = 1:length(currentFiles)
    legendStringAll{(iFile-1)*3+1} = [handles.sumFile.fileLabel{currentFiles(iFile)}, '  X moment'];
    legendStringAll{(iFile-1)*3+2} = [handles.sumFile.fileLabel{currentFiles(iFile)}, '  Y moment'];
    legendStringAll{(iFile-1)*3+3} = [handles.sumFile.fileLabel{currentFiles(iFile)}, '  Z moment'];
end
legendSelectX = [];
legendSelectY = [];
legendSelectZ = [];

% plot one x, y, or z a time
hold(handles.axesMain, 'off');
if get(handles.checkboxXraw, 'value') == 1
    legendSelectX = 1:3:3*length(currentFiles);
    for iFile = 1:length(currentFiles)
        plot(handles.axesMain, handles.measurement(currentFiles(iFile)).position, handles.measurement(currentFiles(iFile)).x, '+-');
        hold(handles.axesMain, 'on');
    end
end

if get(handles.checkboxYraw, 'value') == 1
    legendSelectY = 2:3:3*length(currentFiles);
    for iFile = 1:length(currentFiles)
        plot(handles.axesMain, handles.measurement(currentFiles(iFile)).position, handles.measurement(currentFiles(iFile)).y, '+-');
        hold(handles.axesMain, 'on');
    end
end

if get(handles.checkboxZraw, 'value') == 1
    legendSelectZ = 3:3:3*length(currentFiles);
    for iFile = 1:length(currentFiles)
        plot(handles.axesMain, handles.measurement(currentFiles(iFile)).position, handles.measurement(currentFiles(iFile)).z, '+-');
        hold(handles.axesMain, 'on');
    end
end
 hold(handles.axesMain, 'off');
 xlabel(handles.axesMain, 'Position (cm)');
 ylabel(handles.axesMain, 'Magnetic Moment (emu)');
 
 % check legend status
 if  strcmp(get(handles.uitoggletoolLegend, 'state'), 'on') % legend toggle is on    
     legendSelect = [legendSelectX, legendSelectY, legendSelectZ];
     legend(handles.axesMain, legendStringAll(legendSelect));     
 else
     legend(handles.axesMain, 'off');     
 end
 
 % check grid status
  if  strcmp(get(handles.uitoggletoolGrid, 'state'), 'on') % legend toggle is on    
     grid(handles.axesMain, 'on');
  else
      grid(handles.axesMain, 'off');
  end

end
function updategridplot(handles)
cla(handles.axesGrid);
plot(handles.axesGrid, handles.sumFile.gridYcordUnique, handles.sumFile.gridXcordUnique, ...
    'ko', 'markersize', 16);
hold(handles.axesGrid, 'on');

% set x y limits based on grid range
xlimits = [handles.sumFile.gridYcordVector(1) - (handles.sumFile.gridYcordVector(2) - handles.sumFile.gridYcordVector(1) )/2,...
    handles.sumFile.gridYcordVector(end) + (handles.sumFile.gridYcordVector(end) - handles.sumFile.gridYcordVector(end-1))/2 ];
ylimits = [handles.sumFile.gridXcordVector(1) - (handles.sumFile.gridXcordVector(2) - handles.sumFile.gridXcordVector(1) )/2,...
    handles.sumFile.gridXcordVector(end) + (handles.sumFile.gridXcordVector(end) - handles.sumFile.gridXcordVector(end-1))/2 ];

% set axes direction depending on srm positive x
trayThickness = 0.1;
if strcmp(handles.sumFile.positiveX, 'Down')
    set(handles.axesGrid, 'ydir', 'reverse', 'xdir', 'reverse');
    ylimits(2) = handles.sumFile.gridCenter2tray + trayThickness;
    trayV = [xlimits(1) ylimits(2); xlimits(1) ylimits(2)-trayThickness;...
        xlimits(2) ylimits(2)-trayThickness; xlimits(2) ylimits(2)];
%     traySurfaceCenterY = ylimits(2)-trayThickness;
    arrowX = xlimits(2) - 0.05;
    arrowY = ylimits(2)-trayThickness-0.025;
    arrowText = '+X: \downarrow  +Y: \leftarrow';
    
%     vArrowX = xlimits(1) + 0.05;
%     vArrowY = ylimits(1);
%     vArrowText = '\rightarrow +X';
%     vArrowX = [xlimits(1) + 0.1, xlimits(1) + 0.1];
%     vArrowY = [ylimits(1) + 0.1, ylimits(1) + 0.3];
     
else
    ylimits(1) = -handles.sumFile.gridCenter2tray-trayThickness;
    trayV = [xlimits(1) ylimits(1); xlimits(1) ylimits(1)+trayThickness;...
        xlimits(2) ylimits(1)+trayThickness; xlimits(2) ylimits(1)];
    
    arrowX = xlimits(1) + 0.05;
    arrowY = ylimits(1)+trayThickness+0.025;
    arrowText = '+X: \uparrow  +Y: \rightarrow';
    
%     traySurfaceCenterY = ylimits(1)+trayThickness;
%     hArrowX = xlimits(1) + 0.1;
%     hArrowY = ylimits(1) + 0.2;
%     hArrowText = '\rightarrow +Y';
%     vArrowX = [xlimits(1) + 0.1, xlimits(1) + 0.1];
%     vArrowY = [ylimits(1) + 0.2, ylimits(1) + 0.4];
end

% add grid lines
for iX = 1:length(handles.sumFile.gridXcordVector)-1
    line(handles.axesGrid, xlimits, [handles.sumFile.gridXcordVector(iX) + ...
        (handles.sumFile.gridXcordVector(iX+1) - handles.sumFile.gridXcordVector(iX))/2, ...
        handles.sumFile.gridXcordVector(iX) + ...
        (handles.sumFile.gridXcordVector(iX+1) - handles.sumFile.gridXcordVector(iX))/2], 'linestyle', '-.');
end

for iY = 1:length(handles.sumFile.gridYcordVector)-1
    line(handles.axesGrid, [handles.sumFile.gridYcordVector(iY) + ...
        (handles.sumFile.gridYcordVector(iY+1) - handles.sumFile.gridYcordVector(iY))/2, ...
        handles.sumFile.gridYcordVector(iY) + ...
        (handles.sumFile.gridYcordVector(iY+1) - handles.sumFile.gridYcordVector(iY))/2,], ylimits, 'linestyle', '-.');
end

% find out which files are selected
currentFiles = get(handles.listboxMeasurement, 'value');
plot(handles.axesGrid, handles.sumFile.gridYcord(currentFiles), handles.sumFile.gridXcord(currentFiles), ...
    'ko', 'markersize', 16, 'markerfacecolor', [0.5 0.5 0.5]);
text(handles.axesGrid, handles.sumFile.gridYcordUnique, handles.sumFile.gridXcordUnique, ...
    num2cell(handles.sumFile.gridNoUnique), 'horizontalalignment', 'center', 'verticalalignment', 'middle');

% % mark +x and +y direction
% plot(handles.axesGrid, 0, 0, 'b+', 'markersize', 6);
% axes(handles.axesGrid);
% annotation('arrow', [0 xlimits(2)], [0 0]);
% annotation('arrow', [0 0], [0 ylimits(2)]);

% draw tray
patch(handles.axesGrid, 'vertices', trayV, 'faces', [1, 2, 3, 4], 'facecolor', [0.95 0.87 0.73], 'edgecolor', 'none')
%text(handles.axesGrid, xlimits(1)+diff(xlimits)/2, traySurfaceCenterY, '     Tray      Surface', 'fontsize', 9, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');

text(handles.axesGrid, arrowX, arrowY, arrowText, 'horizontalalignment', 'left', 'verticalalignment', 'bottom', 'fontsize', 9);

set(handles.axesGrid, 'xlim', xlimits, 'ylim', ylimits );
set(handles.axesGrid, 'xtick', [], 'xticklabel', '');
set(handles.axesGrid, 'ytick', [], 'yticklabel', '');

end
function addcrosssection(handles)
currentResponseVal = get(handles.listboxResponse, 'value');

% ----updated to ensure no grid positions are highlighted when reponse
% estimates are selected/shown
% % updategridplot(handles)

    cla(handles.axesGrid);
    plot(handles.axesGrid, handles.sumFile.gridYcordUnique, handles.sumFile.gridXcordUnique, ...
        'ko', 'markersize', 16);
    hold(handles.axesGrid, 'on');
    
    % set x y limits based on grid range
    xlimits = [handles.sumFile.gridYcordVector(1) - (handles.sumFile.gridYcordVector(2) - handles.sumFile.gridYcordVector(1) )/2,...
        handles.sumFile.gridYcordVector(end) + (handles.sumFile.gridYcordVector(end) - handles.sumFile.gridYcordVector(end-1))/2 ];
    ylimits = [handles.sumFile.gridXcordVector(1) - (handles.sumFile.gridXcordVector(2) - handles.sumFile.gridXcordVector(1) )/2,...
        handles.sumFile.gridXcordVector(end) + (handles.sumFile.gridXcordVector(end) - handles.sumFile.gridXcordVector(end-1))/2 ];

    % set axes direction depending on srm positive x
    trayThickness = 0.1;
    if strcmp(handles.sumFile.positiveX, 'Down')
        set(handles.axesGrid, 'ydir', 'reverse', 'xdir', 'reverse');
        ylimits(2) = handles.sumFile.gridCenter2tray + trayThickness;
        trayV = [xlimits(1) ylimits(2); xlimits(1) ylimits(2)-trayThickness;...
            xlimits(2) ylimits(2)-trayThickness; xlimits(2) ylimits(2)];
        arrowX = xlimits(2) - 0.05;
        arrowY = ylimits(2)-trayThickness-0.025;
        arrowText = '+X: \downarrow  +Y: \leftarrow';
     
%         traySurfaceCenterY = ylimits(2)-trayThickness;
    else
        ylimits(1) = -handles.sumFile.gridCenter2tray-trayThickness;
        trayV = [xlimits(1) ylimits(1); xlimits(1) ylimits(1)+trayThickness;...
            xlimits(2) ylimits(1)+trayThickness; xlimits(2) ylimits(1)];
        %         traySurfaceCenterY = ylimits(1)+trayThickness;
        arrowX = xlimits(1) + 0.05;
        arrowY = ylimits(1)+trayThickness+0.025;
        arrowText = '+X: \uparrow  +Y: \rightarrow';
    end
    
    %     % checking xlimits issue - 20190625
%     xlimits = [-1.25 1.25];
%     ylimits = [-1.25 1.25];
    
 
    % add grid lines
    for iX = 1:length(handles.sumFile.gridXcordVector)-1
        line(handles.axesGrid, xlimits, [handles.sumFile.gridXcordVector(iX) + ...
            (handles.sumFile.gridXcordVector(iX+1) - handles.sumFile.gridXcordVector(iX))/2, ...
            handles.sumFile.gridXcordVector(iX) + ...
            (handles.sumFile.gridXcordVector(iX+1) - handles.sumFile.gridXcordVector(iX))/2], 'linestyle', '-.');
    end

    for iY = 1:length(handles.sumFile.gridYcordVector)-1
        line(handles.axesGrid, [handles.sumFile.gridYcordVector(iY) + ...
            (handles.sumFile.gridYcordVector(iY+1) - handles.sumFile.gridYcordVector(iY))/2, ...
            handles.sumFile.gridYcordVector(iY) + ...
            (handles.sumFile.gridYcordVector(iY+1) - handles.sumFile.gridYcordVector(iY))/2,], ylimits, 'linestyle', '-.');
    end
    
    text(handles.axesGrid, handles.sumFile.gridYcordUnique, handles.sumFile.gridXcordUnique, ...
        num2cell(handles.sumFile.gridNoUnique), 'horizontalalignment', 'center', 'verticalalignment', 'middle');
% ---end of update
hold(handles.axesGrid, 'on');
plot(handles.axesGrid, handles.response(currentResponseVal).parameters.gridXm, handles.response(currentResponseVal).parameters.gridYm, 'k.', 'markersize', 3);
patch(handles.axesGrid,  'vertices',  [ handles.response(currentResponseVal).parameters.yCenter- handles.response(currentResponseVal).parameters.yWidth/2,  handles.response(currentResponseVal).parameters.xCenter- handles.response(currentResponseVal).parameters.xHeight/2;...
    handles.response(currentResponseVal).parameters.yCenter- handles.response(currentResponseVal).parameters.yWidth/2,  handles.response(currentResponseVal).parameters.xCenter+ handles.response(currentResponseVal).parameters.xHeight/2;...
    handles.response(currentResponseVal).parameters.yCenter+ handles.response(currentResponseVal).parameters.yWidth/2,  handles.response(currentResponseVal).parameters.xCenter+ handles.response(currentResponseVal).parameters.xHeight/2;...
    handles.response(currentResponseVal).parameters.yCenter+ handles.response(currentResponseVal).parameters.yWidth/2,  handles.response(currentResponseVal).parameters.xCenter- handles.response(currentResponseVal).parameters.xHeight/2],...
    'faces', [1, 2, 3, 4], 'FaceColor', [0.6 0.1 0.2],  'FaceAlpha', 0.5);

    % draw tray
    patch(handles.axesGrid, 'vertices', trayV, 'faces', [1, 2, 3, 4], 'facecolor', [0.95 0.87 0.73], 'edgecolor', 'none')
%text(handles.axesGrid, xlimits(1)+diff(xlimits)/2, traySurfaceCenterY, 'Tray          Surface', 'fontsize', 9, 'horizontalalignment', 'center', 'verticalalignment', 'bottom');
text(handles.axesGrid, arrowX, arrowY, arrowText, 'horizontalalignment', 'left', 'verticalalignment', 'bottom', 'fontsize', 9);

    set(handles.axesGrid, 'xlim', xlimits, 'ylim', ylimits );
    set(handles.axesGrid, 'xtick', [], 'xticklabel', '');
    set(handles.axesGrid, 'ytick', [], 'yticklabel', '');
end
function updateresponseplot(handles)
 % update main plot
set(handles.checkboxXraw, 'enable', 'off');
set(handles.checkboxYraw, 'enable', 'off');
set(handles.checkboxZraw, 'enable', 'off');

set(handles.checkboxXX, 'enable', 'on');
set(handles.checkboxXY, 'enable', 'on');
set(handles.checkboxXZ, 'enable', 'on');
set(handles.checkboxYY, 'enable', 'on');
set(handles.checkboxYX, 'enable', 'on');
set(handles.checkboxYZ, 'enable', 'on');
set(handles.checkboxZX, 'enable', 'on');
set(handles.checkboxZY, 'enable', 'on');
set(handles.checkboxZZ, 'enable', 'on');

% find out which terms are selected

selectedTerms.XX = get(handles.checkboxXX, 'value');
selectedTerms.XY = get(handles.checkboxXY, 'value');
selectedTerms.XZ = get(handles.checkboxXZ, 'value');
selectedTerms.YY = get(handles.checkboxYY, 'value');
selectedTerms.YX = get(handles.checkboxYX, 'value');
selectedTerms.YZ = get(handles.checkboxYZ, 'value');
selectedTerms.ZX = get(handles.checkboxZX, 'value');
selectedTerms.ZY = get(handles.checkboxZY, 'value');
selectedTerms.ZZ = get(handles.checkboxZZ, 'value');

% find out which files are selected
currentResponseVal = get(handles.listboxResponse, 'value');
plotresponsefunction(handles, handles.response(currentResponseVal), selectedTerms);
 
end
function updateresponseparameter(handles)

% find out which files are selected
currentResponseVal = get(handles.listboxResponse, 'value');
 
set(handles.editHorizontalOffset, 'string', num2str(handles.response(currentResponseVal).parameters.yCenter));
set(handles.editVerticalOffset, 'string', num2str(handles.response(currentResponseVal).parameters.xCenter));
set(handles.editCrossSecHeight, 'string', num2str(handles.response(currentResponseVal).parameters.xHeight));
set(handles.editCrossSecWidth, 'string', num2str(handles.response(currentResponseVal).parameters.yWidth));
set(handles.editInterpResolutionCross, 'string', num2str(handles.response(currentResponseVal).parameters.interpResCross));
set(handles.editInterpResolutionTrack, 'string', num2str(handles.response(currentResponseVal).parameters.interpResTrack));
set(handles.editLength, 'string', num2str(handles.response(currentResponseVal).parameters.integrationLength));
if handles.response(currentResponseVal).parameters.normOption == 1
    set(handles.radiobutton_MPS, 'value', 1);
    set(handles.radiobutton_maxVal, 'value', 0);
else
    set(handles.radiobutton_maxVal, 'value', 1);
    set(handles.radiobutton_MPS, 'value', 0);
end
end
function plotresponsefunction(handles, response, selectedTerms)
% response must include the following fields
% position, xx, xy, xz, yx, yy, yz, zx, zy, zz
position = response.position;
    ylabelText = 'Integrated Response';
if get(handles.checkbox_ShowNormalised, 'value') == 1
    response.norm.elMatrix = response.elMatrix;
    response.norm.pointSourcePositionEstimated = response.pointSourcePositionEstimated;
    response.norm.pointSourcePositionMeasured = response.pointSourcePositionMeasured;
    response = response.norm;
    ylabelText = 'Integrated Response (Normalized)';
end

markerSize      = 3;
markerFaceColor = [0.7 0.7 0.7];
lineWidth       = 0.5;
fontSize        = 11;

% figure, 
cla(handles.axesMain);
hold(handles.axesMain, 'on');
legendString = '  ';
if selectedTerms.XX
    plot(handles.axesMain, position, response.xx, 'o-', 'color', 'b', 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'XX'];
end

if selectedTerms.XY
    plot(handles.axesMain, position, response.xy, 's-', 'color', [0 0 1], 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'XY'];
end

if selectedTerms.XZ
    plot(handles.axesMain, position, response.xz, '^-', 'color', [0 0 1], 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'XZ'];
end

if selectedTerms.YX
    plot(handles.axesMain, position, response.yx, 'o-', 'color', 'r', 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'YX'];
end

if selectedTerms.YY
    plot(handles.axesMain, position, response.yy, 's-', 'color', 'r', 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'YY'];
end

if selectedTerms.YZ
    plot(handles.axesMain, position, response.yz, '^-', 'color', 'r', 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'YZ'];
end

if selectedTerms.ZX
    plot(handles.axesMain, position, response.zx, 'o-', 'color', [0 0.5 0], 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'ZX'];
end

if selectedTerms.ZY
    plot(handles.axesMain, position, response.zy, 's-', 'color', [0 0.5 0], 'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'ZY'];
end

if selectedTerms.ZZ
    plot(handles.axesMain, position, response.zz, '^-', 'color', [0 0.5 0],  'markersize', markerSize,...
        'markerfacecolor', markerFaceColor, 'linewidth', lineWidth);
    legendString = [legendString; 'ZZ'];
end

legendString(1, :) = [];

%     xlimit = get(gca, 'xlim');
%     ylimit = get(gca, 'ylim');

%     plot(xlimit, [0 0], 'k--', 'linewidth', lineWidth);
%     plot(xlimit, [1 1], 'k--', 'linewidth', lineWidth);
%     plot([0 0], ylimit, 'k--', 'linewidth', lineWidth);
    set(handles.axesMain, 'fontsize', fontSize, 'xminortick', 'on', 'yminortick', 'on'); %, 'ylim', [-0.1 1.1]);

% show full EL matrix
currentAxisYlimit = get(handles.axesMain, 'ylim');
currentAxisXlimit = get(handles.axesMain, 'xlim');

annotationTextPart1 = '  Nine-term effective lengths matrix';
annotationTextPart2 =  ['   XX:', num2str(response.elMatrix(1, 1), '%+8.4f'),...
                        '   YX:', num2str(response.elMatrix(1, 2), '%+8.4f'),...
                        '   ZX:', num2str(response.elMatrix(1, 3), '%+8.4f');...
                        '   XY:', num2str(response.elMatrix(2, 1), '%+8.4f'),...
                        '   YY:', num2str(response.elMatrix(2, 2), '%+8.4f'),...
                        '   ZY:', num2str(response.elMatrix(2, 3), '%+8.4f');...
                        '   XZ:', num2str(response.elMatrix(3, 1), '%+8.4f'),...
                        '   YZ:', num2str(response.elMatrix(3, 2), '%+8.4f'),...
                        '   ZZ:', num2str(response.elMatrix(3, 3), '%+8.4f')];

annotationTextPart3  = '  Point source position on SRM tray';                  
annotationTextPart4  = ['   User measured:       ', num2str(response.pointSourcePositionMeasured,  '%5.2f'), ' cm';...
                        '   URESPONSE estimated: ', num2str(response.pointSourcePositionEstimated, '%5.2f'), ' cm'];                     

annotationText = {annotationTextPart1; annotationTextPart2; ''; annotationTextPart3; annotationTextPart4};

text(handles.axesMain, ...
     currentAxisXlimit(1), ...
     currentAxisYlimit(2) - diff(currentAxisYlimit)/35,...
     annotationText, 'horizontalalignment', 'left',...
     'verticalalignment', 'top', 'fontsize', 12, 'fontname', 'fixedwidth'); 
 
hold(handles.axesMain, 'off');
     % check legend status
 if  strcmp(get(handles.uitoggletoolLegend, 'state'), 'on') % legend toggle is on    
     legend(handles.axesMain, legendString);     
 else
     legend(handles.axesMain, 'off');     
 end
 
 % check grid status
  if  strcmp(get(handles.uitoggletoolGrid, 'state'), 'on') % grid toggle is on    
     grid(handles.axesMain, 'on');
  else
      grid(handles.axesMain, 'off');
  end
 xlabel(handles.axesMain, 'Position (cm)');
 ylabel(handles.axesMain, ylabelText);
   
end
function response = getresponse(m3d, parameters)
 
    % establish new position vector
    position = m3d.position(1):parameters.interpResTrack:m3d.position(end);
    
    % associate parameter to reponse
    response.parameters = parameters; 

    % establish new grids
    [x, y, z] = meshgrid(parameters.gridVertical, parameters.gridHorizontal, position);
    
    % interpolation at max section
    mxx = interp3(m3d.x, m3d.y, m3d.z, m3d.xx,   x, y, z, 'spline');
    mxy = interp3(m3d.x, m3d.y, m3d.z, m3d.xy,   x, y, z, 'spline');
    mxz = interp3(m3d.x, m3d.y, m3d.z, m3d.xz,   x, y, z, 'spline');
    myx = interp3(m3d.x, m3d.y, m3d.z, m3d.yx,   x, y, z, 'spline');
    myy = interp3(m3d.x, m3d.y, m3d.z, m3d.yy,   x, y, z, 'spline');
    myz = interp3(m3d.x, m3d.y, m3d.z, m3d.yz,   x, y, z, 'spline');
    mzx = interp3(m3d.x, m3d.y, m3d.z, m3d.zx,   x, y, z, 'spline');
    mzy = interp3(m3d.x, m3d.y, m3d.z, m3d.zy,   x, y, z, 'spline');
    mzz = interp3(m3d.x, m3d.y, m3d.z, m3d.zz,   x, y, z, 'spline');
    
    % sum over cross section
    xx = squeeze(mean(mean(mxx, 1), 2));
    xy = squeeze(mean(mean(mxy, 1), 2));
    xz = squeeze(mean(mean(mxz, 1), 2));
    yx = squeeze(mean(mean(myx, 1), 2));
    yy = squeeze(mean(mean(myy, 1), 2));
    yz = squeeze(mean(mean(myz, 1), 2));
    zx = squeeze(mean(mean(mzx, 1), 2));
    zy = squeeze(mean(mean(mzy, 1), 2));
    zz = squeeze(mean(mean(mzz, 1), 2));
    
    allowIntegrationAlongTrack = 1; % integration over a length
%     if allowIntegrationAlongTrack == 1
%         span = round(parameters.integrationLength./parameters.interpResTrack);
%         xx = smooth(xx, span);
%         xy = smooth(xy, span);
%         xz = smooth(xz, span);
%         yx = smooth(yx, span);
%         yy = smooth(yy, span);
%         yz = smooth(yz, span);
%         zx = smooth(zx, span);
%         zy = smooth(zy, span);
%         zz = smooth(zz, span);    
%     end
    if allowIntegrationAlongTrack == 1  % avoid using smooth - new function developed for better integration
        xx = integrate_response(xx, parameters.interpResTrack, parameters.integrationLength);
        xy = integrate_response(xy, parameters.interpResTrack, parameters.integrationLength);
        xz = integrate_response(xz, parameters.interpResTrack, parameters.integrationLength);
        yx = integrate_response(yx, parameters.interpResTrack, parameters.integrationLength);
        yy = integrate_response(yy, parameters.interpResTrack, parameters.integrationLength);
        yz = integrate_response(yz, parameters.interpResTrack, parameters.integrationLength);
        zx = integrate_response(zx, parameters.interpResTrack, parameters.integrationLength);
        zy = integrate_response(zy, parameters.interpResTrack, parameters.integrationLength);
        zz = integrate_response(zz, parameters.interpResTrack, parameters.integrationLength);
    end
    
    % decide the center position of the response using xx and yy - need
    % high resolution interpolation first - using 0.01 cm for now
    tempPosition = (position(1):0.01:position(end))';
    xxHighRes = interp1(position, xx, tempPosition, 'spline');
    yyHighRes = interp1(position, yy, tempPosition, 'spline');
    [~, maxXXindex] = max(abs(xxHighRes));
    [~, maxYYindex] = max(abs(yyHighRes));
    centerPosition  = mean([tempPosition(maxXXindex), tempPosition(maxYYindex)]);
    
    % create final response position 
    nLeft  = floor((centerPosition - min(position))./parameters.interpResTrack);
    nRight = floor((max(position) - centerPosition)./parameters.interpResTrack);
    nHalf  = min([nLeft, nRight]);
    newPosition = (centerPosition-nHalf*parameters.interpResTrack):...
        parameters.interpResTrack:...
        (centerPosition+nHalf*parameters.interpResTrack);
    
    response.xx = interp1(position, xx, newPosition, 'spline');
    response.xy = interp1(position, xy, newPosition, 'spline');
    response.xz = interp1(position, xz, newPosition, 'spline');
    response.yx = interp1(position, yx, newPosition, 'spline');
    response.yy = interp1(position, yy, newPosition, 'spline');
    response.yz = interp1(position, yz, newPosition, 'spline');
    response.zx = interp1(position, zx, newPosition, 'spline');
    response.zy = interp1(position, zy, newPosition, 'spline');
    response.zz = interp1(position, zz, newPosition, 'spline');
    
    % create a normalised version of the response
    if parameters.normOption == 1
        % use point source momment value as normaliser 
        normVal = parameters.pointSourceMoment; 
    else
        % use mean XX and YY at center position as normaliser
        normVal = (response.xx(nHalf+1)  + response.yy(nHalf+1))/2;
    end
    response.norm.xx = response.xx./normVal;
    response.norm.xy = response.xy./normVal;
    response.norm.xz = response.xz./normVal;
    response.norm.yx = response.yx./normVal;
    response.norm.yy = response.yy./normVal;
    response.norm.yz = response.yz./normVal;
    response.norm.zx = response.zx./normVal;
    response.norm.zy = response.zy./normVal;
    response.norm.zz = response.zz./normVal;
    
    response.position = newPosition - centerPosition;

   %  cross section area, interval thickness, and lr 
   response.area = parameters.yWidth*parameters.xHeight; 
   response.intervalThickness = parameters.interpResTrack; 
   response.lr = nHalf; 
   response.pointSourcePositionEstimated = centerPosition;
   response.pointSourcePositionMeasured  = parameters.pointSourcePosition; 
   
   response.elMatrix = response.intervalThickness.*[sum(response.norm.xx), sum(response.norm.yx), sum(response.norm.zx); ...
                                                    sum(response.norm.xy), sum(response.norm.yy), sum(response.norm.zy); ...
                                                    sum(response.norm.xz), sum(response.norm.yz), sum(response.norm.zz)];
                                    
   
end
function [dec, inc, int] = calculate_xyz2dii(x, y, z)
    % XYZ2DII converts x, y, and z axis magnetic moments to dec, inc, and int.
    %
    % INPUT
    %       x: magnetic vector component on x axis
    %       y: magnetic vector component on y axis
    %       z: magnetic vector component on z axis
    % OUTPUT
    %       dec: declination of the magnetic vector
    %       inc: inclination of the magnetic vector
    %       int: intensity of the magnetic vector
    %
    % Algorithm based on Long Core v3.0 User's Guide (Page 10:2)

    int = sqrt(x.^2 + y.^2 + z.^2);
    inc = atand(z./sqrt(x.^2 + y.^2));

    dec = zeros(size(x));
    for iRow = 1:length(x)
        if     x(iRow) < 0 
               dec(iRow) = atand(y(iRow)/x(iRow)) + 180;
        elseif x(iRow) > 0 && y(iRow) <= 0
               dec(iRow) = atand(y(iRow)/x(iRow)) + 360;
        else
               dec(iRow) = atand(y(iRow)/x(iRow));
        end
    end
end
function integratedResponse = integrate_response(response, responseRes, integrationRes)

[nRow, nColumn] = size(response);
if nRow > 1 && nColumn > 1
    error('Input ''response'' for function integrate_response must be a vector');
end

if responseRes > integrationRes
    error('Integration interval legnth must be larger than inteperlation resolution along the track.');
end

if nRow == 1 && nColumn >1 % if response is row  vector, change it to column vector
    response = response';
end


nResponse = length(response);
integratedResponse = nan(nResponse, 1);

% 
if rem(integrationRes/2, responseRes) == 0 % true for most cased, i.e. responseRes = 0.1, integrateionRes = 1
    halfWindowSize = round(integrationRes/2/responseRes);
    % pad first values and last values to ends
    responseNew = [ones(halfWindowSize, 1)*response(1); response; ones(halfWindowSize, 1)*response(end)];
    for iRow = 1:nResponse
         integratedResponse(iRow) = mean(responseNew(halfWindowSize +( (iRow - halfWindowSize):(iRow + halfWindowSize))));
        
    end
    
    
elseif integrationRes == responseRes
    integratedResponse = response;
   
else 
    
    base =  integrationRes/10;
    
    while base > responseRes 
            base = base/2;  % make sure base is smaller than responseRes;
    end
    
    halfWindowSize = round(integrationRes/2/base);
    responseNew = [ones(halfWindowSize, 1)*response(1); response; ones(halfWindowSize, 1)*response(end)];

     for iRow = 1:nResponse
         positionOld = (-halfWindowSize:halfWindowSize)*responseRes;
         responsePartOld = responseNew(halfWindowSize +( (iRow - halfWindowSize):(iRow + halfWindowSize)));
         positionNew =  (-halfWindowSize:halfWindowSize)*base;
         responsePartNew = interp1(positionOld, responsePartOld, positionNew, 'spline'); 
         integratedResponse(iRow) = mean(responsePartNew);        
    end

end


end
