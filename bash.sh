# !bin/bash

echo 'Executing bash script'
mkdir studenti
cd studenti


# Check if the file is already present
if [ ! -f "./LCP_22-23_students.csv" ]
then
	echo 'Downloading students file'
	wget -nv https://www.dropbox.com/s/867rtx3az6e9gm8/LCP_22-23_students.csv
else
	echo 'File already present'
fi

file=LCP_22-23_students.csv

# Separate the data in two files
grep "PoD" $file > PoD.csv
grep "Physics" $file > Physics.csv

# Choose the file to analize

# Get the surnames and save the in a tmp file
cut -f1 -d ","  $file > tmp_file

# For each letter, count the surnames and find the max

count=0
max_count=0
max_letter="A"

# For cycle over all the letters in the alphabeth
for l in {A..Z}
do	
	# Save the count of the lines starting with tath letter in the variable count
	count=$( grep -c "^$l" tmp_file )
	echo "Letter $l : $count"
	
	# If the new count is bigger than the one before, update it
	if [ $count -gt $max_count ]
	then 
		max_count=$count
		max_letter=$l
	fi
	
done

echo "Most present letter $max_letter ( $max_count occurences )"

# Remove the temporary file
rm tmp_file

echo "Getting number of students"
number_of_students=$( grep -c "^" $file )
echo $number_of_students

for (( i=1; i<=$number_of_students; i++ ))
do 
	remainder=$(( $i % 18 ))
	# sed "${i}p takes the i-th line, -n suppress the rest of the output"
	sed -n "${i}p" < $file >> group.${remainder}.csv 

done

echo "Groups done!"




