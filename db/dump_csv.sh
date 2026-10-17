psql --host=db --dbname=winetracker --file=dump_csv.sql --csv | perl -e 'while(<>){s/\s+\,/\,/g; s/\s+\"/\"/g; print;}'

