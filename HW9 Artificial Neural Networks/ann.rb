#////////////////////////////////////////////////////#
# Title: CSCI 580 - Homework 9 - Artificial Neural Networks
# Filename: ann.rb
# Date Created: 11/16/2013 
# Author: Dipen Chauhan
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#


# Initialize variables
def init
	@x11 = 0.11
	@x12 = 0.11
	@y5 = 0.9
	@y6 = 0.1

	# Weights
	@w = Array.new(5) { Array.new(7, 0.0) }
	# Dummy weights
	@w[0][1] = @w[0][2] = @w[0][3] = @w[0][4] = @w[0][5] = @w[0][6] = 0.01
	# Given weights
	@w[1][3] = -0.04
	@w[1][4] = -0.03
	@w[2][3] = 0.02
	@w[2][4] = 0.05
	@w[3][5] = -0.02
	@w[3][6] = -0.01
	@w[4][5] = 0.03
	@w[4][6] = 0.04

	# Weighted sum of inputs
	@in = Array.new(7, 0.0)

	# Output
	@a = Array.new(7, 0.0)
	# Dummy Input
	@a[0] = 1.0

	# Error
	@error = Array.new(7, 0.0)

	@alpha = 0.01


end

def calc
	# Step 1
	@a[1] = @x11
	@a[2] = @x12

	# Step 2
	#layer l = 2
		# Step 3
	@in[3] = (@a[0] * @w[0][3]) + (@a[1] * @w[1][3]) + (@a[2] * @w[2][3])
	@a[3] = 1 / (1 + Math.exp(-@in[3]))	
	@in[4] = @a[0]*@w[0][4] + @a[1]*@w[1][4] + @a[2]*@w[2][4]
	@a[4] = 1 / (1 + Math.exp(-@in[4]))

	#layer l = 3
		# Step 3
	@in[5] = @a[0]*@w[0][5] + @a[3]*@w[3][5] + @a[4]*@w[4][5]
	@a[5] = 1 / (1 + Math.exp(-@in[5]))
	@in[6] = @a[0]*@w[0][6] + @a[3]*@w[3][6] + @a[4]*@w[4][6]
	@a[6] = 1 / (1 + Math.exp(-@in[6]))

	# Step 4
	@error[5] = @a[5] * (1 - @a[5]) * (@y5 - @a[5])
	@error[6] = @a[6] * (1 - @a[6]) * (@y6 - @a[6])

	# Step 5
	# layer l = 2
		# Step 6
	@error[3] = @a[3] * (1 - @a[3]) * (@error[5] * @w[3][5] + @error[6] * @w[3][6])
	@error[4] = @a[4] * (1 - @a[4]) * (@error[5] * @w[4][5] + @error[6] * @w[4][6])
	# layer l = 1
		# Step 6
	@error[1] = @a[1] * (1 - @a[1]) * (@error[3] * @w[1][3] + @error[4] * @w[1][4])
	@error[2] = @a[2] * (1 - @a[2]) * (@error[3] * @w[2][3] + @error[4] * @w[2][4])

	# Step 7
	@w[0][1] = @w[0][1] + @alpha * @a[0] * @error[1]
	@w[0][2] = @w[0][2] + @alpha * @a[0] * @error[2]
	@w[0][3] = @w[0][3] + @alpha * @a[0] * @error[3]
	@w[0][4] = @w[0][4] + @alpha * @a[0] * @error[4]
	@w[0][5] = @w[0][5] + @alpha * @a[0] * @error[5]
	@w[0][6] = @w[0][6] + @alpha * @a[0] * @error[6]
	@w[1][3] = @w[1][3] + @alpha * @a[1] * @error[3]
	@w[1][4] = @w[1][4] + @alpha * @a[1] * @error[4]
	@w[2][3] = @w[2][3] + @alpha * @a[2] * @error[3]
	@w[2][4] = @w[2][4] + @alpha * @a[2] * @error[4]
	@w[3][5] = @w[3][5] + @alpha * @a[3] * @error[5]
	@w[3][6] = @w[3][6] + @alpha * @a[3] * @error[6]
	@w[4][5] = @w[4][5] + @alpha * @a[4] * @error[5]
	@w[4][6] = @w[4][6] + @alpha * @a[4] * @error[6]
end


print "===============================\n"
print "HW9: Artificial Neural Networks\n"
print "===============================\n"
print "by Dipen Chauhan\n\n"

init

if ARGV.size == 0
	n = 100

	print "N = %d\n" % [n]
	init
	for i in 1..n
		calc
	end
	
	print "\nOutput a_j:\n"
	for i in 1..(@a.size - 1)
		print i
		print ": "
		print @a[i]
		print "\n"
	end

	print "\nErrors delta_j: \n"	
	for i in 1..(@error.size - 1)
		print i
		print ": "
		print @error[i]
		print "\n"
	end

	print "\nWeights w:\n"
	for i in 0..(@w[0].size - 1)
		print @w[i]
		print "\n"
	end

	print "===============================\n"


	n = 1000

	print "N = %d\n" % [n]
	init
	for i in 1..n
		calc
	end
	
	print "\nOutput a_j:\n"
	for i in 1..(@a.size - 1)
		print i
		print ": "
		print @a[i]
		print "\n"
	end

	print "\nErrors delta_j: \n"	
	for i in 1..(@error.size - 1)
		print i
		print ": "
		print @error[i]
		print "\n"
	end

	print "\nWeights w:\n"
	for i in 0..(@w[0].size - 1)
		print @w[i]
		print "\n"
	end

	print "===============================\n"

	n = 10000

	print "N = %d\n" % [n]
	init
	for i in 1..n
		calc
	end
	
	print "\nOutput a_j:\n"
	for i in 1..(@a.size - 1)
		print i
		print ": "
		print @a[i]
		print "\n"
	end

	print "\nErrors delta_j: \n"	
	for i in 1..(@error.size - 1)
		print i
		print ": "
		print @error[i]
		print "\n"
	end

	print "\nWeights w:\n"
	for i in 0..(@w[0].size - 1)
		print @w[i]
		print "\n"
	end

	print "===============================\n"

	# print "error5 = %f\n" % [@error[5]]
	# print "error6 = %f\n" % [@error[6]]
	# print @w
else
	print "using argv: %s" % [ARGV[0]]
end
