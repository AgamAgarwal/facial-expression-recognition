%
%	Wrapper for ViolaAndJones algorithm
%	Using standard HAAR Features
%
%	@param image: Path to image file or MATLAB image object
%	
%	@return boxes: List of boxes detected as N x 4 vectors : [x y width height]
%
function [maxbox I] = ViolaAndJones(image, annotated)
	I = image;
	if ischar(I)
		if exist(I, 'file') ~= 2
			error('File does not exist');
		end
		I = imread(I);
	end

	faceDetector = vision.CascadeObjectDetector();
	boxes = step(faceDetector, I);
	if size(boxes, 1) == 0,
		maxbox = [];
		return;
	end

	% return only the largest rectangle
	boxareas = boxes(:,3) .* boxes(:, 4);
	[val index] = max(boxareas);
	maxbox = boxes(index, :);

	if annotated == true,
		%shapeInserter = vision.ShapeInserter('BorderColor','Custom', 'CustomBorderColor', uint8([255 255 0]));
		shapeInserter = vision.ShapeInserter;
		rectangle = int32(maxbox);
		I = step(shapeInserter, I, rectangle);
	end
end
