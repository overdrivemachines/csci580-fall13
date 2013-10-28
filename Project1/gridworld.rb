require 'matrix'

# Initialize variables
def init
	@NUMBER_OF_LOCATIONS = 13

	# r = transpose(T) 
	# r[i][j] = P(X(t) = i | X(t-1) = j)	
	@r = Matrix[
			[0, 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0],
			[0.5, 0, 0.33, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0.5, 0, 0.5, 0, 0, 0.5, 0, 0, 0, 0, 0, 0],
			[0, 0, 0.33, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0, 0],
			[0.5, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0],
			[0, 0, 0.33, 0, 0, 0, 0, 0, 0, 0, 0.33, 0, 0],
			[0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0.5],
			[0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0.5, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0.33, 0, 0],
			[0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0.5, 0, 0.5, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.33, 0, 0.5],
			[0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0.5, 0]]

	# P(e | X) for discrepancy d 0-4
	@probability_e_given_X = [0.6561, 0.0729, 0.0081, 0.0009, 0.0001]

	# f[i] = P(X0 = i)
	@f = Matrix.column_vector(Array.new(@NUMBER_OF_LOCATIONS, 1.0/@NUMBER_OF_LOCATIONS))

	@nswe = Array.new(13, "0000")
	@nswe[0] = "1010"
	@nswe[1] = "1100"
	@nswe[2] = "1000"
	@nswe[3] = "1100"
	@nswe[4] = "1001"
	@nswe[5] = "0011"
	@nswe[6] = "0011"
	@nswe[7] = "0011"
	@nswe[8] = "0101"
	@nswe[9] = "1100"
	@nswe[10] = "0100"
	@nswe[11] = "1100"
	@nswe[12] = "0101"

end


# Observation to binary
# eg. when e = NW, North and West have obstacles
# 		result = 1010
# result is in the format <NSWE>
# 1 - obstacle; 0 - no obstacle
def evidence_to_binary(e)
	b = Hash.new("0")
	e.each_char do |i|
		b[i] = "1"
	end

	binary = "0000"
	binary[0] = b['N']
	binary[1] = b['S']
	binary[2] = b['W']
	binary[3] = b['E']
	binary
end

# Discrepancy
# number of bits that differ in value between ei and the corresponding value for <NSWE> for the square.
def discrepancy(a, b)
	case
		when a.empty? then b.length
		when b.empty? then a.length
		else [(a[0] == b[0] ? 0 : 1) + discrepancy(a[1..-1], b[1..-1]),
				1 + discrepancy(a[1..-1], b),
				1 + discrepancy(a, b[1..-1])].min
	end
end

# Calculate probabilities
def calc(observation)
	# Discrepancies for every location compared to observation
	d_all = Array.new(@NUMBER_OF_LOCATIONS, 0)
	# Converting observation to binary
	obs_binary = evidence_to_binary(observation)

	@y = @r * @f

	for i in 0..(@NUMBER_OF_LOCATIONS - 1)
		d_all[i] = discrepancy(obs_binary, @nswe[i])
	end


	
	o = Matrix.zero(@NUMBER_OF_LOCATIONS)
	o_array = *o
	for i in 0..(@NUMBER_OF_LOCATIONS - 1)
		o_array[i][i] = @probability_e_given_X[d_all[i]]
	end
	o = Matrix[*o_array]
	
	# o.to_a.each {|r| puts r.inspect}


end




print "+---+---+---+---+---+\n"
print "| 1 | 2 | 3 | 4 | 5 |\n"
print "+---+---+---+---+---+\n"
print "| 6 |   | 7 |   | 8 |\n"
print "+---+---+---+---+---+\n"
print "| 9 | 10| 11| 12| 13|\n"
print "+---+---+---+---+---+\n\n"

print "Observations: "
print ARGV.to_s
print "\n\n"

init
calc("NS")


# @r.to_a.each {|r| puts r.inspect}

# For each argument
ARGV.each do|a|

end