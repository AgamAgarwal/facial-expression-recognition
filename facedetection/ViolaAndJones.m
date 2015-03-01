%
%	Wrapper for ViolaAndJones algorithm
%	Using standard HAAR Features
%
%	@param image: Path to image file or MATLAB image object
%	
%	@return boxes: List of boxes detected as N x 4 vectors : [x y width height]
%
function boxes = ViolaAndJones(image)
	I = image;
	if ischar(I)
		if exist(I, 'file') ~= 2
			error('File does not exist');
		end
		I = imread(I);
	end

	faceDetector = vision.CascadeObjectDetector();
	boxes = step(faceDetector, I);
end
