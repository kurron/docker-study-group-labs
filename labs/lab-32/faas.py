#!/usr/bin/env python

import sys
import os

# read in the environment
convertToUppercase = os.getenv( 'CONVERT_TO_UPPERCASE', 'false' ) == "true"

# pull out the command line arguments
raw = "".join( sys.argv[1:] )

# print out the arguments, based on the environment settings
print( raw.upper() if convertToUppercase else raw )
