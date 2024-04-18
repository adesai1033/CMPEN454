function [smpl_bg_out, smpl_fd_out, adaptive_bg_out, persistent_fd_out, combined_out] = proj3main(frames, threshold, alpha, gamma)

    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);
    prevFrame = background;
    motionframe_persistent = zeros(size(background));

    smpl_bg_out = fullfile(frames, 'smpl_bg_out');
    if ~exist(smpl_bg_out, 'dir')
        mkdir(smpl_bg_out);
    end

    smpl_fd_out = fullfile(frames, 'smpl_fd_out');
    if ~exist(smpl_fd_out, 'dir')
        mkdir(smpl_fd_out);
    end

    adaptive_bg_out = fullfile(frames, 'adaptive_bg_out');
    if ~exist(adaptive_bg_out, 'dir')
        mkdir(adaptive_bg_out);
    end

    persistent_fd_out = fullfile(frames, 'persistent_fd_out');
    if ~exist(persistent_fd_out, 'dir')
        mkdir(persistent_bfd_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg')); %makes frames an array so we can get the length of the frames

    % Process each image
    for i = 2:length(imageFiles)

        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);

        diffFrame_smpl_bg = abs(double(currentFrameGray) - double(background)); %difference of current frame and background (first frame)
        diffFrame_smpl_fd = abs(double(currentFrameGray) - prevFrame);           %difference of current frame and background (previous frame)
        diffFrame_adaptive_bg = abs(alpha * (double(currentFrameGray)) + (1 - alpha) * double(prevFrame)); %difference of current framea nd background (previous frame) using alpha blending

       
       

        %apply threshold
        motionframe_smpl_bg = diffFrame_smpl_bg > threshold;
        motionframe_smpl_fd =  diffFrame_smpl_fd > threshold;
        motionframe_adaptive = diffFrame_adaptive_bg > threshold;
        thresholdframe_persistent = diffFrame_smpl_fd > threshold;     %threshold

        prev_motionframe_persistent = max(motionframe_persistent - gamma, 0);
        motionframe_persistent=  max(prev_motionframe_persistent, 255 * thresholdframe_persistent);

        prevFrame = currentFrameGray; %update the background so that it is the previous frame (for all algos except simple bg subtraction)


        smpl_bg_frame = fullfile(smpl_bg_out, sprintf('out%04d.png', i));
        imwrite(motionframe_smpl_bg, smpl_bg_frame);

        smpl_fd_frame = fullfile(smpl_fd_out, sprintf('out%04d.png', i));
        imwrite(motionframe_smpl_fd, smpl_fd_frame);

        adaptive_frame = fullfile(adaptive_bg_out, sprintf('out%04d.png', i));
        imwrite(motionframe_adaptive, adaptive_frame);

        persistent_frame = fullfile(persistent_fd_out, sprintf('out%04d.png', i));
        imwrite(motionframe_persistent, persistent_frame);

        combined_out = [motionframe_smpl_bg, motionframe_smpl_fd; motionframe_adaptive_bg, motionframe_persistent];

    end