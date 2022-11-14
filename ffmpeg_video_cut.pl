#!/usr/bin/perl
use strict;
use warnings;
use DateTime;
use Time::Piece;
use Time::Seconds;

# Get the filename from terminal input
my $file = $ARGV[0] or die "Please input the filename\n";

# Set the time variables
my $start_time;
my $end_time;
my $starting = 1;

# Read the .csv file
print "Reading from: $file\n";
open(my $data, '<', $file) or die "Could not read '$file' $!\n";

# Loop through the data line by line
while (my $line = <$data>) {
  
  # Split the line and get the times
  chomp $line;
  my @fields = split ";", $line;
  $start_time = $fields[0];
  $end_time = $fields[1];
  
  # If this is the beginning, account for header
  if ($starting) {
    print $start_time;
    $starting = 0;
    next
  }

  # Get the times from strings
  my $start = Time::Piece->strptime($start_time,"%H:%M:%S");
  my $end = Time::Piece->strptime($end_time,"%H:%M:%S");
  my $duration = ($end - $start);
  
  # Count the hours, minutes and seconds
  my $h = "" . int($duration/3600);
  my $min = "" . int($duration/60);
  my $sec = "" . int($duration - 3600*$h - 60*$min);
  my @time_vars = ($h, $min, $sec);
  my @cut;

  # Iterate over them to get a right format for duration 
  for my $i (@time_vars) {
    if (length($i)==1) {
      push(@cut,"0$i")
    } else {
      push(@cut,"$i")
    }
  }
  
  # Prepare arguments for system call
  my $cut_ffmpeg = join(":",@cut);
  my $input_ffmpeg = $fields[2];
  my $output_ffmpeg = $fields[3];
  my $call = "ffmpeg -nostdin -ss $start_time -i $input_ffmpeg -t $cut_ffmpeg -c copy $output_ffmpeg";

  system($call)

}