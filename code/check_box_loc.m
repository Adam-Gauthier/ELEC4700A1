function box_result = check_box_loc(position, box)
    box_result = 0;
    for i=1:size(box,1)   
        if(position(1) > box(i,1) && position(1) < box(i,2) && position(2) > box(i,3) && position(2) < box(i,4))
            box_result = i;
            return;
        end
    end
end