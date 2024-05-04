% Load video

ef=VideoReader('name.of.video.mp4')
for img= 1:ef.NumberOfFrames;
    filename=strcat('frame',num2str(img),'.jpg');
    b=read(ef,img);
    imwrite(b,filename);
end

% Load frames: example for a video recorded at 25 fps with 20 frames

imtool('frame20.jpg')
imtool('frame19.jpg')
imtool('frame18.jpg')
imtool('frame17.jpg')
imtool('frame16.jpg')
imtool('frame15.jpg')
imtool('frame14.jpg')
imtool('frame13.jpg')
imtool('frame12.jpg')
imtool('frame11.jpg')
imtool('frame10.jpg')
imtool('frame9.jpg')
imtool('frame8.jpg')
imtool('frame7.jpg')
imtool('frame6.jpg')
imtool('frame5.jpg')
imtool('frame4.jpg')
imtool('frame3.jpg')
imtool('frame2.jpg')
imtool('frame1.jpg')

% Extract power spectral density of each bout and calculate its dominant frequency.

Fs = 25; % Sampling frequency = 25 Hz (i.e., 25 Frames per Second)
t = 0:0.04:(19*0.04); % Time scale vector of lip-smack bout: To each mouth displacement measurement (i.e., each frame) there is a corresponding time stamp, which is 0 seconds for the first frame and (n-1)*0.04 seconds (i.e., 1/(sampling frequency)) for the nth frame
x = [88.50233704, 90.52310448, 93.74177839, 93.76416916, 92.68941196, 90.39155868, 84.94220381, 83.42522881, 92.76498083, 98.37666881, 88.72064709, 85.52996166, 84.16412438, 91.24240813, 98.56139271, 92.34235495, 89.16566375, 88.4939405, 94.23437544, 100]; % example time series (i.e., mouth displacement measures of the lip-smack bout)
x = x - mean(x); % avoid getting 0 as the domain frequency (D-C offset)                                            
plot(t,x), axis('tight'), grid('on'), title('Time series'), figure % plot the time series
nfft = 1024; % large enough power of 2 which provides good resolution of the file without compromising computational time 
y = fft(x,nfft); % Fast Fourier Transform
y = abs(y.^2); % raw power spectrum density
y = y(1:1+nfft/2); % half-spectrum, for plotting
[v,k] = max(y); % find maximum
f_scale = (0:nfft/2)* Fs/nfft; % frequency scale
plot(f_scale, y),axis('tight'),grid('on'),title('Dominant Frequency') % plot the power spectrum of the time series
fest = f_scale(k); % dominant frequency estimate
fprintf('Dominant freq.: %f Hz\n', fest)
