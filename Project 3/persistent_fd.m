function [persistent_fd_out] = persistent_fd(frames, threshold, gamma)

    % Read the first frame and set it as the background
    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);
    prev_motionframe_persistent = zeros(size(background), 'double');

    % Create the output directory
    persistent_fd_out = fullfile(frames, 'persistent_fd_out');
    if ~exist(persistent_fd_out, 'dir')
        mkdir(persistent_fd_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg'));

    % Process each image
    for i = 2:length(imageFiles)

        % Read the current frame and convert to grayscale
        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);

        % Compute the absolute difference
        diff = abs(double(currentFrameGray) - double(background));
        
        % Apply the threshold
        thresholdframe_persistent = diff > threshold; % binary mask after thresholding

        % Apply the decay to the previous motion frame
        temp = max(prev_motionframe_persistent - gamma, 0);

        % Combine the decayed motion history with the new motion
        motionframe_persistent = max(temp, 255 * double(thresholdframe_persistent));

        % Update the background - optional based on algorithm requirements
        % background = currentFrameGray;

        % Update the motion history
        prev_motionframe_persistent = motionframe_persistent;

        motionframe_persistent = uint8(motionframe_persistent);


        % Manually normalize and scale motion frame to uint8
        %motionframe_persistent_scaled = 255 * (motionframe_persistent - min(motionframe_persistent(:))) / (max(motionframe_persistent(:)) - min(motionframe_persistent(:)));
        %motionframe_persistent_uint8 = uint8(motionframe_persistent_scaled);

        % Save the motion frame as an 8-bit image
        persistent_fd_frame = fullfile(persistent_fd_out, sprintf('out%04d.png', i));
        imwrite(motionframe_persistent, persistent_fd_frame);

    end
end
