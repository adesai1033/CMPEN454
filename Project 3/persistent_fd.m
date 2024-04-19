function [persistent_fd_out] = persistent_fd(dirstring, threshold, gamma)

    %Initialize background and motion frame history
    backgroundFilename = fullfile(dirstring, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);
    prev_motionframe_persistent = zeros(size(background), 'double');

    %Initialize output directory
    persistent_fd_out = fullfile(dirstring, 'persistent_fd_out');
    if ~exist(persistent_fd_out, 'dir')
        mkdir(persistent_fd_out);
    end

    imageFiles = dir(fullfile(dirstring, 'f*.jpg'));

    %Iterate through each input frame
    for i = 2:length(imageFiles)

        %Read the current frame and convert to grayscale
        currentFrameFilename = fullfile(dirstring, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);

        %Compute difference frame and apply threshold
        diffFrame = abs(double(currentFrameGray) - double(background));
        thresholdframe_persistent = diffFrame > threshold; 

        %Apply the decay to the previous motion frame
        temp = max(prev_motionframe_persistent - gamma, 0);

        %Combine the decayed motion history with the new motion
        motionframe_persistent = max(temp, 255 * double(thresholdframe_persistent));

        %Update background and motion history
        background = currentFrameGray;
        prev_motionframe_persistent = motionframe_persistent;

        motionframe_persistent = uint8(motionframe_persistent);

        %Write to folder
        persistent_fd_frame = fullfile(persistent_fd_out, sprintf('out%04d.png', i-1));
        imwrite(motionframe_persistent, persistent_fd_frame);

    end
end
