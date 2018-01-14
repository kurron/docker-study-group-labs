#!/usr/bin/env groovy

// read in environment variables
def environment = System.getenv()

// set the conversion switch based on the environment
def convertToUppercase = Boolean.valueOf( environment.getOrDefault( 'CONVERT_TO_UPPERCASE', 'false' ) )

// process the input strings
println  convertToUppercase ? args.join( '' ).toUpperCase() : args.join( '' )
