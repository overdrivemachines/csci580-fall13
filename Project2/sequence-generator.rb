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
# Default file is hmm.txt. If hmm.txt is missing, 
# all values are set to 0.5
#
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize all variables
def init
	@states = Array.new
	@observations = Array.new
	@b_b = @l_b = @b_l = @l_l = @h_b = @t_b = @h_l = @t_l = 0.5
end

# Reads the file
def read_file(fn = "hmm.txt")
	# If file does not exist
	if !File.exists?(fn)
		fn = "hmm.txt"
		if !File.exists?(fn)
			return
		end
	end

	# Open the file. Read only.
	ifile = File.new(fn, "r")
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

def gen_seq(seq_length = 20)
	@states = Array.new(seq_length)
	@observations = Array.new(seq_length)

	# Initial State
	if rand <= 0.50
		@states[0] = "B"
	else
		@states[0] = "L"
	end

	for i in 0..(seq_length - 2)
		if @states[i] == "B"
			if rand <= @b_b
				@states[i + 1] = "B"
			else
				@states[i + 1] = "L"
			end
		else
			if rand <= @l_l
				@states[i + 1] = "L"
			else
				@states[i + 1] = "B"
			end
		end
	end

	# Generating sequence of Observations based on the
	# the sequence of States.
	for i in 0..(seq_length - 1)
		if @states[i] == "B"
			if rand <= @h_b
				# @observations[i] = "H"
				@observations[i] = 1
			else
				# @observations[i] = "T"
				@observations[i] = 0
			end
		else
			if rand <= @h_l
				# @observations[i] = "H"
				@observations[i] = 1
			else
				# @observations[i] = "T"
				@observations[i] = 0
			end
		end
	end
end

# Displays the two sequences on the screen
def display_seq(seq_length = 20)
	puts "Sequence of States\n"
	for i in 0..(seq_length - 1)
		print @states[i]
	end	
	puts "\n\nSequence of Observations\n"
	for i in 0..(seq_length - 1)
		print @observations[i]
	end
	puts
end

# Writes the sequence to the file
def write_seq(seq_length = 20, fn = "seq.txt")
	if File.exists?(fn)
		File.delete(fn)
	end

	ofile = File.new(fn, "w")
	for i in 0..(seq_length - 1)
		ofile.write(@states[i])
	end
	ofile.write("\n")
	for i in 0..(seq_length - 1)
		ofile.write(@observations[i])
	end

	ofile.close

end

init

input_file = "hmm.txt"
output_file = "random-seq.txt"
seq_length = 20

if ARGV.size == 0
	input_file = "hmm.txt"
	output_file = "random-seq.txt"
	seq_length = 20
elsif ARGV.size == 1
	# The argument can either be the number of interations
	# or the file name
	
	# If 1st argument is a number
	if ARGV[0].to_i.to_s == ARGV[0]
		seq_length = ARGV[0].to_i
	else
	# If 1st argument is a file name
		input_file = ARGV[0]
	end
	
elsif ARGV.size == 2
	# 2 arguments in the format: [file_name] [sequence_length]
	input_file = ARGV[0]
	seq_length = ARGV[1].to_i
else
	abort "ERROR: Too many arguments"
end

read_file(input_file)
gen_seq(seq_length)
display_seq(seq_length)
write_seq(seq_length)