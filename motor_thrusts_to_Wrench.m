clc
clear
close all

b = 1; 

syms b a m1 m2 m3 F

M = [ 1 1 1 1 ; 
      -b b b -b ;
      -b b -b b ;
      a a -a -a
     ];
 
 FF = [ F ; m1; m2; m3 ];
 
 F_i =  inv(M)*FF
 
