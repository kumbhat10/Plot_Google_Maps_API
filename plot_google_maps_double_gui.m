mycenter = [28.497210, 77.062911];   % maruti gate no. 1

load(file)
%%
title = whos('Vhcl*'); %% FOR VEHICLE SPEED
title = title.name;
Vhclspd =evalin('caller',title); 
clear title
%%
title = whos('SOC*');   %% FOR SOC
title = title.name;
BATTERY_SOC =evalin('caller',title); 
clear title
%%
title = whos('*EgClntTmp*');
title = title.name;
Engine_Temperature = evalin('caller',title);

%%
title = whos('*BatTemp_BS*');
title = title.name;
Battery_Temperature = evalin('caller',title);
%%
if strmatch(variable1, 'Vehicle Speed')==1
title1 = whos('Vhcl*');
title1 = title1.name;
text1 = ' KMPH';  %%enter unit of parameter

elseif strmatch(variable1, 'Battery SOC')==1
 title1 = 'BATTERY_SOC' ;      
text1 = ' SOC';  
elseif strmatch(variable1, 'Engine Temperature')==1
 title1 = 'Engine_Temperature' ;      
text1 = ' oC';
elseif strmatch(variable1, 'Battery Temperature')==1
 title1 = 'Battery_Temperature' ;      
text1 = ' oC';
end
%%
if strmatch(variable2, 'Vehicle Speed')==1
title2 = whos('Vhcl*');
title2 = title2.name;
text2 = ' KMPH';  %%enter unit of parameter

elseif strmatch(variable2, 'Battery SOC')==1
 title2 = 'BATTERY_SOC' ;      
text2 = ' SOC';  
elseif strmatch(variable1, 'Engine Temperature')==1
 title2 = 'Engine_Temperature' ;      
text2 = ' oC';
elseif strmatch(variable1, 'Battery Temperature')==1
 title2 = 'Battery_Temperature' ;      
text2 = ' oC';

end


%%
  if map_view==1
        type = 'ROADMAP';
    elseif map_view ==2
%     type = 'SATELLITE';
    type = 'HYBRID';
    end

parameter =  evalin('caller',title1); 

a=min(parameter);
b=max(parameter);
c= (b-a)/4;
xx = [a  b];
yy = [0 255];

start_point =   mycenter;        %% by default start point or u can add your own cordinates
end_point = [28.4648780000000,77.0345310000000];


aa= 1   ; %enter odd number - no. of samples for moving average


disp(' Creating a scale map iamge.......')
disp('   ')

% run('scale_create.m')
Latitude = moving_average(Latitude,aa)   ;
Longitude = moving_average(Longitude,aa)   ;

% fname = 'plot2.html';
fname = [folder_name(1:length(folder_name)-4),'_single.html'];
delete(fname)
fid = fopen(fname,'a');
%%  change here for map type - roadmap or satellite
fprintf(fid, '<html><head><script src="http://maps.googleapis.com/maps/api/js"></script><script>var myCenter=new google.maps.LatLng(28.497210, 77.062911); ');

fprintf(fid,['function initialize() {  var mapProp = { center:myCenter, zoom:11, mapTypeId:google.maps.MapTypeId.',type  ,'  }; var map=new google.maps.Map(document.getElementById("googleMap1"), mapProp); ']);  %%defining center point and map properties and type

fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(28.497210, 77.062911),icon:',39,'a.jpg',39,', animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   %% marker insert - here inserted at center point
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"Maruti Suzuki Gate No.1"  });infowindow.open(map,marker); ');  %% info view 



%% lop for plotting various markers 
% for i = 1:n    
%     fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(y(i,1)) ,',',   num2str(y(i,2)) ,'), animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   
% end

 %% loop for defining various points of given data and connecting via polyline

xyz = length(Longitude)-1;
disp('   ')
parameter1 = round ( interp1(xx,yy,parameter,'linear')  )  ;

dfn = 0;
if colour_type==1
    for i = 1: xyz
  clc
  disp(' Please wait.......')
  disp('  ')
  disp(['Writing HTML code for total  ', num2str(xyz), '  Points ']) 
  disp('  ')
%    disp([num2str(round(i*100/xyz)),' % completed.........' ]) 
     df = round(i*50/xyz) ; 
   if df~=dfn
     set(handles.text11,'String',[num2str(df),' % completed '])  
      pause(0.01)
   dfn=df;
   end
  
fprintf(fid,['var myTrip=[new google.maps.LatLng(',num2str(Latitude(i),8) ,',',num2str(Longitude(i),8 ),')' ]);      
fprintf(fid,  [' , new google.maps.LatLng(',num2str(Latitude(i+1),8) ,',',num2str(Longitude(i+1),8 )  ,')']);    

  fprintf(fid,'];   ');
