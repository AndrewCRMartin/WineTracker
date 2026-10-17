user=`whoami`

# As PostgreSQL superuser
psql -c "CREATE DATABASE winetracker WITH OWNER $user;"

# As $user
psql --host=db --dbname=winetracker --file=create.sql
