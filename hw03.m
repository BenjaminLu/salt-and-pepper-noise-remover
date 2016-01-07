clear variables
close all
clc

%read the image
originalImg = imread('pic/Lenna.jpg');

%get height and width
[height, width, rgb1] = size(originalImg);

saltAndPepperImg = zeros(height, width, 'uint8');
density = 50;
density = double(density);

percent = density / 100;

figure, imshow(originalImg);

%add salt and pepper noise
for j = 1 : height
    for i = 1 : width
        randNum = rand();
        if randNum < (percent / 2) 
            saltAndPepperImg(j, i) = 0;
        elseif randNum >= (percent / 2) && randNum < percent
            saltAndPepperImg(j, i) = 255;
        else
            saltAndPepperImg(j, i) = originalImg(j, i);
        end
    end
end 

imwrite(saltAndPepperImg, 'pic\salt_and_pepper_img.jpg');
figure, imshow(saltAndPepperImg);

%processing image using algorithm AMF(Adaptive Median Filter)
for j = 1 : height
    for i = 1 : width
        windowSize = 3;
        while true
            topLeftCoordinateX = i - floor(windowSize / 2);
            topLeftCoordinateY = j - floor(windowSize / 2);

            if(topLeftCoordinateX < 1)
                break;
            end
            
            if(topLeftCoordinateY < 1)
                break;
            end

            %calculate the proper intensity
            [intensity, Zxy, winSize] = gotoLevelA(windowSize, topLeftCoordinateX, topLeftCoordinateY, height, width, saltAndPepperImg, i, j);

            if intensity ~= false
                saltAndPepperImg(j, i) = intensity;
                break;
            end

            if winSize <= 7
                windowSize = winSize;
            else
                saltAndPepperImg(j, i) = Zxy;
                break;
            end
        end
    end
end

figure, imshow(saltAndPepperImg);

imwrite(saltAndPepperImg, 'pic\hw3.jpg');