%   parameter1 = round ( interp1(xx,yy,parameter(i),'linear')  )  ;
fprintf(fid,['var flightPath=new google.maps.Polyline({ path:myTrip,   strokeColor:"#', dec2hex(255-parameter1(i),2) , dec2hex(parameter1(i),2),'00",   strokeOpacity:1,   strokeWeight:6   });  flightPath.setMap(map);']);
    end
  
elseif colour_type==2
 
  for i = 1: xyz
%   disp(['Writing HTML code for point no. ',num2str(i) ,'  of total  ', num2str(xyz) ])    
clc
  disp(' Please wait.......')
  disp('  ')
  disp(['Writing HTML code for total  ', num2str(xyz), '  Points ']) 
  disp('  ')
%    disp([num2str(round(i*100/xyz)),' % completed.........' ]) 
     df = round(i*50/xyz) ;  %     ,' % completed' ]
   if df~=dfn
     set(handles.text11,'String',[num2str(df),' % completed'])  
      pause(0.01)
   dfn=df;
   end

fprintf(fid,['var myTrip=[new google.maps.LatLng(',num2str(Latitude(i),8) ,',',num2str(Longitude(i),8 ),')' ]);      
fprintf(fid,  [' , new google.maps.LatLng(',num2str(Latitude(i+1),8) ,',',num2str(Longitude(i+1),8 )  ,')']);    

  fprintf(fid,'];   ');
%   parameter1 = round ( interp1(xx,yy,parameter(i),'linear')  )  ;
fprintf(fid,['var flightPath=new google.maps.Polyline({ path:myTrip,   strokeColor:"#', dec2hex(255-parameter1(i),2),'00' , dec2hex(parameter1(i),2),'",   strokeOpacity:1,   strokeWeight:6   });  flightPath.setMap(map);']);
  end
 
end
 
 
%%   inserting start and end points marker
disp(' Inserting Start point marker ')
disp(' ')

fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(Latitude(1),8) ,',',   num2str(Longitude(1),8 ) ,'), animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"Start Point"  });infowindow.open(map,marker); ');  %% info view 




disp(' Inserting End point marker ')
disp(' ')
fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(Latitude(length(Longitude)),8) ,',',   num2str(Longitude(length(Longitude)),8 ) ]);   
 fprintf(fid,'), animation:google.maps.Animation.DROP });  ');                                 
fprintf(fid,'marker.setMap(map);');
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"END Point"  });infowindow.open(map,marker); ');  %% info view
  %% Insert various markers on vehicle stop and open info on click 

clear ccc ddd eee 
bit_Vehiclestop_mod_spdthreshold = Vhclspd < 0.7;
ccc = diff(bit_Vehiclestop_mod_spdthreshold);
ddd = find(ccc==1);

if info_marker==1 && isempty(ddd)==0
run('vehicle_stop_evaluate.m')

for i = 1:stop_count      
% fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,')});marker',num2str(i),'.setMap(map);']);
if stop_time(i) <= range_speed(1)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_green.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) <= range_speed(2)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_blue.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) <= range_speed(3)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_pink.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) > range_speed(3)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_black.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

end

fprintf(fid,['google.maps.event.addListener(marker',num2str(i),',',39,'click',39,',function() {  ']);
fprintf(fid,' var infowindow = new google.maps.InfoWindow({');
fprintf(fid,[' content:"Stop Count : ',num2str(i),' of ',num2str(stop_count),' <br>Stop Time : ',num2str(stop_time(i)),' Sec<br>AutoStop Time - x Seconds <br>Battery SOC :- ',num2str(BATTERY_SOC_stop_time(i)),'" });infowindow.open(map,marker',num2str(i),');});']);

end
end
%% Place marker on click 

fprintf(fid,[' google.maps.event.addListener(map, ',39,'click',39,', function(event){placeMarker(map, event.latLng);});']);
fprintf(fid,'function placeMarker(map, location) {var marker = new google.maps.Marker({position: location,map: map});');
fprintf(fid,' var infowindow = new google.maps.InfoWindow({');
fprintf(fid,['content: ',39,'Latitude: ',39,' + location.lat() + ',39,'<br>Longitude: ',39,' + location.lng()});']);
fprintf(fid,'  infowindow.open(map,marker);}');
  
%% final initialize the map plotting

fprintf(fid,['}google.maps.event.addDomListener(window, ',39,'load',39,', initialize);']);

%%    second variable starts 

clear parameter parameter1
parameter =  evalin('caller',title2); 
% paramter1 = round(parameter*  (255/max(parameter))) ;
a2=min(parameter);
b2=max(parameter);
c2= (b2-a2)/4;
xx = [a2  b2];
yy = [0 255];

