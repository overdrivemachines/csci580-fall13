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
	@f = Array.new(@NUMBER_OF_LOCATIONS, 1/@NUMBER_OF_LOCATIONS)
end


def calc

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

# For each argument
ARGV.each do|a|

end

init