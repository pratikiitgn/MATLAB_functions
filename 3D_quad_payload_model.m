%% For making 3D object of quadcopter
myaxes = axes( 'xlim', [-10 10] ,'ylim', [-10 10], 'zlim', [-10 10] );
view(3);
title("Quadcopter with Suspended payload")
grid on;
axis equal;
hold on;
xlabel('x')
ylabel('y')
zlabel('z')
%for quadcopter
[ xarm, yarm, zarm ] = cylinder([ 0.01 0.01 ]);
[ bodyx ,bodyy, bodyz ] = sphere();
[ propx ,propy ,propz ] = sphere();
[ cablex ,cabley ,cablez ] = cylinder([ 0.01 0.01 ]);
[ massx ,massy ,massz ]    = sphere();
zarm(2,:) = 0.3;
quadcopter(1) = surface(zarm,xarm,yarm, 'FaceColor','r','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(2) = surface(-zarm,xarm,yarm,'FaceColor','r','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(3) = surface(xarm,zarm,yarm,'FaceColor','r','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(4) = surface(xarm,-zarm,yarm,'FaceColor','r','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(5) = surface(0.1*bodyx,0.1*bodyy,0.07*bodyz,'FaceColor','m','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(6) = surf(0.03*propx+0.3,0.03*propy,0.05*propz,'FaceColor','c','FaceAlpha',1, 'EdgeColor','none' );
quadcopter(7) = surf(0.03*propx-0.3,0.03*propy,0.05*propz,'FaceColor','c','FaceAlpha',1, 'EdgeColor','none');
quadcopter(8) = surf(0.03*propx,0.03*propy+0.3,0.05*propz,'FaceColor','c','FaceAlpha',1, 'EdgeColor','none');
quadcopter(9) = surf(0.03*propx,0.03*propy-0.3,0.05*propz,'FaceColor','c','FaceAlpha',1, 'EdgeColor','none');

payload(1)    = surf(cablex,cabley,-0.7*cablez,'FaceColor','b','FaceAlpha',1, 'EdgeColor','none' );
payload(2)    = surf(.05*massx,.05*massy,-0.7+0.05*massz,'FaceColor','b','FaceAlpha',1, 'EdgeColor','none');

Quadcopter_assembly = hgtransform('parent',myaxes);
set(quadcopter,'parent',Quadcopter_assembly);

payload_assembly = hgtransform('parent',myaxes);
set(payload,'parent',payload_assembly);

light              
lighting gouraud
material dull

% %% for animation
figure(1)

for i = 1:5:length(t)
    R = [X(i,13) X(i,16) X(i,19);
        X(i,14) X(i,17) X(i,20);
        X(i,15) X(i,18) X(i,21)];
    eulerAngle = rotm2eul(R,'XYZ');
    xL = [ X(i,1) ; X(i,2) ;X(i,3) ];
    q  = [ X(i,7) ; X(i,8) ;X(i,9) ];
    xQ = xL - L * q;
    theta_p = - asin(q(1,1));
    phi_p   = asin( q(2,1) / cos(theta_p) );
    
    translation_q = makehgtform('translate' , xQ);
    rotx_q        = makehgtform('xrotate',eulerAngle(1,1));
    roty_q        = makehgtform('yrotate',eulerAngle(1,2));
    rotz_q        = makehgtform('zrotate',eulerAngle(1,3));
    
    translation_p = makehgtform('translate' , xQ);
    rotx_p        = makehgtform('xrotate',phi_p);
    roty_p        = makehgtform('yrotate',theta_p);
    rotz_p        = makehgtform('zrotate',0);
    
    set(Quadcopter_assembly, 'matrix', translation_q*rotx_q*roty_q*rotz_q);
    set(payload_assembly,    'matrix', translation_p*rotx_p*roty_p*rotz_p)
    
    plot3([ 0 .1], [ 0 0],[ 0 0],'r',[ 0 0], [ 0 .1],[ 0 0],'g',[ 0 0], [ 0 0],[ 0 .1],'b');
    xlim([ -3 3 ])
    ylim([ -3 3 ])
    zlim([ -1 3 ])
%     axis auto
    xlabel('X-axis')
    ylabel('Y-axis')
    zlabel('Z-axis')
    title('Quadcopter with Suspended payload')
    drawnow
%     t(i)
end
