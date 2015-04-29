function overlap = get_overlap(box1, box2)
%GET_OVERLAP Get the overlap of two bounding boxes.
%
% Apr. 2015, Zexi Mao

area = (box1(3) - box1(1) + 1) * (box1(4) - box1(2) + 1);
x1 = max(box1(1), box2(1));
y1 = max(box1(2), box2(2));
x2 = min(box1(3), box2(3));
y2 = min(box1(4), box2(4));
w = x2 - x1 + 1;
h = y2 - y1 + 1;
if w > 0 && h > 0
    overlap = w * h / area;
else
    overlap = 0;
end

end
