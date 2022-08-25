#!/bin/bash
###############################################################################################
#				COMBOIDSCRIPT						      #
#	This script combine and permute the words contained in a file			      #
###############################################################################################
#------------------------PREPARE INPUTS----------------------
# put file contain on a string variable
words=$(cat $1)
length=$(($(echo $words | wc -w)))
#-------------------------  Recursive Function   --------------------------------------------
# this function will create a "firstword" that is two words joined.
# then create a new wordlist without that 2 words and with that new "first word", 
# making a "firstword" bigger as combination of one more word, and the wordlist smaller because it will have less words to combine
# when it only have 2 words it just show both joined ending the recursive method.
function recursiveword {
# it show the first word in the input list"
echo $1
# if there are only 2 words in the list, it add them and show that new word finishing the recursive method
if [ $# == 2 ]; then
	echo $1$2
else
#if there are more than 2 words it take the first word and it add one of the other words
# it will go throught all the other words and...
	for i in $(seq 2 $#); do
		# take one word
		newcut=$( echo $* | cut -d' ' -f $i)
		# create new word list without that word and without the first word
		newlast=$( echo $* | cut -d' ' -f 1,$i --complement )
		# create new wordlist where the "first word" is a combination of the previous first word and the word chosed in that loop itteration
		# this wordlist will have one word less
		newwords=$( echo $1$newcut $newlast )
		# then, we call this fuction again with the newwordlist, where we have one more word combined inside the "firstword"
		recursiveword $newwords

	done
fi

}
# the recursive function needs the first word to permute with
# so this part create every possible combination changing the first word for each word in the original wordlist file.
for i in $(seq 1 $length); do
	newfirst=$( echo $words | cut -d' ' -f $i )
	newlast=$( echo $words | cut -d' ' -f $i --complement )
	newwords=$( echo $newfirst $newlast )
	recursiveword $newwords
done



