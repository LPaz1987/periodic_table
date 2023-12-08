#!/bin/bash


PSQL="psql --username=freecodecamp --dbname=periodic_table -t --no-align -c"
#check if input empty
if [[ -z $1 ]]
then
	echo "Please provide an element as an argument."
else
	#check input if is number

	if  [[ $1 =~ ^[0-9]+$ ]]
	then
		#get info troghtatomic_number
		GET_AM=$($PSQL "select atomic_mass from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.atomic_number = '$1'")
		GET_NAME=$($PSQL "select name from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.atomic_number = '$1'")
		GET_SYMBOL=$($PSQL "select symbol from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.atomic_number = '$1'") 
		GET_MELTING=$($PSQL "select melting_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.atomic_number = '$1'")
		GET_BOILING=$($PSQL "select boiling_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.atomic_number = '$1'")
		GET_TYPE=$($PSQL "select type from types left join properties on types.type_id = properties.type_id  where properties.atomic_number = '$1'")
		
		
		if [[ -z $GET_AM ]]
		then
			echo "I could not find that element in the database."
		else
			echo  "The element with atomic number $1 is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_AM amu. $GET_NAME has a melting point of $GET_MELTING celsius and a boiling point of $GET_BOILING celsius." | tr -s " "
		fi

	
	fi
  

	if [[ $1 =~ ^[A-Z,a-z]{1,2}?$ ]]
	then
		#get info troghtatomic_number
		GET_AN=$($PSQL "select atomic_number from  elements where symbol = '$1'")

		
		if [[ -z $GET_AN ]]
		then
			echo "I could not find that element in the database."
		else
			GET_AM=$($PSQL "select atomic_mass from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.atomic_number = '$GET_AN'")
			GET_NAME=$($PSQL "select name from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.symbol = '$1'")
			GET_SYMBOL=$($PSQL "select symbol from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.symbol = '$1'")
			GET_MELTING=$($PSQL "select melting_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.symbol = '$1'")
			GET_BOILING=$($PSQL "select boiling_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.symbol = '$1'")
			GET_TYPE=$($PSQL "select type from types left join properties on types.type_id = properties.type_id  where properties.atomic_number = '$GET_AN'")
		
			echo  "The element with atomic number $GET_AN is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_AM amu. $GET_NAME has a melting point of $GET_MELTING celsius and a boiling point of $GET_BOILING celsius." | tr -s " "
		
		fi
	fi

	

	if [[ $1 =~ ^[A-Z,a-z]{3,}$ ]]
	then
		#get info troghtatomic_number
			GET_AN=$($PSQL "select atomic_number from elements where name = '$1'")
			if [[ -z $GET_AN ]]
			then
					echo "I could not find that element in the database."
			else
				GET_AN=$($PSQL "select atomic_number from elements where name = '$1'")
				GET_AM=$($PSQL "select atomic_mass from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.atomic_number = '$GET_AN'")
				GET_NAME=$($PSQL "select name from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.name = '$1'")
				GET_SYMBOL=$($PSQL "select symbol from elements left join properties on elements.atomic_number = properties.atomic_number  where elements.name = '$1'")
				GET_MELTING=$($PSQL "select melting_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.name = '$1'")
				GET_BOILING=$($PSQL "select boiling_point_celsius from properties left join elements on properties.atomic_number = elements.atomic_number  where elements.name = '$1'")
				GET_TYPE=$($PSQL "select type from types left join properties on types.type_id = properties.type_id  where properties.atomic_number = '$GET_AN'")
				echo "The element with atomic number $GET_AN is $GET_NAME ($GET_SYMBOL). It's a $GET_TYPE, with a mass of $GET_AM amu. $GET_NAME has a melting point of $GET_MELTING celsius and a boiling point of $GET_BOILING celsius." | tr -s " "
			fi
	fi
fi

