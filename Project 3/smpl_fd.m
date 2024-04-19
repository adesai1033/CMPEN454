function [smpl_fd_out] = smpl_fd(dirstring, threshold)

    %Initialize background
    backgroundFilename = fullfile(dirstring, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);

    %Initialize output directory
    smpl_fd_out = fullfile(dirstring, 'smpl_fd_out');
    if ~exist(smpl_fd_out, 'dir')
        mkdir(smpl_fd_out);
    end

    %Convert to list of images
    imageFiles = dir(fullfile(dirstring, 'f*.jpg'));

    %Process each frame, starts from 2 b/c background already processed
    for i = 2:length(imageFiles)

        %Get current frame and grayscale
        currentFrameFilename = fullfile(dirstring, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);
        
        %Compute difference  frameand apply threshold
        diffFrame = abs(double(currentFrameGray) - double(background));
        binaryOut = diffFrame > threshold;
        binaryOut = uint8(binaryOut*255);

        %Update background
        background = currentFrameGray;

        %Write motion frame to folder
        smpl_fd_frame = fullfile(smpl_fd_out, sprintf('out%04d.png', i-1));
        imwrite(binaryOut, smpl_fd_frame);

        
        
    end
end
