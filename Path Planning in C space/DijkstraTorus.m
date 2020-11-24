function route = DijkstraTorus (input_map, start_coords, dest_coords)
% Run Dijkstra's algorithm on a grid.
% Inputs : 
%   input_map : a logical array where the freespace cells are false or 0 and
%      the obstacles are true or 1
%   start_coords and dest_coords : Coordinates of the start and end cell
%       respectively, the first entry is the row and the second the column.
% Output :
%   route : An array containing the linear indices of the cells along the
%    shortest route from start to dest or an empty array if there is no
%    route.

% set up color map for display
% 1 - white - clear cell
% 2 - black - obstacle
% 3 - red = visited
% 4 - blue  - on list
% 5 - green - start
% 6 - yellow - destination

function [n, s, e, w] = neighbors(current_node)
        [i, j] = ind2sub(size(distances), current);
        if i == 1 && j == 1
            s = current_node + 1;
            w = current_node + nrows;
            n = current_node + (nrows - 1);
            e = current_node + (ncols-1) * nrows;
        elseif i == nrows && j == 1
            n = current_node - 1;
            w = current_node + nrows;
            s = current_node - (nrows - 1);
            e = current_node + (ncols-1) * nrows;
        elseif i == nrows && j == ncols
            e = current_node - nrows;
            n = current_node - 1;
            s = current_node - (nrows - 1);
            w = current_node - (ncols-1) * nrows;
        elseif i == 1 && j == ncols
            e = current_node - nrows;
            s = current_node + 1;
            n = current_node + (nrows - 1);
            w = current_node - (ncols-1) * nrows;
        elseif i == 1 && j > 1
            s = current_node + 1;
            e = current_node - nrows;
            w = current_node + nrows;
            n = current_node + (nrows - 1);
        elseif i == nrows && j > 1
            n = current_node - 1;
            e = current_node - nrows;
            w = current_node + nrows;
            s = current_node - (nrows - 1);
        elseif i > 1 && j == 1
            n = current_node - 1;
            s = current_node + 1;
            w = current_node + nrows;
            e = current_node + (ncols-1) * nrows;
        elseif i > 1 && j == ncols
            n = current_node - 1;
            s = current_node + 1;
            e = current_node - nrows;
            w = current_node - (ncols-1) * nrows;
        else
            n = current_node - 1;
            s = current_node + 1;
            e = current_node - nrows;
            w = current_node + nrows;
            
        end
        
end

function manhattan_distance(node)
    dist = abs(start_coords(1)-i) + abs(start_coords(2)-j);
    distances(node) = dist;
end

cmap = [1 1 1; ...
        0 0 0; ...
        1 0 0; ...
        0 0 1; ...
        0 1 0; ...
        1 1 0];

colormap(cmap);


[nrows, ncols] = size(input_map);

% map - a table that keeps track of the state of each grid cell
map = zeros(nrows,ncols);

map(~input_map) = 1;  % Mark free cells
map(input_map)  = 2;  % Mark obstacle cells

% Generate linear indices of start and dest nodes
start_node = sub2ind(size(map), start_coords(1), start_coords(2));
dest_node  = sub2ind(size(map), dest_coords(1),  dest_coords(2));

map(start_node) = 5;
map(dest_node)  = 6;

% Initialize distance array
distances = Inf(nrows,ncols);

% For each grid cell this array holds the index of its parent
parent = zeros(nrows,ncols);

distances(start_node) = 0;

% Main Loop
while true
    
    % Draw current map
    map(start_node) = 5;
    map(dest_node) = 6;
    
    image(1.5, 1.5, map);
    grid on;
    axis image;
    drawnow;
    
    % Find the node with the minimum distance
    [min_dist, current] = min(distances(:));
    
    if ((current == dest_node) || isinf(min_dist))
        break;
    end;
    
    % Update map
    map(current) = 3;         % mark current node as visited
    distances(current) = Inf; % remove this node from further consideration
    
    % Compute row, column coordinates of current node
    [i, j] = ind2sub(size(distances), current);
    
    % Visit each neighbor of the current node and update the map, distances
    % and parent tables appropriately.
   
    %%% All of your code should be between the two lines of stars. 
    % *******************************************************************
    [n,s,e,w] = neighbors(current);
    
    unexplored = [n,s,w,e];
    for index = 1:length(unexplored)
        count = 0;
        if map(unexplored(index)) == 1 || map(unexplored(index)) == 6 
            manhattan_distance(unexplored(index))
            map(unexplored(index)) = 4;  
        end
        if unexplored(index) ~= start_node && parent(unexplored(index)) == 0 && map(unexplored(index)) ~= 2
            parent(unexplored(index)) = current;
        end
        route1 = [];
        route1 = [unexplored(index)];
        while (parent(route1(1)) ~= 0)
            route1 = [parent(route1(1)), route1];
            count = count + 1;
        end
        if map(unexplored(index)) == 4
            distances(unexplored(index)) = count;
        end
    end
    
        
        
    
    

    
    % *******************************************************************
end

if (isinf(distances(dest_node)))
    route = [];
else
    route = [dest_node];
    
    while (parent(route(1)) ~= 0)
        route = [parent(route(1)), route];
    end
end

    function update (i,j,d,p)
        if ( (map(i,j) ~= 2) && (map(i,j) ~= 3) && (map(i,j) ~= 5) && (distances(i,j) > d) )
            distances(i,j) = d;
            map(i,j) = 4;
            parent(i,j) = p;
        end
    end

end
