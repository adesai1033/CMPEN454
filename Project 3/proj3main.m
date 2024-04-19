function proj3main(dirstring, maxframenum, threshold, alpha, gamma)

    %Get output directory of each algorithm
    smpl_bg_out = smpl_bg(dirstring, threshold);
    smpl_fd_out = smpl_fd(dirstring, threshold);
    adaptive_bg_out = adaptive_bg(dirstring, threshold, alpha);
    persistent_fd_out = persistent_fd(dirstring, threshold, gamma);

    %Initialize directory
    quad_output_dir = fullfile(dirstring, 'quad_out');
    if ~exist(quad_output_dir, 'dir')
        mkdir(quad_output_dir);
    end

    %Iterate through each frame
    for i = 1:maxframenum-1 % -1 b/c one less output frame then inputs

        %Get current output frame from each algorithm
        img1 = imread(fullfile(smpl_bg_out, sprintf('out%04d.png', i)));
        img2 = imread(fullfile(smpl_fd_out, sprintf('out%04d.png', i)));
        img3 = imread(fullfile(adaptive_bg_out, sprintf('out%04d.png', i)));
        img4 = imread(fullfile(persistent_fd_out, sprintf('out%04d.png', i)));

        % Combine to quad image and write to directory
        quad_image = [img1 img2; img3 img4];
        quad_out_frame = fullfile(quad_output_dir, sprintf('quad_out%04d.png', i));
        imwrite(quad_image, quad_out_frame);

        %Display quad image
        figure(1); imshow(quad_image);
        
    end
end
