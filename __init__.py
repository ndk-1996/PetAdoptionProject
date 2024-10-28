# {%   %} this is for statements
# {     } this is for expressions
# above blocks are used in html templates which are rendered by jinja2 template engine

from flask import Flask, url_for
import os

# create a Flask object
# passing the __name__ to help flask find resources
# of the filesystem and improve debugging
flobj = Flask(__name__)

# setting up the configurations variables
flobj.config['SECRET_KEY'] = 'dont try to guess it'
flobj.config['MYSQL_USER'] = 'root'
flobj.config['MYSQL_PASSWORD'] = '753752xl'
flobj.config['MYSQL_DB'] = 'petdb'
flobj.config['MYSQL_HOST'] = 'localhost'
flobj.config['UPLOAD_FOLDER'] = '/home/noob/pet_adoption/pet_adoption_app/static/'


from pet_adoption_app import routes
