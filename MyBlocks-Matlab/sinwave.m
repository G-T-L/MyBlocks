function [ x,y ] = sinwave(f,fs,t )
%SINWAVE Summary of this function goes here
%   Detailed explanation goes here

%f:???????fs:????;t:???????
if(f*2<fs)
    dT = 1/fs;%????????
    x = 0:dT:t;%?????dT??????t???x
    y = sin(2*pi*f*x);%????????y??
else
    disp('fs must be bigger tan 2*f');
    x=0;y=0;
end
end
