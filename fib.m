function [ fib ]= fib()

F=zeros(8);
for i = 1:8
    F(i,1) = i+(i-1)
end