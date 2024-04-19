function [adaptive_bg_out] = adaptive_bg(dirstring, threshold, alpha)

    %Initialize background
    backgroundFilename = fullfile(dirstring, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);

    %Initialize directory
    adaptive_bg_out = fullfile(dirstring, 'adaptive_bg_out');
    if ~exist(adaptive_bg_out, 'dir')
        mkdir(adaptive_bg_out);
    end

    imageFiles = dir(fullfile(dirstring, 'f*.jpg'));

    %Iterate through input frames
    for i = 2:length(imageFiles)

        %Get current frame and grayscale
        currentFrameFilename = fullfile(dirstring, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);
        
        %Apply alpha blending
        background = alpha * double(currentFrameGray) + (1 - alpha) * double(background);
        
        %Compute difference frame and apply threshold
        diffFrame = abs(double(currentFrameGray) - background);
        binaryOut = diffFrame > threshold;
        binaryOut = uint8(binaryOut*255); %To make compatible w/ persistent
   
        %Write to file
        adaptive_bg_frame = fullfile(adaptive_bg_out, sprintf('out%04d.png', i-1));
        imwrite(binaryOut, adaptive_bg_frame);
    end
end