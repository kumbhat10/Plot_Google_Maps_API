function [varargout] = GUI_MAP(varargin)
% GUI_MAP MATLAB code for GUI_MAP.fig
%      GUI_MAP, by itself, creates a new GUI_MAP or raises the existing
%      singleton*.
%
%      H = GUI_MAP returns the handle to a new GUI_MAP or the handle to
%      the existing singleton*.
%
%      GUI_MAP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI_MAP.M with the given input arguments.
%
%      GUI_MAP('Property','Value',...) creates a new GUI_MAP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_MAP_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_MAP_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI_MAP

% Last Modified by GUIDE v2.5 11-Jan-2017 15:08:56

%% Begin initialization code - DO NOT EDIT




%  
% % global var_list2 var_list variable1 variable2



var_list = {'Vehicle Speed','Battery SOC','Battery Temperature','Fuel Consumption','Engine Temperature'};
assignin('base','var_list',var_list)




gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_MAP_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_MAP_OutputFcn, ...
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
% End initialization code - DO NOT EDIT

% --- Executes just before GUI_MAP is made visible.
function GUI_MAP_OpeningFcn(hObject, eventdata, handles, varargin)
%% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI_MAP (see VARARGIN)

% Choose default command line output for GUI_MAP
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_MAP wait for user response (see UIRESUME)
% uiwait(handles.figure1);
a= imread('scale_red_green.jpg');
image(a,'Parent', handles.axes2)
set(handles.axes2,'visible','off')

% a= imread('roadmap.jpg');
% image(a,'Parent', handles.axes3)
% set(handles.axes3,'visible','off')

set(get(handles.axes7,'children'),'visible','off')

a= imread('pin.jpg');
image(a,'Parent', handles.axes4)
set(handles.axes4,'visible','off')

a= imread('MS.jpg');
image(a,'Parent', handles.axes1)
set(handles.axes1,'visible','off')

 a= imread('single_roadmap.jpg');
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

map_type =1;
assignin('base','map_type',map_type)
info_marker = 1;
assignin('base','info_marker',info_marker)

map_view =1;
assignin('base','map_view',map_view)

 colour_type = 1;
 assignin('base','colour_type',colour_type)

  file = [];
     assignin('base','file',file)
   
     folder_name=[];
 assignin('base','folder_name',folder_name)    
