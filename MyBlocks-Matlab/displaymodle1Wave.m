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
