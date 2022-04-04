#! /usr/bin/env bash
trash final_*
source_name=final_$(date +'%Y_%m_%d_%Hh%M').md
# pdf_path="../pdf/$source_name.pdf"
# pdf_path="../pdf/final.pdf"
pdf_path="./pdf/body.pdf"
text_name="final.txt"
text_path="../pdf/$text_name"

# cat *.md > $source_name
pandoc --number-sections --metadata link-citations --bibliography=refs.bib --filter pandoc-crossref  --csl ./csls/my_ieee.csl --toc -s -o $pdf_path "./FINAL.md"
# pandoc --number-sections --filter pandoc-crossref   --toc -s -o $pdf_path "$source_name"

pandoc -o 'pdf/abstract.pdf' ./00_abstract.wr.md
pandoc -o 'pdf/ack.pdf' ./acknoledgment.md

pdftk ./cover.pdf pdf/abstract.pdf pdf/ack.pdf pdf/body.pdf cat output pdf/final.pdf

# final page count
char_per_page=2400
mkdir -p text
pdftotext $pdf_path
nb_char=$(cat $text_path | wc -c)
nb_page=$(bc <<< "scale=2;  $nb_char/$char_per_page")
echo "NUMBER OF PAGES: $nb_page"
notify-send "NUMBER OF PAGES: $nb_page"


# ( okular $pdf_path &)
