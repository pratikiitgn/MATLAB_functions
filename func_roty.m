function matrix = func_roty(angle)
  
  matrix = [ cosd(angle)  0 sind(angle);
             0           1     0 ;
             -sind(angle) 0 cosd(angle) ];  
  end
