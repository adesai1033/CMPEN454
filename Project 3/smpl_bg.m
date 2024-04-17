function [smpl_bg_out] = smpl_bg(frames)
    % Define the background image file
    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);

    thresholdValue = 30;

    % Define the output directory
    smpl_bg_out = fullfile(frames, 'smpl_bg_out');
    if ~exist(smpl_bg_out, 'dir')
        mkdir(smpl_bg_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg'));

    % Process each image
    for i = 2:length(imageFiles)
        % Generate filename for the current frame
        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);
        
        diffFrame = abs(double(currentFrameGray) - double(background));
        
        %background = currentFrameGray; % Adaptive background updating
        mask = diffFrame > thresholdValue;

        % Define file name (out%04d.png, i) and write calculated image to that file path
        smpl_bg_frame = fullfile(smpl_bg_out, sprintf('out%04d.png', i));
        imwrite(mask, smpl_bg_frame);
    end
end
