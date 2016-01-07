function [intensity, zxy, winSize] = gotoLevelA(windowSize, topLeftCoordinateX, topLeftCoordinateY, height, width, saltAndPepperImg, x, y)
    if(topLeftCoordinateY <= height && topLeftCoordinateX <= width)
        buffer = zeros(1, windowSize * windowSize);
        position = 1;
        for j = 0 : windowSize - 1
            for i = 0 : windowSize - 1
                if(topLeftCoordinateY + j <= height && topLeftCoordinateX + i <= width)
                    buffer(position) =  saltAndPepperImg(topLeftCoordinateY + j, topLeftCoordinateX + i);
                else
                    buffer(position) =  saltAndPepperImg(topLeftCoordinateY, topLeftCoordinateX);
                end
                position = position + 1;
            end
        end

        buffer = unique(buffer);
        Zmax = max(buffer);
        Zmin = min(buffer);
        Zmed = median(buffer);
        A1 = Zmed - Zmin;
        A2 = Zmed - Zmax;
        Zxy = saltAndPepperImg(y, x);
        if A1 > 0 && A2 < 0
            intensity = gotoLevelB(Zxy, Zmax, Zmin, Zmed);
        else
            windowSize = windowSize + 2;
            intensity = false;
        end
        zxy = Zxy;
        winSize = windowSize;
    end
end


