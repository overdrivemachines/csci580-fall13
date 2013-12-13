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
# Copyright Dipen Chauhan
#////////////////////////////////////////////////////#

# Initialize
def init
	
end

# Reads the file
def read_file(fn = "seq.txt")
	if !File.exists?(fn)
		fn = "seq.txt"
		if !File.exists?(fn)
			print "File does not exist."
			return
		else
			print "Reading file "
			print fn
			print "\n"
		end
	end

	ifile = File.new(fn, "r")

	ifile.close
end

init
