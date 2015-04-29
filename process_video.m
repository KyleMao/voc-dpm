function process_video(video_path)
%PROCESS_VIDEO Get the video frames and do car detection.
%
% Apr. 2015, Zexi Mao

startup;
load('VOC2010/car_final');

thresh = -0.5;
outdir = 'frame_result';

frames = read_frames(video_path);
n_frame = size(frames, 4);

ds_prev = cell(2, 1);
for i = 1 : n_frame
    im = frames(:, :, :, i);
    [ds, ~, ~] = imgdetect(im, model, thresh, ds_prev);
    ds_prev{2} = ds_prev{1};
    ds_prev{1} = ds;
    showboxes(im, ds, fullfile(outdir, [int2str(i), '.png']));
end

end
