function [smpl_fd_out] = smpl_fd(frames, threshold)
    % Define the background image file
    backgroundFilename = fullfile(frames, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);



    % Define the output directory
    smpl_fd_out = fullfile(frames, 'smpl_fd_out');
    if ~exist(smpl_fd_out, 'dir')
        mkdir(smpl_fd_out);
    end

    imageFiles = dir(fullfile(frames, 'f*.jpg'));

    % Process each image
    for i = 2:length(imageFiles)
        % Generate filename for the current frame
        currentFrameFilename = fullfile(frames, sprintf('f%04d.jpg', i));
        
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);
        
        diffFrame = abs(double(currentFrameGray) - double(background));
        
        background = currentFrameGray; % Adaptive background updating
        mask = diffFrame > threshold;
        mask = uint8(mask*255);


        % Define file name (out%04d.png, i) and write calculated image to that file path
        smpl_fd_frame = fullfile(smpl_fd_out, sprintf('out%04d.png', i-1));
        imwrite(mask, smpl_fd_frame);

        
    end
end
