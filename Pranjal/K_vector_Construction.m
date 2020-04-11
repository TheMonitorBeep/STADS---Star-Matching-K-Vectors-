a=[9.6;15.2;3.5;18;7.7;14.7;2.5;10.77];
a=sort(a);
prompt = 'Enter the error epsilon';
u = input(prompt);
m=(max(a)-min(a)+2*u)/7;
z=zeros(8,1);
k=zeros(8,1);
for i=1:8
    z(i) = m*i + q;
    k(i)=i-1;
    if z(i)>a(i)
        k(i)=k(i)+1;
    end
end
disp(a);
disp(z);
disp(k);


    
    