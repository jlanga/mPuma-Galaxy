#!/usr/bin/perl -w
use strict;
use Getopt::Long;
use IPC::Open2;
my ($input,$WIDTH);
my @options = (
	'i=s',	\$input,
	'w=s',	\$WIDTH
);
&GetOptions(@options);
$WIDTH = 60 unless defined $WIDTH;

# my $numFiles = @ARGV;
# die "Usage: $0 -o output -w 60 file1.sff file2.fq file3.fastq file4.fq.gz file5.fq.gz" if ($numFiles < 1);

# redirect STDOUT to a file if it was specified
# open(STDOUT,">$output") or die "Error opening $output for writting: $!" if defined $output;

# figure out how to handle the file based on file extension
# foreach my $file (@ARGV){
# 	if ($file =~ /\.sff$/){
# 		 &dump_sff($file);
# 	}elsif(($file =~ /\.fq$/)or($file =~ /\.fastq$/)){
# 		 &dump_fq_compressed($file,0);
# 	}elsif(($file =~ /\.fq.gz$/)or($file =~ /\.fastq.gz$/)){
# 		 &dump_fq_compressed($file,1)
# 	}else{
# 		die "Error no method to handle $file";
# 	}	
# }


# Very hacky: user specifies format, so all the files must have same format!

if ($input eq "sff"){
  foreach my $file (@ARGV){
    &dump_sff($file);
  }
}elsif ($input eq "fq"){
  foreach my $file (@ARGV){
    &dump_fq_compressed($file,0);
  }
}elsif ($input eq "fq-gz"){
  foreach my $file (@ARGV){
    &dump_fq_compressed($file,1);
  }
}else{
  die "Error no format especified";
}	


# Hau da dana

# c'est ca
exit 0;

# get FASTA for sff via sffinto (SFFTools from Roche/454)
sub dump_sff {
	my $file = shift;
	die "Error lost file" unless defined $file;
	my $pid = open2(\*FASTA_OUT,\*FASTA_IN,'sffinfo','-s',$file)
		or die "Error calling sffinfo -s $file: $!";
	close(FASTA_IN) or die "Error closing STDIN to FASTA stream: $!";
	print STDOUT while(<FASTA_OUT>);
	wait;
}

# get FASTA for Fastq. This is the fastest implementation I can think of
# this can handle gzip compression if gzip is in the path...
# this does print to a fixed number of columns based on $WIDTH (global)
sub dump_fq_compressed{
	my $file = shift;
	die "Error lost file" unless defined $file;
	
	# allow for a simple signal as to the Gzip compression of the file
	my $isCompressed = shift;

	if ($isCompressed){
		open(FILE,"gzip -dc $file |") or die "Error opening $file: $!";
	}else{
		open(FILE,"<$file") or die "Error opening $file: $!";
	}

	while(my $header = <FILE>){
        	chomp $header;
        	my $seq = <FILE>;
        	chomp $seq;
        	if ($header =~ /^\@(.*)$/){
        	        $header = '>' . $1;
        	}else{
        	        die "Error bad header [$header]";
        	}
        	print STDOUT $header,"\n";
        
		my $junk = <FILE>; # + line is ignored
        	$junk = <FILE>; # qual line is ignored

		# pretty this up to 60 nucs / line...
                if(defined $seq && length($seq) > 0) {
                        $seq =~ s/(.{1,$WIDTH})/$1\n/g;
                }else {
                        $seq = "\n";
                }

        	print STDOUT $seq;
	}
	close FILE or die "Error closing $file: $!";
}
