function frames = read_frames(video_path)
%READ_FRAMES Read the needed frames from a video
%
% Apr. 2015, Zexi Mao

interval = 1;

video = VideoReader(video_path);
frame_nums = round(1 : video.FrameRate * interval : video.NumberOfFrames);
frames = zeros(video.Height, video.Width, 3, length(frame_nums), 'uint8');

for i = 1 : length(frame_nums)
    frames(:, :, :, i) = read(video, frame_nums(i));
end

end
