function [Neigbours,pos]=Vangjush_ExtractionNeigbours(PositionOfMainVoxel,DimensionConsideration,MRS_grid_signal,maner)
%%
% Ordering of the signals is not important in this case
NrOfVoxels=32;                                                        % Number of voxels
pos=(DimensionConsideration^2+1)/2;                                   % Position calculation of the voxel of interest
Border=round(DimensionConsideration/2)-1;                             % Computaiton of the border voxel in the neighbour consideration
%%
if maner==1% Extract the all neighbours
    Neigbours=zeros(DimensionConsideration^2,length(MRS_grid_signal));    % Initialization of the neighbours
    index=1;
    for l=-Border:Border
        for m=-Border:Border
            Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+NrOfVoxels*(l)+m,:);
            index=index+1;
        end
    end
end
%%
if maner==2 % Extract the all + neighbours
    Neigbours=zeros(Border*4+1,length(MRS_grid_signal));    % Initialization of the neighbours
    index=1;
    Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel,:);
    index=index+1;
    for l=1:Border
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+NrOfVoxels*(l),:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+NrOfVoxels*(-l),:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+(l),:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel-(l),:);
        index=index+1;
    end
    pos=1;
end
%%
if maner==3 % Extract the all X neighbours
    Neigbours=zeros(Border*4+1,length(MRS_grid_signal));    % Initialization of the neighbours
    index=1;
    Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel,:);
    index=index+1;
    for l=1:Border
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+NrOfVoxels*(l)+l,:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel+NrOfVoxels*(-l)-l,:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel-NrOfVoxels*(l)+l,:);
        index=index+1;
        Neigbours(index,:)=MRS_grid_signal(PositionOfMainVoxel-NrOfVoxels*(-l)-l,:);
        index=index+1;
    end
    pos=1;
end
end