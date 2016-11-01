function [Box_Counter,Box_Size,FractialDimension] = Vangjush_Box_Counting(Time_Series)
%%
%% Convert the numbers into logical values 1 for non-zeros and 0 for zero values
Logical_Time_Series = logical(squeeze(Time_Series));

%% Reshape the time seriese horizontaly
Logical_Time_Series=reshape(Logical_Time_Series,length(Logical_Time_Series),1);
[width,~]=size(Logical_Time_Series);

%% The scale Window_Sizee of the window is a factor of 2 there fore we could compute the maximum number of generations
Number_Generations = log(width)/log(2);   % nbre of generations
%% Remap the array into size of power of two in order to speed up the processing
Number_Generations = ceil(Number_Generations);
width = 2^Number_Generations;
mz = zeros(1,width);
mz(1:length(Logical_Time_Series)) = Logical_Time_Series;
Logical_Time_Series = mz;
%% Pre allocate the number of boxes of each Window_Sizee taken into account
Box_Counter=zeros(1,Number_Generations+1); % pre-allocate the number of box of Window_Sizee r

%% Computing the box counter for the box size of one
Box_Counter(Number_Generations+1) = sum(Logical_Time_Series);

%% Computing the box counter over the other windows size
for j=(Number_Generations-1):-1:0
    % Window size starts from 2 and scales up by a factor of 2
    Window_Size = 2^(Number_Generations-j);
    % Half window is needed to comput the
    Half_Window_Window_Sizee = round(Window_Size/2);
    for i=1:Window_Size:(width-Window_Size+1)
        Logical_Time_Series(i) = ( Logical_Time_Series(i) || Logical_Time_Series(i+Half_Window_Window_Sizee));
    end
    Box_Counter(j+1) = sum(Logical_Time_Series(1:Window_Size:(width-Window_Size+1)));
end
Box_Counter = Box_Counter(end:-1:1);
Box_Size = 2.^(0:Number_Generations);
Box_Size = Box_Size(end:-1:1);
[FractialDimension]=Vangjush_Compute_Fractial_Dimension(Box_Counter,Box_Size,Number_Generations);
end
