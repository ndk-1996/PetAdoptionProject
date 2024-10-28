# we will run this module as toplevel
# in the cmi, whenever we want to launch the pet_adoption_app

from pet_adoption_app import flobj
from flask_mysqldb import MySQL

#create a MySQL object to connect to mysql server
mysql = MySQL(flobj)
