function proj3main(frames, maxframenum, threshold, alpha, gamma)

    
    % Process frames with different background subtraction methods
    smpl_bg_out = smpl_bg(frames, threshold);
    smpl_fd_out = smpl_fd(frames, threshold);
    adaptive_bg_out = adaptive_bg(frames, threshold, alpha);
    persistent_fd_out = persistent_fd(frames, threshold, gamma);

    % List output files for each method
     imageFiles = dir(fullfile(frames, 'f*.jpg'));
   

    % Loop through the output files and display combined results
     for i = 1:maxframenum-1 %or length imageFiles
        % Construct filenames assuming they follow the 'outXXXX.png' format
        img1 = imread(fullfile(smpl_bg_out, sprintf('out%04d.png', i)));
        img2 = imread(fullfile(smpl_fd_out, sprintf('out%04d.png', i)));
        img3 = imread(fullfile(adaptive_bg_out, sprintf('out%04d.png', i)));
        img4 = imread(fullfile(persistent_fd_out, sprintf('out%04d.png', i)));

        
        combined_out = [img1 img2; img3 img4];
        figure(1); imshow(combined_out);
        %colormap(gray);  % Apply grayscale colormap
        

    end
end
