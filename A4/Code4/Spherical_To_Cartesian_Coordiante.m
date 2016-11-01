function Cartesian_Coordinates=Spherical_To_Cartesian_Coordiante(Sphere_Coord)
Azimuth=Sphere_Coord(1,:);
Elevation=Sphere_Coord(2,:);
Radius=Sphere_Coord(3,:);
%%
x=Radius.*cos(Elevation).*sin(Azimuth);
y=Radius.*sin(Elevation).*sin(Azimuth);
z=Radius.*cos(Azimuth);
%%
Cartesian_Coordinates(1,:)=x;
Cartesian_Coordinates(2,:)=y;
Cartesian_Coordinates(3,:)=z;
end

