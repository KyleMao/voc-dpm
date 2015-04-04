function car_predict()
%CAR_PREDICT Get the prediction of cars on images
%
% Mar. 2015, Zexi Mao

startup;

load('VOC2010/car_final');
listing = dir('surveillance_images');
params = 0.5:-0.1:-1.3;
for j = 1 : length(params)
    for i = 1 : length(listing)
        if (listing(i).name(1) ~= '.')
            imname = fullfile('surveillance_images', listing(i).name);
            savename = ['exps\exp', num2str(params(j))];
            predict(imname, model, params(j), savename);
        end
    end
end

end


function predict(imname, model, thresh, outdir)

im = imread(imname);
slash = strfind(imname, '/');
dot = strfind(imname, '.');
id = imname((slash(end)+1) : (dot(end)-1));
disp(id);
[ds, ~, ~] = imgdetect(im, model, thresh);
if (isempty(ds))
    fprintf('No car detexted!\n');
else
    clf;
    top = nms(ds, 0.5);
    ds = ds(top, :);
    %bs = bs(top, :);
    showboxes(im, ds);
    savename = fullfile(outdir, [id, '.png']);
    print(savename, '-dpng');
   
end

end
