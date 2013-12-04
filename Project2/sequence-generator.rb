#////////////////////////////////////////////////////#
# Title: CSCI 580 Project 2
# Filename: sequence-generator.rb
# Date Created: 12/3/2013 
# Author: Dipen Chauhan
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize all variables
def init
	@sequence_length = 0
end


init

print ARGV
print "\n"

if ARGV.size == 0
	@sequence_length = 20
else
	@sequence_length = ARGV[0]
end

print "Sequence of States\n"

print "\n\nSequence of Observations\n"