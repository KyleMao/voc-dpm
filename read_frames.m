function frames = read_frames(video_path)
%READ_FRAMES Read the needed frames from a video
%
% Apr. 2015, Zexi Mao

interval = 1;

video = VideoReader(video_path);
frame_nums = round(1 : video.FrameRate * interval : video.NumberOfFrames);
frames = cell(length(frame_nums), 1);

for i = 1 : length(frame_nums)
    frames{i} = read(video, frame_nums(i));
end

end
