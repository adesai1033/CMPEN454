function [adaptive_bg_out] = adaptive_bg(frames, threshold, alpha)
    % Define the background image file
    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);

    % Define the output directory
    adaptive_bg_out = fullfile(frames, 'adaptive_bg_out');
    if ~exist(adaptive_bg_out, 'dir')
        mkdir(adaptive_bg_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg'));

    % Process each image
    for i = 2:length(imageFiles)
        % Generate filename for the current frame
        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);
        
        % Update background with alpha blending
        background = alpha * double(currentFrameGray) + (1 - alpha) * double(background);
        
        % Calculate frame difference
        diffFrame = abs(double(currentFrameGray) - background);
        mask = diffFrame > threshold;

   

        % Define file name for output (out%04d.png, i) and write mask to that file path
        adaptive_bg_frame = fullfile(adaptive_bg_out, sprintf('out%04d.png', i));
        imwrite(mask, adaptive_bg_frame);
    end
end