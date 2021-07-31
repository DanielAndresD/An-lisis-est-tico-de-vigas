function varargout = pfinal(varargin)

gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @pfinal_OpeningFcn, ...
                   'gui_OutputFcn',  @pfinal_OutputFcn, ...
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

function pfinal_OpeningFcn(hObject, eventdata, handles, varargin)
plot(0,0)
title ('Diagrama de Cortante')
xlabel ('Longitud (m)')
ylabel ('Fuerza cortante (N)')
grid off
grid
axes(handles.momento)
plot(0,0)
title ('Diagrama de Momento')
xlabel ('Longitud (m)')
ylabel ( 'Momento (N.m)')

handles.output = hObject;

guidata(hObject, handles);

function varargout = pfinal_OutputFcn(hObject, eventdata, handles) 
varargout{1} = handles.output;

function cortante_CreateFcn(hObject, eventdata, handles)

function momento_CreateFcn(hObject, eventdata, handles)



function longitud_Callback(hObject, eventdata, handles)

function longitud_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function apoyos_Callback(hObject, eventdata, handles)
global v
v = get(handles.apoyos,'Value');
switch v
    case 1
set (handles.msnlongitud,'string','');
set (handles.msnamplitud,'string','');
set (handles.apoyofijo,'string','');
set (handles.apoyopatin,'string','');
axes(handles.diagrama)
handles.diagrama=imread('CASO1.JPG');
imagesc(handles.diagrama)
axis off
    case 2
set (handles.msnlongitud,'string','Longitud de la viga [m].');
set (handles.msnamplitud,'string','Amplitud de la carga [N/m].');
set (handles.apoyofijo,'string','Distancia A-C [m].');
set (handles.apoyopatin,'string','Distancia B-D [m].'); 
axes(handles.diagrama)
handles.diagrama=imread('CASO2.JPG');
imagesc(handles.diagrama)
axis off
    case 3
set (handles.msnlongitud,'string','Longitud de la viga [m].');
set (handles.msnamplitud,'string','Amplitud de la carga [N/m].');
set (handles.apoyofijo,'string','Distancia B-D [m].');
set (handles.apoyopatin,'string','Distancia A-C [m].'); 
axes(handles.diagrama)
handles.diagrama=imread('CASO3.JPG');
imagesc(handles.diagrama)
axis off
end
function apoyos_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function guardar_Callback(hObject, eventdata, handles)
global   cmin  v longitud amplitud distanciaa distanciab Pmax cmax ancho eje fijo patin x y z C1 C2 C3 area M1 M2 M3 cte Mmax e
longitud   = str2double(get(handles.longitud,'String'));
amplitud   = str2double(get(handles.amplitud,'String'));
distanciaa = str2double(get(handles.distanciaa,'String'));
distanciab = str2double(get(handles.distanciab,'String'));

if (v == 1)
    set (handles.ax,'string','');
set (handles.ay,'string','');
set (handles.by,'string','');
set (handles.cmax,'string','');
set (handles.mmax,'string','');
set (handles.cmin,'string','');
set (handles.mmin,'string','');
grid on
axes(handles.cortante)
plot(0,0)
title ('Diagrama de Cortante')
xlabel ('Longitud (m)')
ylabel ('Fuerza cortante (N)')
grid off
grid
axes(handles.momento)
plot(0,0)
title ('Diagrama de Momento')
xlabel ('Longitud (m)')
ylabel ( 'Momento (N.m)')
else
if (v==2)
set (handles.msnlongitud,'string','Longitud de la viga [m].');
set (handles.msnamplitud,'string','Amplitud de la carga [N/m].');
set (handles.apoyofijo,'string','Distancia A-C [m].');
set (handles.apoyopatin,'string','Distancia B-D [m].'); 
set (handles.text9,'string','Ax');
axes(handles.diagrama)
handles.diagrama=imread('RESCASO2.JPG');
imagesc(handles.diagrama)
axis off

