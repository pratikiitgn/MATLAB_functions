function matrix = func_rotx(angle)

  matrix = [1 0 0;
           0 cosd(angle) -sind(angle);
           0 sind(angle)  cosd(angle)];
  
end
