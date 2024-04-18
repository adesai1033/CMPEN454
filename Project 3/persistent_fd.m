function [persistent_fd_out] = persistent_fd(frames, threshold, gamma)

    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);
    prev_motionframe_persistent = zeros(size(background), 'double');

    

    persistent_fd_out = fullfile(frames, 'persistent_fd_out');
    if ~exist(persistent_fd_out, 'dir')
        mkdir(persistent_fd_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg')); %makes frames an array so we can get the length of the frames

    % Process each image
    for i = 2:length(imageFiles)

        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);

        diff = abs(double(currentFrameGray) - double(background)); %difference of current frame and background (first frame)
        
        thresholdframe_persistent = diff > threshold;    %threshold

        decay_factor = 1 - gamma / 255;
        temp = prev_motionframe_persistent * decay_factor;

        motionframe_persistent =  max(temp, 255 * thresholdframe_persistent);

        background = currentFrameGray; %update the background so that it is the previous frame (for all algos except simple bg subtraction)
        prev_motionframe_persistent = motionframe_persistent;


        persistent_fd_frame = fullfile(persistent_fd_out, sprintf('out%04d.png', i));
        imwrite(motionframe_persistent, persistent_fd_frame);


    end