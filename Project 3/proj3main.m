function proj3main(frames, threshold, alpha, gamma)
    
    % Process frames with different background subtraction methods
    smpl_bg_out = smpl_bg(frames, threshold);
    smpl_fd_out = smpl_fd(frames, threshold);
    adaptive_bg_out = adaptive_bg(frames, threshold, alpha);
    persistent_fd_out = persistent_fd(frames, threshold, gamma);

    % List output files for each method
    smpl_bg_outFiles = dir(fullfile(smpl_bg_out, 'out*.jpg'));
    smpl_fd_outFiles = dir(fullfile(smpl_fd_out, 'out*.jpg'));
    adaptive_bg_outFiles = dir(fullfile(adaptive_bg_out, 'out*.jpg'));
    persistent_fd_outFiles = dir(fullfile(persistent_fd_out, 'out*.jpg'));

    % Loop through the output files and display combined results
    for i = 1:length(smpl_bg_outFiles)
        img1 = imread(fullfile(smpl_bg_out, smpl_bg_outFiles(i).name));
        img2 = imread(fullfile(smpl_fd_out, smpl_fd_outFiles(i).name));
        img3 = imread(fullfile(adaptive_bg_out, adaptive_bg_outFiles(i).name));
        img4 = imread(fullfile(persistent_fd_out, persistent_fd_outFiles(i).name));

        % Combine images into a single figure
        combined_out = [img1, img2; img3, img4];
        figure;
        imshow(combined_out);
    end
end
