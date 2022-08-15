1. If there are NO already translated texts:
2. in TRADOS : copy all source to target + save.
3. copy the sdlxliff file to the trados-tools directory as "trados.sdlxliff"
4. execute perl ex.pl trados.sdlxliff
5. ... files trados-source and trados-target.txt will be created
6. create a word file from trados-target.txt
7. translate the word file with deeple (make sure the word file has less than 100,000 characters)
8. copy the translated text back to trados-target.txt
9. verify the inconsistencies in trados-target.txt using "perl verify.pl" and fix all errors
10. inject the target file back using "perl in.pl trados.sdlxliff"



1. If there are already some translated texts:
2. copy the sdlxliff file to the trados-tools directory as "trados.sdlxliff"
3. execute perl ex.pl trados.sdlxliff
4. ... files trados-source and trados-target.txt will be created
5. rename trados-target.txt to trados-target-czech.txt
6. Go back to TRADOS and do: copy all source to target + save
7. copy the sdlxliff file to the trados-tools directory as "trados.sdlxliff"
8. execute perl ex.pl trados.sdlxliff
9. files trados-source and trados-target.txt will be created
10. split the trados-target.txt using the czech file: "perl split.pl" - trados-target-split.txt is created
11. create a word file from trados-target-split.txt
12. translate the word file with deeple (make sure the word file has less than 100,000 characters)
13. copy the translated text back to trados-target-split-translated.txt
14. merge the files (trados-target-split-translated.txt and trados-target-czech.txt) using "perl merge.pl"
15. (trados-target.txt is created from the merge) (WARNING: possible bug in merge - may not copy the last line!!!)
16. inject the target file back using "perl in.pl trados.sdlxliff"
 

