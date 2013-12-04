#////////////////////////////////////////////////////#
# Title: CSCI 580 Project 2
# Filename: sequence-generator.rb
# Date Created: 12/3/2013 
# Author: Dipen Chauhan
# Description:
# Syntax for arguments
# 	sequence-generator [sequence_lenght]
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
# Default file is input.txt
# 
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize all variables
def init
	@sequence_length = 0
end

# Reads 
def read_file

end

init

if ARGV.size == 0
	@sequence_length = 20
elsif ARGV.size == 1
	@sequence_length = ARGV[0]
else
	@file_name = ARGV[0]
	@sequence_length = ARGV[1]
end

print "Sequence of States\n"

print "\n\nSequence of Observations\n"