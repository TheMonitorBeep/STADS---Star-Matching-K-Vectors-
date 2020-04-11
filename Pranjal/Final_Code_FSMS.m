gc = readmatrix('Star_Catalogue_Mag_6.csv'); %reads the Guide Catalogue
rc = readmatrix('PreProcessedFinal3.csv'); %reads the Reference Catalgue( which contains the star pairs)
%digitsOld = digits(16);
a = rc(:,4);
%disp(vpa(a(1)));
u=2.22*1.0e-16; % the precision of the machine 
n_o = 432116;
ep = 0;

m=(max(a)-min(a)+2*u)/(n_o-1);
q=min(a)-u-m;
z=zeros(n_o,1);
k=zeros(n_o,1);
for i=1:n_o            % code for the K-Vector Construction starts 
    z(i) = m*i + q;
    k(i)=i-1;
    if z(i)>a(i)
        k(i)=k(i)+1;
    end
end
rc = [rc k];          % K-Vector column gets appended to the reference catalogue 
%disp(rc(432110:432116,5));

cspm = zeros(n_o,6);   %cspm - candidate star pair matrix
d = [0.965803907409329;0.9540802964620805;0.9706669214506275;0.9987459203374907;0.9973882735253906;0.9930322136889949]; % set of input angular distances ( in terms of cos(theta) )
%d_e = randn(6,1) * 1.0e-18; % the random errors in the value of the measured angular distances 
%d = d + d_e;
for h=1:6
cspm(:,h)=cspa(d(h),ep,q,m,k);  %cspa - candidate star pair array 
end

%disp(cspm(187090:187100,:));

sim = zeros(5068,6);   % sim - star identification matrix
for i=1:6
    for j=1:n_o
        if(cspm(j,i)~=0)
            for k=1:5068
                if(gc(k,2)==rc(cspm(j,i),2)||gc(k,2)==rc(cspm(j,i),3))
                    if(sim(gc(k,1),i)==0)
                       sim(gc(k,1),i) = sim(gc(k,1),i) + 1;
                    end
                end
            end
        end
    end
end
disp(sim(1:5,:));
w = [1,1,1,0,0,0];
for i=1:5068
    www = 0;
    for ww = 1:6
        if sim(i,ww)== w(1,ww)
         www = www + 1;
        end 
    end
    if www == 6
        disp('the Star ID for the angular measurement');
         disp(d(1));
         disp('is');disp(gc(i,2));
    end
    
end


