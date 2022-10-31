#!/bin/bash
# Check directory if not create
[ ! -d css ] && mkdir css
[ ! -d js ]  && mkdir js

# Check css files if not download
[ ! -f css/league.css ] && wget https://unpkg.com/reveal.js@^4//dist/theme/league.css -O css/league.css
[ ! -f css/reset.css ]  && wget https://unpkg.com/reveal.js@^4//dist/reset.css		  -O css/reset.css
[ ! -f css/reveal.css ] && wget https://unpkg.com/reveal.js@^4//dist/reveal.css		  -O css/reveal.css

# Check js files if not download
[ ! -f js/search.js ] && wget https://unpkg.com/reveal.js@^4//plugin/search/search.js -O js/search.js
[ ! -f js/notes.js ]  && wget https://unpkg.com/reveal.js@^4//plugin/notes/notes.js   -O js/notes.js
[ ! -f js/reveal.js ] && wget https://unpkg.com/reveal.js@^4//dist/reveal.js		  -O js/reveal.js
[ ! -f js/zoom.js ]   && wget https://unpkg.com/reveal.js@^4//plugin/zoom/zoom.js	  -O js/zoom.js

# Check Parameter Empty
[ -z "$1" ] && { echo -e "Some or all of the parameters are empty. \n\n Usage: $0 {{ name_of_file }}.md \n"; exit 1; }

# Check File exsists
[ ! -f "$1" ] && { echo "File $1 dose not exsist."; exit 1; }

# Check if .md extension
[ "${1: -5}" == ".html" ] || { echo "File is not a html file."; exit 1; }

# Array of file names
declare -a StringArray=("league.css" \
						"reset.css" \
						"reveal.css" \
						"search.js" \
						"zoom.js" \
						"notes.js" \
						"reveal.js" \
						)

for i in "${StringArray[@]}"; do
	newname=$(echo "$i" | cut -d "." -f 2)/"$i"
	sed -i "s|https.*$i|$newname|g" "$1"
done;