% --- Outputs from this function are returned to the command line.
function varargout = GUI_MAP_OutputFcn(hObject, eventdata, handles) 
%% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)      %%SINGLE VARIABLE SINGLE SIDE
%%
% while(1)
%    pause(0.3)
%    
%     set(handles.text2,'Enable','off','Visible','off')
%    pause(0.2)
%      set(handles.text2,'Enable','on','Visible','on')
% end


  if get(hObject,'Value')
      map_type =1;
    set(handles.radiobutton2,'Value',0)
    set(handles.text_var2,'Enable','off','Visible','off')
    set(handles.popup_var2,'Enable','off','Visible','off','String','Select First Variable','Value',1)
      
    if get(handles.radiobutton8,'Value')==1
    a= imread('single_roadmap.jpg');
    else
     a= imread('single_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

  else
    map_type = 2;
    set(handles.radiobutton2,'Value',1)
    set(handles.text_var2,'Enable','on','Visible','on')
    set(handles.popup_var2,'Enable','on','Visible','on')
    
    if get(handles.radiobutton8,'Value')==1
    a= imread('double_roadmap.jpg');
    else
     a= imread('double_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

  end

assignin('base','map_type',map_type)


% --- Executes during object creation, after setting all properties.
function radiobutton1_CreateFcn(hObject, eventdata, handles)
    %%
% map_type =1;
% assignin('base','map_type',map_type)


% --- Executes on button press in radiobutton2.
function radiobutton2_Callback(hObject, eventdata, handles)  %% DOUBLE VARIABLE SIDE BY SIDE
%%
 if get(hObject,'Value')
      map_type =2;
    set(handles.radiobutton1,'Value',0)
    set(handles.text_var2,'Enable','on','Visible','on')
    set(handles.popup_var2,'Enable','on','Visible','on')
    
    if get(handles.radiobutton8,'Value')==1
    a= imread('double_roadmap.jpg');
    else
     a= imread('double_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

  else
    map_type = 1;
    set(handles.radiobutton1,'Value',1)
    set(handles.text_var2,'Enable','off','Visible','off')
    set(handles.popup_var2,'Enable','off','Visible','off','String','Select First Variable','Value',1)
    
    if get(handles.radiobutton8,'Value')==1
    a= imread('single_roadmap.jpg');
    else
     a= imread('single_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')  
    
  end
assignin('base','map_type',map_type)


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)         %% browse file push button 
%%
[folder_name,pn] = uigetfile(cd,'dialog_title','*.mat');
if length(folder_name)~=1 && length(pn)~=1
file = [pn,folder_name];
assignin('base','file',file)
assignin('base','folder_name',folder_name)

set(hObject,'Userdata',file)
set(handles.text10,'String',file)
else
    file = [];
     assignin('base','file',file)
    set(hObject,'Userdata',file) 
    set(handles.text10,'String','NO FILE SELECTED')
%     assignin('base','file',file)
    
end

%  --- Executes on selection change in popup_var1.
 function popup_var1_Callback(hObject, eventdata, handles)     %% variable 1 popup menu
%%
% global var_list2 var_list variable1 variable2
contents = (get(hObject,'String'));
variable1 = contents{get(hObject,'Value')};
assignin('base','variable1',{variable1})

var_list2 = {'Vehicle Speed','Battery SOC','Battery Temperature','Fuel Consumption','Engine Temperature'};
var_list2(strmatch(variable1, var_list2))=[];
assignin('base','var_list2',var_list2)

set(handles.popup_var2,'String',var_list2)
contents = (get(handles.popup_var2,'String'));
variable2 = contents{get(handles.popup_var2,'Value')};
assignin('base','variable2',{variable2})

function popup_var1_CreateFcn(hObject, eventdata, handles)       %% variable 1 popup menu
%%
% % global var_list2 var_list variable1 
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
var_list1 = {'Vehicle Speed','Battery SOC','Battery Temperature','Fuel Consumption','Engine Temperature'};
set(hObject,'String',var_list1)
contents = (get(hObject,'String'));
variable1 = contents{get(hObject,'Value')};
assignin('base','variable1',{variable1})

% --- Executes on selection change in popup_var2.
function popup_var2_Callback(hObject, eventdata, handles)    %% variable 2 popup menu 
%%
% global var_list2 var_list variable1 variable2
    contents = cellstr(get(hObject,'String'));
     bb=get(hObject,'Value');
  
     if length(contents) >=bb
  variable2 = contents{bb};
assignin('base','variable2',{variable2})
    end

% --- Executes during object creation, after setting all properties.
function popup_var2_CreateFcn(hObject, eventdata, handles)   %% variable 2
%%
% global var_list2 var_list variable1 variable2
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%  set(hObject,'String',var_list2)


% --- Executes on button press in radiobutton8.
function radiobutton8_Callback(hObject, eventdata, handles)    %% roadmap callback
%     % global var_list2 var_list variable1 variable2
if get(hObject,'Value')
      map_view =1;
    set(handles.radiobutton9,'Value',0)
   
    assignin('base','map_view',map_view)
    
if get(handles.radiobutton1,'Value')==1
    a= imread('single_roadmap.jpg');
    else
     a= imread('double_roadmap.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')



  else
    map_view =2;
    set(handles.radiobutton9,'Value',1)
    
    if get(handles.radiobutton1,'Value')==1
    a= imread('single_satellite.jpg');
    else
     a= imread('double_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')



end


% --- Executes on button press in radiobutton9.
function radiobutton9_Callback(hObject, eventdata, handles)          %% satellite callback
%%
if get(hObject,'Value')
      map_view =2;
    set(handles.radiobutton8,'Value',0)
   
   if get(handles.radiobutton1,'Value')==1
    a= imread('single_satellite.jpg');
    else
     a= imread('double_satellite.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

else
    map_view =1;
    set(handles.radiobutton8,'Value',1)
     
    if get(handles.radiobutton1,'Value')==1
    a= imread('single_roadmap.jpg');
    else
     a= imread('double_roadmap.jpg');   
    end
image(a,'Parent', handles.axes6)
set(handles.axes6,'visible','off')

end
  assignin('base','map_view',map_view)

% --- Executes on button press in radiobutton10.

 
 
% --- Executes on button press in radiobutton11.
function radiobutton11_Callback(hObject, eventdata, handles)  %% yes  info marker
%%
    if get(hObject,'Value')
      info_marker = 1;
    set(handles.radiobutton12,'Value',0)   
     set(get(handles.axes4,'children'),'visible','on')
 else
    info_marker = 0;
    set(handles.radiobutton12,'Value',1)
    set(get(handles.axes4,'children'),'visible','off')
end
assignin('base','info_marker',info_marker)


% --- Executes on button press in radiobutton12.
function radiobutton12_Callback(hObject, eventdata, handles) %% no  info marker
%%
    if get(hObject,'Value')
      info_marker = 0;
    set(handles.radiobutton11,'Value',0)   
     set(get(handles.axes4,'children'),'visible','off')
 else
    info_marker = 1;
    set(handles.radiobutton11,'Value',1)
     set(get(handles.axes4,'children'),'visible','on')
end
assignin('base','info_marker',info_marker)


% --- Executes during object creation, after setting all properties.



function radiobutton13_Callback(hObject, eventdata, handles)   %%colour scale red green
 %%  --- Executes on button press in radiobutton13.       
if get(hObject,'Value')
      colour_type = 1;
    set(handles.radiobutton14,'Value',0)   
a= imread('scale_red_green.jpg');
image(a,'Parent', handles.axes2)
set(handles.axes2,'visible','off')
 else
   colour_type = 2;
    set(handles.radiobutton14,'Value',1)
      a= imread('scale_red_blue.jpg');
image(a,'Parent', handles.axes2)
set(handles.axes2,'visible','off')
end
assignin('base','colour_type',colour_type)


% --- Executes on button press in radiobutton14.
function radiobutton14_Callback(hObject, eventdata, handles)       %%colour scale red blue
  %%
  a= imread('scale_red_blue.jpg');
    if get(hObject,'Value')
      colour_type = 2;
    set(handles.radiobutton13,'Value',0) 
      a= imread('scale_red_blue.jpg');
image(a,'Parent', handles.axes2)
set(handles.axes2,'visible','off')
 else
   colour_type = 1;
    set(handles.radiobutton13,'Value',1)
    a= imread('scale_red_green.jpg');
image(a,'Parent', handles.axes2)
set(handles.axes2,'visible','off')
end
assignin('base','colour_type',colour_type)

% --- Executes during object creation, after setting all properties.
function axes2_CreateFcn(hObject, eventdata, handles)
%% hObject    handle to axes2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes2


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
xxxxx=33
  
colour_type = evalin('base','colour_type');%   

%  file = get(handles.pushbutton1,'Userdata') 
  file = evalin('base','file');
    folder_name= evalin('base','folder_name');
   info_marker  = evalin('base','info_marker');
   map_type   = evalin('base','map_type');
      variable1 = evalin('base','variable1');
map_view   = evalin('base','map_view');
      
  contents = length(cellstr(get(handles.popup_var2,'String')));
  
  range_speed = [30 60 90 ];
%   get(handles.radiobutton2,'Value')
  if isempty(file)
  warndlg('Please browse the test data file first','No test File selected')
  
  elseif get(handles.radiobutton2,'Value')==1 & contents==1
    warndlg('Please select both the VARIABLES','Variable not selected')
  else
     disp( 'pass')     
     set(hObject,'Enable','off','Visible','off') %%HIDE PUSHBUTTON
    
    set(handles.text11,'Enable','on','Visible','on')   %DISPLAY PROGRESS
    set(handles.text12,'Enable','on','Visible','on')  %DISPLAY PROGRESS

    a= imread('wait.jpg');
%      a= imread('pin_blue.png');
image(a,'Parent', handles.axes7)
set(handles.axes7,'visible','off')
set(get(handles.axes7,'children'),'visible','on')

     if get(handles.radiobutton1,'Value')==1
          run('plot_google_maps_single_gui.m')
%             
     elseif get(handles.radiobutton2,'Value')==1
         variable2  = evalin('base','variable2');
     run('plot_google_maps_double_gui.m')
   
     end
      set(hObject,'Enable','on','Visible','on')
      
      set(handles.text11,'Enable','off','Visible','off')
    set(handles.text12,'Enable','off','Visible','off')    
     set(handles.text12,'String','Please wait....Work in progress...')
     set(get(handles.axes7,'children'),'visible','off')   
  end
  
% --- Executes during object deletion, before destroying properties.
function axes4_DeleteFcn(hObject, eventdata, handles)
% hObject    handle to axes4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function text2_CreateFcn(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function text10_CreateFcn(hObject, eventdata, handles)    %% browse text box 
set(hObject,'String','NO FILE SELECTED')


% --- Executes during object creation, after setting all properties.
function radiobutton8_CreateFcn(hObject, eventdata, handles)
% hObject    handle to radiobutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
