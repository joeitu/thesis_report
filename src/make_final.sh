file_name=final_$(date +'%Y_%m_%d_%Hh%M').md

cat *.md > $file_name
pandoc --toc -s -o "../pdf/$file_name.pdf" "$file_name"
okular "../pdf/$file_name.pdf"