fprintf(fid,['function initialize1() {  var mapProp = { center:myCenter, zoom:11, mapTypeId:google.maps.MapTypeId.',type  ,'  }; var map=new google.maps.Map(document.getElementById("googleMap2"), mapProp); ']);  %%defining center point and map properties and type

fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(28.497210, 77.062911),icon:',39,'a.jpg',39,', animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   %% marker insert - here inserted at center point
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"Maruti Suzuki Gate No.1"  });infowindow.open(map,marker); ');  %% info view 

% fprintf(fid,['var marker2=new google.maps.Marker({ position:new google.maps.LatLng(28.497210, 77.062911),icon:',39,'a.jpg',39,', animation:google.maps.Animation.DROP }); marker.setMap(map2); ']);   %% marker insert - here inserted at center point
% fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"Maruti Suzuki Gate No.1"  });infowindow.open(map2,marker2); '); 
 


% lop for plotting various markers 
% for i = 1:n    
%     fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(y(i,1)) ,',',   num2str(y(i,2)) ,'), animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   
% end

 %% loop for defining various points of given data and connecting via polyline - 2nd variable

xyz = length(Longitude)-1;
disp('   ')
 parameter1 = round ( interp1(xx,yy,parameter,'linear')  )  ;
 
 
if colour_type==1
    for i = 1: xyz
  clc
  disp(' Please wait.......')
  disp('  ')
  disp(['Writing HTML code for total  ', num2str(xyz), '  Points ']) 
  disp('  ')
 %    disp([num2str(round(i*100/xyz)),' % completed.........' ]) 
     df = round(i*50/xyz) ;  %     ,' % completed' ]
   if df~=dfn
     set(handles.text11,'String',[num2str(df+50),' % completed'])  
      pause(0.01)
   dfn=df;
   end 
  
fprintf(fid,['var myTrip=[new google.maps.LatLng(',num2str(Latitude(i),8) ,',',num2str(Longitude(i),8 ),')' ]);      
fprintf(fid,  [' , new google.maps.LatLng(',num2str(Latitude(i+1),8) ,',',num2str(Longitude(i+1),8 )  ,')']);    

  fprintf(fid,'];   ');
%   parameter1 = round ( interp1(xx,yy,parameter(i),'linear')  )  ;
fprintf(fid,['var flightPath=new google.maps.Polyline({ path:myTrip,   strokeColor:"#', dec2hex(255-parameter1(i),2) , dec2hex(parameter1(i),2),'00",   strokeOpacity:1,   strokeWeight:6   });  flightPath.setMap(map);']);
    end
  
elseif colour_type==2
 
  for i = 1: xyz
%   disp(['Writing HTML code for point no. ',num2str(i) ,'  of total  ', num2str(xyz) ])    
clc
  disp(' Please wait.......')
  disp('  ')
  disp(['Writing HTML code for total  ', num2str(xyz), '  Points ']) 
  disp('  ')
   %    disp([num2str(round(i*100/xyz)),' % completed.........' ]) 
     df = round(i*50/xyz) ;  %     ,' % completed' ]
   if df~=dfn
     set(handles.text11,'String',[num2str(df+50),' % completed'])  
      pause(0.01)
   dfn=df;
   end

fprintf(fid,['var myTrip=[new google.maps.LatLng(',num2str(Latitude(i),8) ,',',num2str(Longitude(i),8 ),')' ]);      
fprintf(fid,  [' , new google.maps.LatLng(',num2str(Latitude(i+1),8) ,',',num2str(Longitude(i+1),8 )  ,')']);    

  fprintf(fid,'];   ');
%   parameter1 = round ( interp1(xx,yy,parameter(i),'linear')  )  ;
fprintf(fid,['var flightPath=new google.maps.Polyline({ path:myTrip,   strokeColor:"#', dec2hex(255-parameter1(i),2),'00' , dec2hex(parameter1(i),2),'",   strokeOpacity:1,   strokeWeight:6   });  flightPath.setMap(map);']);
  end
 
end
%%   inserting start and end points marker
disp(' Inserting Start point marker ')
disp(' ')

fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(Latitude(1),8) ,',',   num2str(Longitude(1),8 ) ,'), animation:google.maps.Animation.DROP }); marker.setMap(map); ']);   
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"Start Point"  });infowindow.open(map,marker); ');  %% info view 

disp(' Inserting End point marker ')
disp(' ')
fprintf(fid,['var marker=new google.maps.Marker({ position:new google.maps.LatLng(',num2str(Latitude(length(Longitude)),8) ,',',   num2str(Longitude(length(Longitude)),8 ) ]);   
 fprintf(fid,'), animation:google.maps.Animation.DROP });  ');                                 
