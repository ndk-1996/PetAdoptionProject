from flask_wtf import FlaskForm
from wtforms import StringField, PasswordField, BooleanField, SubmitField, IntegerField, RadioField
from wtforms.validators import DataRequired

# we are using a extension of flask
# to create web forms i.e flask-wtf

class LoginForm(FlaskForm):
    username = StringField('Username', validators=[DataRequired()])
    password = PasswordField('Password', validators=[DataRequired()])
    remember_me = BooleanField('Remember Me')
    submit = SubmitField('Sign In')


class RegisterFormUser(FlaskForm):
    name = StringField('Name', validators = [DataRequired()])
    phonenumber = IntegerField('Phone Number', validators = [DataRequired()])
    gender = RadioField('Gender', choices = [('1', 'male'), ('2', 'female'), ('3', 'others')], validators = [DataRequired()])
    submit = SubmitField('Submit')
    date = StringField('Date', validators = [DataRequired()])
    address = StringField('Address', validators = [DataRequired()])
    user_id = StringField('Create Username', validators = [DataRequired()])
    password = PasswordField('Password', validators = [DataRequired()])
    con_password = PasswordField('Confirm Password', validators = [DataRequired()])


class UpdateInfo(FlaskForm):
    name = StringField('Name', validators = [DataRequired()])
    phonenumber = IntegerField('Phone Number', validators = [DataRequired()])
    gender = RadioField('Gender', choices = [('1', 'male'), ('2', 'female'), ('3', 'others')], validators = [DataRequired()])
    submit = SubmitField('Submit')
    address = StringField('Address', validators = [DataRequired()])
    password = PasswordField('Password', validators = [DataRequired()])
    con_password = PasswordField('Confirm Password', validators = [DataRequired()])


class PetDonateForm(FlaskForm):
    name = StringField('Petname', validators = [DataRequired()])
    gender = RadioField('Gender', choices = [('1', 'male'), ('2', 'female')], validators = [DataRequired()])
    pettype = RadioField('Select one', choices = [('1', 'dog'), ('2', 'cat')], validators = [DataRequired()])
    submit = SubmitField('Donate')
    date = StringField('Date', validators = [DataRequired()])
    breedname = StringField('Breedname', validators = [DataRequired()])
    height = IntegerField('Height in cms', validators = [DataRequired()])
    weight = IntegerField('Weight in kgs', validators = [DataRequired()])


class SearchBar(FlaskForm):
    breedname = StringField('Breedname', validators = [DataRequired()])
    search = SubmitField('Search')


class AdoptDate(FlaskForm):
        date = StringField('Date', validators = [DataRequired()])
        submit = SubmitField('Click here to adopt')


class AddBreed(FlaskForm):
    breedname = StringField('Breedname', validators = [DataRequired()])
    breedcost = IntegerField('Breedcost', validators = [DataRequired()])
    country_of_origin = StringField('Country of Origin', validators = [DataRequired()])
    submit = SubmitField('AddBreed')


class AddVet(FlaskForm):
    name = StringField('Name', validators = [DataRequired()])
    address = StringField('Address', validators = [DataRequired()])
    pnumber = IntegerField('Phone Number', validators = [DataRequired()])
    gender = RadioField('Gender', choices = [('1', 'male'), ('2', 'female'), ('3', 'others')], validators = [DataRequired()])
    submit = SubmitField('AddVet')


class AddShelter(FlaskForm):
    name = StringField('Name', validators = [DataRequired()])
    address = StringField('Address', validators = [DataRequired()])
    pnumber = IntegerField('Phone Number', validators = [DataRequired()])
    submit = SubmitField('AddShelter')
