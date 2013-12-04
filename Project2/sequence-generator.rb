#////////////////////////////////////////////////////#
# Title: CSCI 580 Project 2
# Filename: sequence-generator.rb
# Date Created: 12/3/2013 
# Author: Dipen Chauhan
# Description:
# Syntax for arguments
# 	sequence-generator [sequence_length]
# 	OR
# 	sequence-generator [file_name] [sequence_length]
#
# This program generates:
# 	(i) Sequence of States
#   (ii) Sequence of Observations based on the states
# Length of the sequence can be specified as an argument.
# Default sequence length is 20.
#
# Program looks for an input file that contains values
# for the following (in the same order):
# B|B, L|B, B|L, L|L, H|B, T|B, H|L, T|L
# Input file can be specified as an argument.
# Default file is input.txt. If input.txt is missing, 
# all values are set to 0.5
#
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize all variables
def init
	@sequence_length = 0
	@b_b = @l_b = @b_l = @l_l = @h_b = @t_b = @h_l = @t_l = 0.5
end

# Reads the file
def read_file(fn)
	ifile = File.new(fn, "r")
	while (line = ifile.gets)
		puts "#{line}"
	end
	ifile.close
end

init

if ARGV.size == 0
	@sequence_length = 20
	read_file("input.txt")
elsif ARGV.size == 1
	# The argument can either be the number of interations
	# or the file name
	
	# If 1st argument is a number
	if ARGV[0].to_i.to_s == ARGV[0]
		@sequence_length = ARGV[0].to_i
		read_file("input.txt")
	else
		@sequence_length = 20
		read_file(ARGV[0])		
	end
	
elsif ARGV.size == 2
	read_file(ARGV[0])
	@sequence_length = ARGV[1]
else
	abort "ERROR: Too many arguments"
end

puts "Sequence of States\n"

puts "\n\nSequence of Observations\n"