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

	@f_B = Array.new
	@f_L = Array.new
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

	print "\n\nReading file "
	print seq_fn
	print "\n"

	ifile = File.new(seq_fn, "r")
	while (line = ifile.gets)
		if (line.to_i.to_s == line)
			# Converting the line into an array.
			print "Observations: "
			print line
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

	print "\n\nReading file "
	print prob_fn
	print "\n"

	# Open the file. Read only.
	ifile = File.new(prob_fn, "r")
	@b_b = ifile.gets.to_f
	@l_b = ifile.gets.to_f
	@b_l = ifile.gets.to_f
	@l_l = ifile.gets.to_f
	@h_b = ifile.gets.to_f
	@t_b = ifile.gets.to_f
	@h_l = ifile.gets.to_f
	@t_l = ifile.gets.to_f
	ifile.close
end

def calc
	seq_length = @observations.size
	@f_B[0] = 0.5
	@f_L[0] = 0.5

	# Forward Algorithm
	for i in 1..seq_length
		puts i		
		if @observations[i - 1] == 1 # Observation is Heads
			@f_B[i] = @h_b * ((@f_B[i - 1] * @b_b) + (@f_L[i - 1] * @l_b))
			@f_L[i] = @h_l * ((@f_B[i - 1] * @b_l) + (@f_L[i - 1] * @l_l))
		else # Observation is Tails
			@f_B[i] = @t_b * ((@f_B[i - 1] * @b_b) + (@f_L[i - 1] * @l_b))
			@f_L[i] = @t_l * ((@f_B[i - 1] * @b_l) + (@f_L[i - 1] * @l_l))
		end
	end

	# Backward Algorithm
end

init
print "Expectation-Maximization Algorithm"

if (ARGV.size == 0)
	read_file
elsif (ARGV.size == 3)
	observations_file = ARGV[0]
	initial_p_file = ARGV[1]
	iterations = ARGV[2]
	read_file(observations_file, initial_p_file)
end

calc

# puts @observations.size
puts @f_B[9]
puts @f_L[9]