else
set (handles.text9,'string','Bx');
set (handles.msnlongitud,'string','Longitud de la viga [m].');
set (handles.msnamplitud,'string','Amplitud de la carga [N/m].');
set (handles.apoyofijo,'string','Distancia B-D [m].');
set (handles.apoyopatin,'string','Distancia A-C [m].'); 
grid
axes(handles.diagrama)
handles.diagrama=imread('RESCASO3.JPG');
imagesc(handles.diagrama)
axis off         
end
ancho = longitud-distanciaa-distanciab;
area = amplitud*ancho;
patin = (area*(distanciaa+(ancho/2))/longitud);
fijo = area-patin;
x = 0:0.0001:(distanciaa);
C1 = (x<=(distanciaa)).*(fijo)+(x==0).*(-fijo);
M1 = (x<=(distanciaa)).*(fijo*x);
y = distanciaa:0.0001:(distanciaa+ancho);
C2 =(y <= (distanciaa+ancho)).*(fijo+amplitud*distanciaa-(amplitud*y));
M2 =(y <= (distanciaa+ancho)).*(fijo*y +amplitud*distanciaa*y -amplitud*(y.^2)/2 -(amplitud*distanciaa.^2)/2);
cte= fijo*(distanciaa+ancho) +amplitud*distanciaa*(distanciaa+ancho) -amplitud*((distanciaa+ancho).^2)/2 -(amplitud*distanciaa.^2)/2;
z = (distanciaa+ancho):0.0001:longitud;
C3 = (z <= (longitud)).*(-patin)+(z==longitud).*(patin);
M3 = (z < (longitud)).*(-patin*z+patin*longitud);
e = 0:0.0001:longitud;
eje = (e<=longitud).*(0);
Pmax = distanciaa+ancho-(ancho/(1+(fijo/patin)));
if (fijo<=patin)
    cmin=fijo;
    cmax =patin;
else
    cmin=patin;
    cmax = fijo;
end
Mmax = fijo*Pmax +amplitud*distanciaa*Pmax -amplitud*(Pmax.^2)/2 -(amplitud*distanciaa.^2)/2;

grid on
axes(handles.cortante)
plot(x,C1,'Blue',y,C2,'Red',z,C3,'Green',e,eje,'Black');
title ('Diagrama de Cortante')
xlabel ('Longitud (m)')
ylabel ('Fuerza cortante (N)')
grid off
grid on
axes(handles.momento)
plot(x,M1,'Blue',y,M2,'Red',z,M3,'Green');
title ('Diagrama de Momento')
xlabel ('Longitud (m)')
ylabel ('Momento (N.m)')
grid off

set (handles.ax,'string','0');
set (handles.ay,'string',fijo);
set (handles.by,'string',patin);
set (handles.cmax,'string',cmax);
set (handles.cmin,'string',cmin);
set (handles.mmax,'string',Mmax);
set (handles.mmin,'string',min(M2));
end
function guardar_CreateFcn(hObject, eventdata, handles)





function amplitud_Callback(hObject, eventdata, handles)

function amplitud_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function distanciaa_Callback(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
function distanciaa_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function distanciab_Callback(hObject, eventdata, handles)

function distanciab_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function mmax_CreateFcn(hObject, eventdata, handles)

function ax_CreateFcn(hObject, eventdata, handles)

function ay_CreateFcn(hObject, eventdata, handles)

function cmax_CreateFcn(hObject, eventdata, handles)

function by_CreateFcn(hObject, eventdata, handles)


function pushbutton2_Callback(hObject, eventdata, handles)
set (handles.ax,'string','');
set (handles.ay,'string','');
set (handles.by,'string','');
set (handles.cmax,'string','');
set (handles.mmax,'string','');
set (handles.longitud,'string','');
set (handles.amplitud,'string','');
set (handles.distanciaa,'string','');
set (handles.distanciab,'string','');
set (handles.cmin,'string','');
set (handles.mmin,'string','');
grid on
axes(handles.cortante)
plot(0,0)
title ('Diagrama de Cortante')
xlabel ('Longitud (m)')
ylabel ('Fuerza cortante (N)')
grid off
grid
axes(handles.momento)
plot(0,0)
title ('Diagrama de Momento')
xlabel ('Longitud (m)')
ylabel ( 'Momento (N.m)')
axes(handles.diagrama)
handles.diagrama=imread('CASO1.JPG');
imagesc(handles.diagrama)
axis off

function pushbutton2_CreateFcn(hObject, eventdata, handles)


function msnlongitud_CreateFcn(hObject, eventdata, handles)

function msnamplitud_CreateFcn(hObject, eventdata, handles)

function apoyofijo_CreateFcn(hObject, eventdata, handles)

function apoyopatin_CreateFcn(hObject, eventdata, handles)

function text9_CreateFcn(hObject, eventdata, handles)



function cmin_CreateFcn(hObject, eventdata, handles)

function mmin_CreateFcn(hObject, eventdata, handles)
