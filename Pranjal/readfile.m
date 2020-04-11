gc = readmatrix('Guide_Catalogue.csv');
rc = readmatrix('Reference_Catalogue.csv');
a = rc(:,4);
u=0.00001;
m=(max(a)-min(a)+2*u)/9;
q=min(a)-u-m;
z=zeros(10,1);
k=zeros(10,1);
for i=1:10
    z(i) = m*i + q;
    k(i)=i-1;
    if z(i)>a(i)
        k(i)=k(i)+1;
    end
end
rc = [rc k];
disp(rc);

cspm = zeros(10,6);
d = [0.91;0.92;0.98;0.94;0.99;0.97];
d_e = randn(6,1) * 0.01;
d = d + d_e;
for h=1:6
cspm(:,h)=cspa(d(h),u,q,m,k);
end

disp(cspm);

sim = zeros(5,6);
for i=1:6
    for j=1:10
        if(cspm(j,i)~=0)
            for k=1:5
                if(gc(k,2)==rc(cspm(j,i),2)||gc(k,2)==rc(cspm(j,i),3))
                    if(sim(gc(k,1),i)==0)
                       sim(gc(k,1),i) = sim(gc(k,1),i) + 1;
                    end
                end
            end
        end
    end
end
disp(sim);


function f = cspa(d,u,q,m,k)
s = sqrt(1-(d*d));
k_b = floor(((d*cos(u))-(s*sin(u))-q)/m);
k_t = ceil(((d*cos(u))+(s*sin(u))-q)/m);

f=zeros(10,1);
if(k(k_b)~=k(k_t))
   for j= k(k_b)+1:k(k_t)
    f(j)=j;
   end
else
    f(k(k_t)) = k(k_t);
end



end
