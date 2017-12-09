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
    
score(i)=(score(i)-70)*100+50;
end
s1=serial('COM10');
s2=serial('COM7');
fopen(s2);
fopen(s1);
pause(5);
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
fprintf(s1,'%d',score(12));
fprintf(s1,'%s','\n');

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

%???????
fclose(s1);
fclose(s2);






