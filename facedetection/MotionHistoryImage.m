function [ mhi ] = MotionHistoryImage(filename)
%MOTIONHISTORYIMAGE Function returns the motion history image given the
%	name of a video file
%
%	@param filename: The name of the video file

%read the video
obj=VideoReader(filename);
nFrames=obj.NumberOfFrames;

%get the first (reference) frame
first=read(obj, 1);

%initialize mhi as a black image
mhi=uint8(zeros(size(first, 1), size(first, 2)));

for i=1:nFrames-1
	
	%decay old mhi by dividing values by 2 and include the next difference
	%using the bitwise or operator
	mhi=bitor(bitshift(mhi, -1), diffImage(first, read(obj, i)));
	
end

end

