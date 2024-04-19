function [smpl_bg_out] = smpl_bg(dirstring, threshold)

    %Initialize background
    backgroundFilename = fullfile(dirstring, 'f0001.jpg');
    background = imread(backgroundFilename);
    background = rgb2gray(background);

    %Initialize output directory
    smpl_bg_out = fullfile(dirstring, 'smpl_bg_out');
    if ~exist(smpl_bg_out, 'dir')
        mkdir(smpl_bg_out);
    end

    imageFiles = dir(fullfile(dirstring, 'f*.jpg'));
    %Iterate throughe each frame (2 b/c background already processed)
    for i = 2:length(imageFiles)

        %Process current frame and grayscale
        currentFrameFilename = fullfile(dirstring, sprintf('f%04d.jpg', i));
        currentFrame = imread(currentFrameFilename);
        currentFrameGray = rgb2gray(currentFrame);

        %Compute difference frame and apply threshold
        diffFrame = abs(double(currentFrameGray) - double(background));
        binaryOut = diffFrame > threshold;
        binaryOut = uint8(binaryOut*255); % *255 to be compatible with persistent in quad image

        smpl_bg_frame = fullfile(smpl_bg_out, sprintf('out%04d.png', i-1)); %i-1 b/c i starts at 2
        imwrite(binaryOut, smpl_bg_frame);


    end
end
