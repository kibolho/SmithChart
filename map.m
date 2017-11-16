function [ y ] = map( x,xmin,xmax,ymin,ymax )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
y = (ymax-ymin)*(x-xmin)/(xmax-xmin) + ymin;
end

