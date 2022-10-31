#!/bin/bash
# Check directory if not create
[ ! -d css ] && mkdir css
[ ! -d js ]  && mkdir js

# Check css files if not download
[ ! -f css/league.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/league.css -O css/league.css
[ ! -f css/black.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/black.css -O css/black.css
[ ! -f css/white.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/white.css -O css/white.css
[ ! -f css/moon.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/moon.css -O css/moon.css
[ ! -f css/serif.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/serif.css -O css/serif.css
[ ! -f css/reset.css ]  && wget https://unpkg.com/reveal.js@^4//dist/reset.css		  -O css/reset.css
[ ! -f css/reveal.css ] && wget https://unpkg.com/reveal.js@^4//dist/reveal.css		  -O css/reveal.css

# Check js files if not download
[ ! -f js/search.js ] && wget https://unpkg.com/reveal.js@^4//plugin/search/search.js -O js/search.js
[ ! -f js/notes.js ]  && wget https://unpkg.com/reveal.js@^4//plugin/notes/notes.js   -O js/notes.js
[ ! -f js/reveal.js ] && wget https://unpkg.com/reveal.js@^4//dist/reveal.js		  -O js/reveal.js
[ ! -f js/zoom.js ]   && wget https://unpkg.com/reveal.js@^4//plugin/zoom/zoom.js	  -O js/zoom.js

# Check Parameter Empty
[ -z "$1" ] && { echo -e "Some or all of the parameters are empty. \n\n Usage: $0 {{ name_of_file }}.md {{ theme }} \n"; exit 1; }

# Check File exsists
[ ! -f "$1" ] && { echo "File $1 dose not exsist."; exit 1; }

# Check if .md extension
[ "${1: -3}" == ".md" ] || { echo "File is not a Markdown file."; exit 1; }

# Check if pandoc is installed	
pandoc -v >/dev/null 2>&1 || { echo >&2 "Please install the latest version of pandoc."; exit 1; }

function listofthemes(){
	echo "List of Themes"
	echo -e "\033[1mblack\033[0m	Black background, white text, blue links (default)"
	echo -e "\033[1mwhite\033[0m	White background, black text, blue links"
	echo -e "\033[1mleague\033[0m	Gray background, white text, blue links"
	echo -e "\033[1mbeige\033[0m	Beige background, dark text, brown links"
	echo -e "\033[1msky\033[0m	Blue background, thin dark text, blue links"
	echo -e "\033[1mnight\033[0m	Black background, thick white text, orange links"
	echo -e "\033[1mserif\033[0m	Cappuccino background, gray text, brown links"
	echo -e "\033[1msimple\033[0m	White background, black text, blue links"
	echo -e "\033[1msolarized\033[0m	Cream-colored background, dark green text, blue links"
	echo -e "\033[1mblood\033[0m	Dark background, thick white text, red links"
	echo -e "\033[1mmoon\033[0m	Dark blue background, thick grey text, blue links"
	exit 1
}

if [ -z "$2" ]
then
	echo "No Theme selectet"
	listofthemes
fi

# change Theme
case "$2" in
"black")
	theme="black" ;;
"white")
	theme="white" ;;
"league")
	theme="league" ;;
"beige")
	theme="beige" ;;
"sky")
	theme="sky" ;;
"night")
	theme="night" ;;
"serif")
	theme="serif" ;;
"simple")
	theme="simple" ;;
"solarized")
	theme="solarized" ;;
"blood")
	theme="blood" ;;
"moon")
	theme="moon" ;;
*)
	echo "False theme"
    listofthemes ;;
esac

# Cut Name from Parameter
name=$(echo "$1" | cut -d "." -f 1)

# Create slides
pandoc -s -t revealjs "$name".md -o "$name".html --slide-level 3 --variable theme="$theme"

# Array of file names
declare -a StringArray=("league.css" \
						"black.css" \
						"serif.css" \
						"white.css" \
						"moon.css" \
						"reset.css" \
						"reveal.css" \
						"search.js" \
						"zoom.js" \
						"notes.js" \
						"reveal.js" \
						)

for i in "${StringArray[@]}"; do
	newname=$(echo "$i" | cut -d "." -f 2)/"$i"
	sed -i "s|https.*$i|$newname|g" "$name".html
done; 
