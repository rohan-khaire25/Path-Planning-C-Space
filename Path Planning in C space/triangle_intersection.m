function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

%%% All of your code should be between the two lines of stars.
% *******************************************************************

xi1 = [P1(1,1) P1(2,1) P1(3,1)];
yi1 = [P1(1,2) P1(2,2) P1(3,2)];
xi2 = [P2(1,1) P2(2,1) P2(3,1)];
yi2 = [P2(1,2) P2(2,2) P2(3,2)];

[x_int, y_int] = polyxpoly(xi1,yi1,xi2,yi2);
if isempty([x_int, y_int])
    flag = false;
else
    flag = true;
    
% *******************************************************************
end