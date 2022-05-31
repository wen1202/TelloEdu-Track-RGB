clear all
clc 

mytello = ryze();     %連接到Tello，並將Tello命名為myTello
cameraObj = camera(mytello);     %開啟相機
preview(cameraObj);     %顯示畫面
takeoff(mytello);     %起飛


minGreenIntensity =40;     %令綠色分量強度最小值=40
while(1)
      img = snapshot(cameraObj);    %拍攝圖像
      G=Green(mytello, img, minGreenIntensity);    %從圖像中捕捉綠色物體   
      if G == 0 
          break;
      end
      pause(0.5);     %暫停0.5s
end

      moveforward(mytello,'Distance',1.98);    %前進1.98m
      turn(mytello,-pi/2);      %向左轉90度
      pause(1);     %暫停1s



minBlueIntensity =40;     %令藍色分量強度最小值=40
while(1)
      img = snapshot(cameraObj);     %拍攝圖像
      B=Blue(mytello, img, minBlueIntensity);    %從圖像中捕捉藍色物體     
      if B == 0 
          break;
      end
      pause(0.5);     %暫停0.5s
end
      moveforward(mytello,'Distance',1.98);    %前進1.98m
      turn(mytello,-pi/2);      %向左轉90度
      pause(1);


      
minRedIntensity =40;     %令紅色分量強度最小值=40
while(1)
      img = snapshot(cameraObj);      %拍攝圖像
      R=  Red(mytello, img, minRedIntensity);    %從圖像中捕捉紅色物體
      pause(0.5);     %暫停0.5s
      if  R == 0
          break;
      end
end
      moveforward(mytello,'Distance',1.98);    %前進1.98m
      pause(1);     %暫停1s

   
      land(mytello);     %降落

    
%% GREEN function   
function green=Green(ryzeObj, img, greenThreshold)
%% Extract RGB color components from the FPV camera image 
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
%% Approximate the intensity of green components in the image 
greenIntensities = g - r/2 - b/2;
%% Threshold the image to find the regions that we consider to be green enough 
bwImg = greenIntensities > greenThreshold;

% Find indices of green pixels in the image
[row, col] = find(bwImg);

% Find green pixels and track the ball using drone if there are enough
% green pixels in the image
if(length(row) < 50 || length(col) < 50)
    disp('hovering');
    green= 1;
else 
    green= 0;
    
end
end


%% BLUE function
function blue=Blue(ryzeObj, img, blueThreshold)
%% Extract RGB color components from the FPV camera image 
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
%% Approximate the intensity of blue components in the image 
blueIntensities =b - r/2 - g/2;
%% Threshold the image to find the regions that we consider to be blue enough 
bwImg = blueIntensities > blueThreshold;

% Find indices of blue pixels in the image
[row, col] = find(bwImg);

% Find blue pixels and track the ball using drone if there are enough
% blue pixels in the image

if(length(row) < 50 || length(col) < 50)
    disp('hovering');
    blue = 1;
    
else
    blue = 0;
end
end


%% RED function
function red=Red(ryzeObj, img, redThreshold)
%% Extract RGB color components from the FPV camera image 
r = img(:,:,1);
g = img(:,:,2);
b = img(:,:,3);
%% Approximate the intensity of red components in the image 
redIntensities = r - g/2 - b/2;

%% Threshold the image to find the regions that we consider to be red enough 
bwImg = redIntensities > redThreshold;

% Find indices of red pixels in the image
[row, col] = find(bwImg);

% Find red pixels and track the ball using drone if there are enough
    % red pixels in the image
if(length(row) < 50 || length(col) < 50)
    disp('hovering');
    red = 1;
else
    red = 0;
end
end