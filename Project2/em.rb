#////////////////////////////////////////////////////#
# Title: CSCI 580 Project 2
# Filename: em.rb
# Date Created: 12/13/2013 
# Author: Dipen Chauhan
# Description:
# Syntax for arguments
# 	em
# This program generates:
#
# Program looks for an input file that contains values
#
# Default input file is seq.txt
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize
def init
	# Sequence of observations (Given from file)
	@observations = Array.new
end

# Reads the file
def read_file(fn = "seq.txt")
	if !File.exists?(fn)
		fn = "seq.txt"
		if !File.exists?(fn)
			print "File does not exist."
			return			
		end
	end

	print "Reading file "
	print fn
	print "\n"

	ifile = File.new(fn, "r")
	while (line = ifile.gets)
		if (line.to_i.to_s == line)
			# Converting the line into an array.
			@observations = line.chars.map(&:to_i)
			break
		end
	end
	puts @observations
	ifile.close
end

init
print "Expectation-Maximization Algorithm\n\n"
read_file