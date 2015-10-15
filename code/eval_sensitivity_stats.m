function sensitivity = eval_sensitivity_stats(Auto_seg_img, Corrected_seg_img)
% sensitivity = eval_sensitivity(Auto_seg_img, Corrected_seg_img)
% Exemple: sensitivity = eval_sensitivity(axonseg, axonseg_corrected)
cc_auto = bwconncomp(Auto_seg_img, 4);
cc_corrected = bwconncomp(Corrected_seg_img, 4);

props_auto_seg_img = regionprops(cc_auto,{'Centroid', 'Area'});
props_corr_seg_img = regionprops(cc_corrected,{'Centroid', 'Area'});

centroids_auto_seg_img = cat(1,props_auto_seg_img.Centroid);
centroids_corr_seg_img = cat(1,props_corr_seg_img.Centroid);

areas_auto_seg_img = cat(1,props_auto_seg_img.Area);
areas_corr_seg_img = cat(1,props_corr_seg_img.Area);

% Axon counters for statistical calculations

nbr_of_axons_still_there = 0;
nbr_of_axons_removed = 0;
nbr_of_axons_added = 0;





a = [1 2 3 ; 4 5 6; 7 8 9];
b=[5 5 5]  
c=[a;b]% add one row

% Still_there_or_not = zeros(size(centroids_auto_seg_img,1),1);
% Still_there_or_not = logical(Still_there_or_not);

for cnt=1:size(centroids_auto_seg_img,1)
    test_point_x = round(centroids_auto_seg_img(cnt,2));
    test_point_y = round(centroids_auto_seg_img(cnt,1));
    
    if (Corrected_seg_img(test_point_x,test_point_y)==true)
        nbr_of_axons_still_there=nbr_of_axons_still_there+1;
        
        if nbr_of_axons_still_there==1
            Stats__changes_matrix = zeros(1,6);
            Stats_changes_matrix(
        end
        
        
        
        
        
    else
        nbr_of_axons_removed=nbr_of_axons_removed+1;
    end  
end



for cnt=1:size(centroids_corr_seg_img,1)
    test_point_x = round(centroids_corr_seg_img(cnt,2));
    test_point_y = round(centroids_corr_seg_img(cnt,1));
    
    if (Auto_seg_img(test_point_x,test_point_y)==false)
    nbr_of_axons_added = nbr_of_axons_added+1;
    end  
end


% Stats for modified axons (diameter, area)





FN = nbr_of_axons_added;
% FP = nbr_of_axons_removed;

% nbr_of_axons_still_there = TP-removed_axons
% TP = nbr_axons_in_auto_seg - added_axons - removed_axons
TP = nbr_of_axons_still_there-nbr_of_axons_added;

sensitivity = TP/(TP+FN);

figure, imshow(Auto_seg_img);
figure, imshow(Corrected_seg_img);

end