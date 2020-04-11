function f = cspa(d,ep,q,m,k)           %function to generate the candidate star pair array from the measured value of the angular distance
s = sqrt(1-(d*d));
k_b = floor(((d*cos(ep))-(s*sin(ep))-q)/m);
k_t = ceil(((d*cos(ep))+(s*sin(ep))-q)/m);
%disp(k(k_b));disp(k(k_t));

f=zeros(432116,1);
if(k(k_b)~=k(k_t))
   for j= k(k_b)+1:k(k_t)              % gives me the range of possible star pair indices
    f(j)=j;
   end
else
    f(k(k_t)) = k(k_t);
end
disp(f(187090:187094,:));


end