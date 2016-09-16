function make_frames_to_video(...
    input_dir_path, ...
    output_video_filename, ...
    framerate ...
)
%Make Frames to Video makes a video frome the frames in a directory

files = dir(input_dir_path);

vw = VideoWriter([output_video_filename, '.mp4'], 'MPEG-4');
vw.FrameRate = framerate;
open(vw);

for i = 3:length(files)
    frame = imread(fullfile(input_dir_path, files(i).name));
    vw.writeVideo(frame);
end

close(vw);
end