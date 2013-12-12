function [ blurred ] = gaussblur( I, N )
sigma = N/6;
for n = 1:N
    for m = 1:N
        h(n,m) = 2*exp(-(n^(2)+m^(2))/(2*sigma^(2)));
    end
end
%h(floor((N/2)+1),floor((N/2)+1)) = N/2;
h = h*(1/(sum(h(:))));
blurred = filter2(h,I);