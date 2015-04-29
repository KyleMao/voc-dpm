function [ds, bs, trees] = imgdetect(im, model, thresh, ds_prev)
% Wrapper around gdetect.m that computes detections in an image.
%   [ds, bs, trees] = imgdetect(im, model, thresh)
%
% Return values (see gdetect.m)
%
% Arguments
%   im        Input image
%   model     Model to use for detection
%   thresh    Detection threshold (scores must be > thresh)

% AUTORIGHTS
% -------------------------------------------------------
% Copyright (C) 2009-2012 Ross Girshick
% 
% This file is part of the voc-releaseX code
% (http://people.cs.uchicago.edu/~rbg/latent/)
% and is available under the terms of an MIT-like license
% provided in COPYING. Please retain this notice and
% COPYING if you use this file (or a portion of it) in
% your project.
% -------------------------------------------------------
% Modified by: Zexi Mao, Apr. 2015

overlap_thresh = 0.5;

im = color(im);
pyra = featpyramid(im, model);
[ds, bs, trees] = gdetect(pyra, model, thresh);

top = nms(ds, overlap_thresh);
ds = ds(top, :);

for i = 1 : size(ds, 1)
    score = ds(i, end);
    weight_sum = 1;
    for j = 1 : size(ds_prev, 1)
        for k = 1 : size(ds_prev{j}, 1)
            if (get_overlap(ds(i, 1:4), ds_prev{j}(k, 1:4)) > 0.5)
                weight_sum = weight_sum + exp(-j);
                score = score + ds_prev{j}(k, end) * exp(-j);
                break;
            end
        end
    end
    ds(i, end) = score / weight_sum;
end

ds = sortrows(ds, -6);