fprintf(fid,'marker.setMap(map);');
fprintf(fid,'var infowindow = new google.maps.InfoWindow({  content:"END Point"  });infowindow.open(map,marker); ');  %% info view

  %% Insert various markers on vehicle stop and open info on click 
clear ccc ddd eee 
bit_Vehiclestop_mod_spdthreshold = Vhclspd < 0.7;
ccc = diff(bit_Vehiclestop_mod_spdthreshold);
ddd = find(ccc==1);

if info_marker==1 && isempty(ddd)==0
run('vehicle_stop_evaluate.m')

for i = 1:stop_count      
% fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,')});marker',num2str(i),'.setMap(map);']);
if stop_time(i) <= range_speed(1)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_green.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) <= range_speed(2)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_blue.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) <= range_speed(3)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_pink.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

elseif stop_time(i) > range_speed(3)
    fprintf(fid,['var marker',num2str(i),' = new google.maps.Marker({position:new google.maps.LatLng(',num2str(latitude_stop_time(i),8) ,',',   num2str(longitude_stop_time(i),8 ) ,') ,icon:',39,'pin_black.png',39,' , animation:google.maps.Animation.DROP });marker',num2str(i),'.setMap(map);']);

end

fprintf(fid,['google.maps.event.addListener(marker',num2str(i),',',39,'click',39,',function() {  ']);
fprintf(fid,' var infowindow = new google.maps.InfoWindow({');
fprintf(fid,[' content:"Stop Count : ',num2str(i),' of ',num2str(stop_count),' <br>Stop Time : ',num2str(stop_time(i)),' Sec<br>AutoStop Time - x Seconds <br>Battery SOC :- ',num2str(BATTERY_SOC_stop_time(i)),'" });infowindow.open(map,marker',num2str(i),');});']);

end
end

 %% Place marker on click 

fprintf(fid,[' google.maps.event.addListener(map, ',39,'click',39,', function(event){placeMarker(map, event.latLng);});']);
fprintf(fid,'function placeMarker(map, location) {var marker = new google.maps.Marker({position: location,map: map});');
fprintf(fid,' var infowindow = new google.maps.InfoWindow({');
fprintf(fid,['content: ',39,'Latitude: ',39,' + location.lat() + ',39,'<br>Longitude: ',39,' + location.lng()});']);
fprintf(fid,'  infowindow.open(map,marker);}');

%% final initialize the map plotting
fprintf(fid,['}google.maps.event.addDomListener(window, ',39,'load',39,', initialize1);']);

%%
fprintf(fid,'</script></head>');  %% body content and map size and title heading
fprintf(fid,['<title> plot of ',title1 ,' and ',title2,' </title><body>']);
fprintf(fid,'<h1><center> Welcome to EN-2X Calibration & Testing </center></h1>');
% fprintf(fid,'<div id="googleMap1" style="width:1800px;height:800px;">  </div>');
fprintf(fid,'<div id="googleMap1"  style="width:900px; height:750px; float:left; margin:10px"> </div>   ');
fprintf(fid,' <div id="googleMap2" style="width:900px;height:750px;">  </div>');
disp(' ')
disp('Inserting scale ........')
% fprintf(fid,['<h3> Scale  </h3>']);
% fprintf(fid,['<p><h4>0 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;',num2str(max_para),' kmph </h5>']);



fprintf(fid,['<p><h4>&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',title1,'&emsp;',num2str(round(a)),' &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(a+c)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(a+ 2*c)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(b-c)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(b)),' ', text1,'&emsp;']);
fprintf(fid,['&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(a2)),' &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(a2+c2)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(a2+ 2*c2)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(b2-c2)),'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;',num2str(round(b2)),' ', text2,'&emsp;',title2,'</h5>']);

%% for color scale
if colour_type==1
fprintf(fid,'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<img src="scale_red_green.jpg" style="width:450px;height:15px;"> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <img src="scale_red_green.jpg" style="width:450px;height:15px;">  </p>    </body></html>');
elseif colour_type==2
fprintf(fid,'&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;<img src="scale_red_blue.jpg" style="width:450px;height:15px;"> &emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp; <img src="scale_red_blue.jpg" style="width:450px;height:15px;">  </p>    </body></html>');
end

%%
fprintf(fid,'');
fprintf(fid,'');
fclose('all');
set(handles.text12,'String','Finished Successfully... :)')  
a= imread('wait_over.jpg');
image(a,'Parent', handles.axes7)
set(handles.axes7,'visible','off')
pause(2)
system(fname)
