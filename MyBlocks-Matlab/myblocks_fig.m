function varargout = myblocks_fig(varargin)
% MYBLOCKS_FIG MATLAB code for myblocks_fig.fig
%      MYBLOCKS_FIG, by itself, creates a new MYBLOCKS_FIG or raises the existing
%      singleton*.
%
%      H = MYBLOCKS_FIG returns the handle to a new MYBLOCKS_FIG or the handle to
%      the existing singleton*.
%
%      MYBLOCKS_FIG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MYBLOCKS_FIG.M with the given input arguments.
%
%      MYBLOCKS_FIG('Property','Value',...) creates a new MYBLOCKS_FIG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before myblocks_fig_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to myblocks_fig_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES
 
% Edit the above text to modify the response to help myblocks_fig
 
% Last Modified by GUIDE v2.5 18-Jul-2016 17:44:06
 
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @myblocks_fig_OpeningFcn, ...
                   'gui_OutputFcn',  @myblocks_fig_OutputFcn, ...
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
 
 
% --- Executes just before myblocks_fig is made visible.
function myblocks_fig_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to myblocks_fig (see VARARGIN)
 
% Choose default command line output for myblocks_fig
handles.output = hObject;
 
% Update handles structure
guidata(hObject, handles);
 
% UIWAIT makes myblocks_fig wait for user response (see UIRESUME)
% uiwait(handles.figure1);
 
 
% --- Outputs from this function are returned to the command line.
function varargout = myblocks_fig_OutputFcn(~, ~, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
% Get default command line output from handles structure
varargout{1} = handles.output;
 
 
% --- Executes on button press in FFT.
function FFT_Callback(~, ~, ~)
 
MoveInterval=0.12;
[y,Fs] = audioread('test2.wav');
frequency=linspace(0,0,60000);
location=linspace(0,0,60000); 
sigLength=length(y); 
n=fix(sigLength/(MoveInterval*Fs));
y=y';
for i=0:n-1
    tempwav=y(round(i*MoveInterval*44100+1):round((i+1)*MoveInterval*44100+1));
    tempwav=tempwav';
    Length=length(tempwav); 
    Y = fft(tempwav,Length); 
    Pyy = Y.* conj(Y) / Length;
    
    for j=1:7
        step=round(100*Length/Fs);
        frequency(i * 7 + j) = (Pyy(j*step - 4) + Pyy(j*step - 3) + Pyy(j*step - 2) + Pyy(j*step - 1) + Pyy(j*step) + Pyy(j*step + 1) + Pyy(j*step + 2)+Pyy(j*step + 3) + Pyy(j*step + 4)) / 9;
    end
end
for i=1:n*7
    if frequency(i)<0.03%366
        location(i)=20;
    elseif frequency(i)<=0.1%864
        location(i)=20+(frequency(i)-0.03)*3000;
    elseif frequency(i)<=0.3%1557
        location(i)=230+(frequency(i)-0.1)*1500;
    elseif frequency(i)<=0.8
        location(i)=530+(frequency(i)-0.3)*250; 
    elseif frequency(i)<=2
        location(i)=655+(frequency(i)-0.8)*100;
    elseif frequency(i)<=5
        location(i)=785+(frequency(i)-2)*30;
    elseif frequency(i)<=10
        location(i)=875+(frequency(i)-5)*10;
    elseif frequency(i)<=30
        location(i)=875+(frequency(i)-5)*5;
    elseif frequency(i)>30
        location(i)=1000;
    else location(i)=1024;
    end
end
y=y';
location=round(location);
location=location+20;







s1=serial('COM10');
s2=serial('COM7');
fopen(s2);
fopen(s1);
pause(1);

out1=fgetl(s1);
temp=out1;

[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);
[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);

sound(y,Fs);
for i=0:n-1
    if out1==temp
        fprintf(s1,'%d',location(7*i+7));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+3));
        fprintf(s1,'%s',' ');
        
   
       fprintf(s2,'%d',location(7*i+5)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+4)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+3));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+2));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+4));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+3));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+2));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+1));
        fprintf(s2,'%s','\n');
       out1=fgetl(s2);
    end
