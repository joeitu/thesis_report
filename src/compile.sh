for f in $(ls *.md)
do
  pandoc -s -o "$f.pdf" "$f"
done
