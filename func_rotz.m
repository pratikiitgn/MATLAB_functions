function matrix = func_rotz(angle)
  
  matrix = [ cosd(angle) -sind(angle)  0;
             sind(angle)  cosd(angle)  0;
             0             0           1];
  
end
