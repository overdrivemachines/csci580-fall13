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
			[0, 0, 0.33, 0, 0.55, 0, 0, 0, 0, 0, 0, 0, 0],
			[0, 0, 0, 0.5, 0, 0, 0, 0.5, 0, 0, 0, 0, 0],
			[0.5, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0],
			[0, 0, 0.33, 0, 0, 0, 0, 0, 0, 0, 0.33, 0, 0],
			[0, 0, 0, 0, 0.5, 0, 0, 0, 0, 0, 0, 0, 0.5],
			[0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0.5, 0, 0, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0.33, 0, 0],
			[0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0.5, 0, 0.5, 0],
			[0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0.33, 0, 0.5],
			[0, 0, 0, 0, 0, 0, 0, 0.5, 0, 0, 0, 0.5, 0]
			]

	# P(e | X) for discrepancy d 0-4
	@probability_e_given_X = [0.6561, 0.0729, 0.0081, 0.0009, 0.0001]

	# f[i] = P(X0 = i)
	@f = Matrix.column_vector(Array.new(@NUMBER_OF_LOCATIONS, 1.0/@NUMBER_OF_LOCATIONS))
end


# Observation to binary
# eg. when e = NW, North and West have obstacles
# 		result = 1010
# result is in the format <NSWE>
# 1 - obstacle; 0 - no obstacle
def otob(observation)

end

# Calculate probabilities
def calc(observation)
	
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



# @r.to_a.each {|r| puts r.inspect}

# For each argument
ARGV.each do|a|

end