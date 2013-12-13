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

	# Probabilities
	@b_b = @l_b = @b_l = @l_l = @h_b = @t_b = @h_l = @t_l = 0.5
end

# Reads from files
# 	(i) Sequence of Observations
# 	(ii) Transition and Sensory Probabilities
def read_file(seq_fn = "seq.txt", prob_fn = "hmm.txt")
	
	# Reads Sequence of Observations from File
	if !File.exists?(seq_fn)
		seq_fn = "seq.txt"
		if !File.exists?(seq_fn)
			print "File does not exist."
			return			
		end
	end

	print "Reading file "
	print seq_fn
	print "\n"

	ifile = File.new(seq_fn, "r")
	while (line = ifile.gets)
		if (line.to_i.to_s == line)
			# Converting the line into an array.
			@observations = line.chars.map(&:to_i)
			break
		end
	end
	ifile.close

	# Reads Transition and Sensory Probabilites from a file
	if !File.exists?(prob_fn)
		prob_fn = "hmm.txt"
		if !File.exists?(prob_fn)
			print "File does not exist."
			return			
		end
	end
end

init
print "Expectation-Maximization Algorithm\n\n"
read_file