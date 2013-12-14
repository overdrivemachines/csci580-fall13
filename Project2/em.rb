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
	@b_B = Array.new
	@b_L = Array.new

	# Not Normalized Probabilities
	@nn_B_B = Array.new
	@nn_B_L = Array.new
	@nn_L_B = Array.new
	@nn_L_L = Array.new

	# Normalized Probabilities
	@n_B_B = Array.new
	@n_B_L = Array.new
	@n_L_B = Array.new
	@n_L_L = Array.new
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
		if @observations[i - 1] == 1 # Observation is Heads
			@f_B[i] = @h_b * ((@f_B[i - 1] * @b_b) + (@f_L[i - 1] * @l_b))
			@f_L[i] = @h_l * ((@f_B[i - 1] * @b_l) + (@f_L[i - 1] * @l_l))
		else # Observation is Tails
			@f_B[i] = @t_b * ((@f_B[i - 1] * @b_b) + (@f_L[i - 1] * @l_b))
			@f_L[i] = @t_l * ((@f_B[i - 1] * @b_l) + (@f_L[i - 1] * @l_l))
		end
	end

	# Backward Algorithm
	@b_B[seq_length] = 0.5
	@b_L[seq_length] = 0.5
	
	for j in 1..seq_length
		i = seq_length - j
		if @observations[i] == 1 # Observation is Heads
			@b_B[i] = (@b_B[i + 1] * @b_b * @h_b) + (@b_L[i + 1] * @l_b * @h_l)
			@b_L[i] = @b_B[i]
		else
			@b_B[i] = (@b_B[i + 1] * @b_b * @t_b) + (@b_L[i + 1] * @l_b * @t_l)
			@b_L[i] = @b_B[i]
		end
	end

	p_e_1_n = @b_B[0]

	# Not Normalized Probabilities
	for i in 0..(seq_length - 1)
		if @observations[i] == 1 # Observation is Heads
			@nn_B_B[i] = @f_B[i] * @b_b * @h_b * @b_B[i + 1]
			@nn_B_L[i] = @f_L[i] * @b_l * @h_b * @b_B[i + 1]
			@nn_L_B[i] = @f_B[i] * @l_b * @h_l * @b_L[i + 1]
			@nn_L_L[i] = @f_L[i] * @l_l * @h_l * @b_L[i + 1]
		else
			@nn_B_B[i] = @f_B[i] * @b_b * @t_b * @b_B[i + 1]
			@nn_B_L[i] = @f_L[i] * @b_l * @t_b * @b_B[i + 1]
			@nn_L_B[i] = @f_B[i] * @l_b * @t_l * @b_L[i + 1]
			@nn_L_L[i] = @f_L[i] * @l_l * @t_l * @b_L[i + 1]
		end		
	end
	
	# Normalized Probabilities
	for i in 0..(seq_length - 1)
		@n_B_B[i] = @nn_B_B[i] / p_e_1_n
		@n_B_L[i] = @nn_B_L[i] / p_e_1_n
		@n_L_B[i] = @nn_L_B[i] / p_e_1_n
		@n_L_L[i] = @nn_L_L[i] / p_e_1_n
	end	
end

init
print "Expectation-Maximization Algorithm"


if (ARGV.size == 0)
	read_file
	iterations = 1
elsif (ARGV.size == 3)
	observations_file = ARGV[0]
	initial_p_file = ARGV[1]
	iterations = ARGV[2]
	read_file(observations_file, initial_p_file)
end

for i in 1..iterations
	calc
end

# puts @observations.size
# puts @b_B.inspect
# puts @b_L[0]