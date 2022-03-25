for f in $@
do
  pandoc --toc -s -o "../pdf/$f.pdf" "$f"
done
