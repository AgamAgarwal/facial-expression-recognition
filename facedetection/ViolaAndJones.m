%
%	Wrapper for ViolaAndJones algorithm
%	Using standard HAAR Features
%
%	@param image: Path to image file or MATLAB image object
%	
%	@return boxes: List of boxes detected as N x 4 vectors : [x y width height]
%
function [boxes I] = ViolaAndJones(image, annotated)
	I = image;
	if ischar(I)
		if exist(I, 'file') ~= 2
			error('File does not exist');
		end
		I = imread(I);
	end

	faceDetector = vision.CascadeObjectDetector();
	boxes = step(faceDetector, I);

	if annotated == true,
		shapeInserter = vision.ShapeInserter('BorderColor','Custom', 'CustomBorderColor', uint8([255 255 0]));
		rectangle = int32(boxes);
		I = step(shapeInserter, I, rectangle);
	end
end
