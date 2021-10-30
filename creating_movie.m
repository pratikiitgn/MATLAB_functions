
%% Write down this below line in the for loop from where the animation is creating
movieVector(iii) = getframe;


% Write following code after for loop

myWriter = VideoWriter('Autonomous_trajectory');
myWriter.FrameRate = 100;

% Open the video writer  
open(myWriter);
writeVideo(myWriter,movieVector);
close(myWriter);
