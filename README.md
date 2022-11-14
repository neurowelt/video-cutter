# Video Cutter
Simple Perl script for cutting out fragments of video based on .csv sheet with specified times using **ffmpeg** library. Without these two installed this script will not work.

Use `example_input.csv` as the template to draw time frames, input files and output names from.

Example usage (in Terminal):
```
 perl -w ffmpeg_video_cut.pl example_input.csv
```

The `-w` argument adds useful warning to execution.