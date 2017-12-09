


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
[x,y2] = sinwave(3000,44100,0.1);
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

