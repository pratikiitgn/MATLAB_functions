function matrix = func_rotz(angle)
  
  matrix = [ 1  0  0 ;
             0  cosd(angle) -sind(angle);
             0  sind(angle)  cosd(angle)];
  
  end
