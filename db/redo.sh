psql --host=db --dbname=winetracker --file=drop.sql 
psql --host=db --dbname=winetracker --file=create.sql
./populate.pl data/shed.csv
psql --host=db --dbname=winetracker --file=dump.sql 

