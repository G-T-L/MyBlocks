
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