end


fprintf(s1,'%s','\n');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s','\n');
 
fprintf(s2,'%s','\n');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s','\n');



fclose(s1);
fclose(s2);


 
 
 
% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, ~, ~)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
 
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
 
 
% --- Executes on button press in draw.
function draw_Callback(~, ~, ~)
% hObject    handle to draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[y,~] = audioread('test.wav');
x=1:length(y);
figure;
plot(x,y);
xlabel(' ±”Ú');
title('“Ù∆µ ±”ÚÕº');
 
 
% --- Executes on button press in wave.
function wave_Callback(~, ~, ~)
% hObject    handle to wave (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
MoveInterval=0.125;
location_temp=1:150:901;
location=linspace(0,0,7000); 

for j=1:7
    location(j)=location_temp(j);
end
for i=1:1000-1
    for j=1:7
    location(i*7+j)=rem(location((i-1)*7+j)+150,900);
    end
end
location=location+100;
s1=serial('COM10');
s2=serial('COM7');
fopen(s2);
fopen(s1);
out1=fgetl(s1);
out2=fgetl(s2);
temp=out1;

for i=1:10000
    if out1==temp
        fprintf(s1,'%d',location(7*i+7));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
       
        
 
       fprintf(s2,'%d',location(7*i+5)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+4)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+3));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+2));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+4));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+3));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+2));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+1));
        fprintf(s2,'%s','\n');
        
         fprintf(s1,'%d',location(7*i+3));
        fprintf(s1,'%s',' ');
       out1=fgetl(s1);
    end
    
    
    
end


fprintf(s1,'%s','\n');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s','\n');
 
fprintf(s2,'%s','\n');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s','\n');


fclose(s1);
fclose(s2);

 
 
 
% --- Executes on button press in Excel.
function Excel_Callback(~, ~, ~)
% hObject    handle to Excel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
im=imread('score_3d.png');
figure;
imshow(im);
score=1:12;
score(1)=73.93;
score(2)=76.77;
score(3)=77.83;
score(4)=79.56;
score(5)=72.94;
score(6)=74.51;
score(7)=79.19;
score(8)=72.02;
score(9)=76.41;
score(10)=77.46;
score(11)=77.83;
score(12)=20;
 
for i=1:11
    score(i)=round((score(i)-70)*100+50);
end
 
s1=serial('COM10');
s2=serial('COM7');
fopen(s1);
fopen(s2);
pause(1);
[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);
[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);
for i=1:50
fprintf(s1,'%d',score(4));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(8));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(12));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(12));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(3));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(7));
fprintf(s1,'%s',' ');
fprintf(s1,'%d',score(11));
fprintf(s1,'%s',' ');

 
fprintf(s2,'%d',score(2));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(6));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(12));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(12));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(1));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(5));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(12));
fprintf(s2,'%s',' ');
fprintf(s2,'%d',score(12));
fprintf(s2,'%s','\n');

fprintf(s1,'%d',score(12));
fprintf(s1,'%s','\n');
end;



fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s','\n');
 
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s','\n');

fclose(s1);
fclose(s2);
 
 
 
 
 
% --- Executes on button press in reset.
function reset_Callback(~, ~, ~)
% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
fprintf(s1,'%s','\n');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s','\n');
 
fprintf(s2,'%s','\n');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',500); 
fprintf(s2,'%s','\n');
 
fclose(s1);
fclose(s2);
 
 
% --- Executes on button press in Initiallize.
function Initiallize_Callback(~, ~, ~)
% hObject    handle to Initiallize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
s1=serial('COM10');
s2=serial('COM7');
 
