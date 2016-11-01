function DrawSpehere(Nr_Points,r)
%%
[X,Y,Z]=sphere(Nr_Points);
s1=surf(r*X,r*Y,r*Z);
set(s1,'FaceColor',[0.9 0.9 0.9],'EdgeColor','green');
set(s1,'FaceColor',[0 1 1],'EdgeColor','red');
set(s1, 'FaceAlpha', 0.1)
shading interp
light
end