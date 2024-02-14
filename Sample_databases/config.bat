mysql -u root -p1234 < world.sql

mysql -u root -p1234 < ./sakila/sakila-schema.sql

mysql -u root -p1234 < ./sakila/sakila-data.sql

cd test_db-master

mysql -u root -p1234 < employees.sql

mysql -u root -p1234 -t < test_employees_md5.sql

pause