fopen(s1);
fopen(s2);
 
 
% --- Executes on button press in pushbutton7.
function pushbutton7_Callback(~, ~, ~)
% hObject    handle to pushbutton7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 
MoveInterval=0.4;
[y,Fs] = audioread('test.wav');
frequency=linspace(0,0,60000);
location=linspace(0,0,60000); 
sigLength=length(y); 
n=fix(sigLength/(MoveInterval*Fs));
y=y';
for i=0:n-1
    tempwav=y(round(i*MoveInterval*44100+1):round((i+1)*MoveInterval*44100+1));
    tempwav=tempwav';
    Length=length(tempwav); 
    Y = fft(tempwav,Length); 
    Pyy = Y.* conj(Y) / Length;
    
    for j=1:7
        step=round(100*Length/Fs);
        frequency(i * 7 + j) = (Pyy(j*step - 4) + Pyy(j*step - 3) + Pyy(j*step - 2) + Pyy(j*step - 1) + Pyy(j*step) + Pyy(j*step + 1) + Pyy(j*step + 2)+Pyy(j*step + 3) + Pyy(j*step + 4)) / 9;
    end
end
for i=1:n*7
    if frequency(i)<0.03%366
        location(i)=20;
    elseif frequency(i)<=0.1%864
        location(i)=20+(frequency(i)-0.03)*3000;
    elseif frequency(i)<=0.3%1557
        location(i)=230+(frequency(i)-0.1)*1500;
    elseif frequency(i)<=0.8
        location(i)=530+(frequency(i)-0.3)*250; 
    elseif frequency(i)<=2
        location(i)=655+(frequency(i)-0.8)*100;
    elseif frequency(i)<=5
        location(i)=785+(frequency(i)-2)*30;
    elseif frequency(i)<=10
        location(i)=875+(frequency(i)-5)*10;
    elseif frequency(i)<=30
        location(i)=875+(frequency(i)-5)*5;
    elseif frequency(i)>30
        location(i)=1000;
    else location(i)=1024;
    end
end
y=y';
location=round(location);
location=location+20;
 
 
 
 
 
 
 
 
s1=serial('COM7');
fopen(s1);
pause(1);
out1=fgetl(s1);
temp=out1;
sound(y,Fs);
for i=0:n-1
    if out1==temp
        fprintf(s1,'%d',location(7*i+7));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+3));
        fprintf(s1,'%s','\n');
        pause(0.1);
        out1=fgetl(s1);
    end
end
 
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',500); 
fprintf(s1,'%s','\n');
 
fclose(s1);
 
 
 
 
 


% --- Executes on button press in displaymodle2.
function displaymodle2_Callback(~, ~, ~)
% hObject    handle to displaymodle2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



location_temp=1:60:901;
location=linspace(0,0,7000); 


for j=1:16
    location(j)=location_temp(j);
end

for i=1:1000-1
    for j=1:16
    location(i*16+j)=rem(location((i-1)*16+j)+60,900);
    end
end

location=location+100;
s1=serial('COM10');
s2=serial('COM7');
fopen(s2);
fopen(s1);
pause(1);

out1=fgetl(s1);
out2=fgetl(s2);
temp=out1;

[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);
[~,y2] = sinwave(3000,44100,0.1);
sound(y2,44100);
pause(0.2);

for i=0:9999
    if out1==temp
        fprintf(s1,'%d',location(7*i+1));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+2));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+3));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+4));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+8));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+7));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+6));
        fprintf(s1,'%s',' ');
        fprintf(s1,'%d',location(7*i+5));
        fprintf(s1,'%s',' ');
       
   
       fprintf(s2,'%d',location(7*i+9)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+10)); 
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+11));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+12));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+16));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+15));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+14));
        fprintf(s2,'%s',' ');
       fprintf(s2,'%d',location(7*i+13));
        fprintf(s2,'%s','\n');
       out1=fgetl(s1);
    end
end


fprintf(s1,'%s','\n');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s',' ');
fprintf(s1,'%d',30); 
fprintf(s1,'%s','\n');
 
fprintf(s2,'%s','\n');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s',' ');
fprintf(s2,'%d',30); 
fprintf(s2,'%s','\n');



fclose(s1);
fclose(s2);


