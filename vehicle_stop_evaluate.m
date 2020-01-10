rate = 500;   %% enter in ms of data 
% Vhclspd = 10;
clear ccc ddd eee 
bit_Vehiclestop_mod_spdthreshold = Vhclspd < 0.7;
ccc = diff(bit_Vehiclestop_mod_spdthreshold);
ddd = find(ccc==1);
eee = find(ccc==-1);

stop_time_cal = 10;   %enter in seconds

if ddd(1) > eee(1)
eee = eee(2:length(eee));
end

max_l = min([length(ddd) length(eee)]);

eee = eee(1:max_l);
ddd = ddd(1:max_l);

stop_time = (eee-ddd )*rate/1000;

index_stop_time = ddd(stop_time >=stop_time_cal) + 1 ;
latitude_stop_time = Latitude(index_stop_time);
longitude_stop_time = Longitude(index_stop_time);
stop_time = round(stop_time(stop_time>=stop_time_cal));
stop_count = length(index_stop_time);

BATTERY_SOC_stop_time = BATTERY_SOC(index_stop_time);