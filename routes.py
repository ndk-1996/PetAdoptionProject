from flask import render_template, flash, redirect, url_for, session, request
from pet_adoption_app import flobj
from forms import LoginForm, RegisterFormUser, PetDonateForm, AddBreed, AddShelter, AddVet, SearchBar, AdoptDate
from toplevelmodule import mysql
from passwd_security import encrypt
import time
from werkzeug.utils import secure_filename
import random
import os


# renders homepage of website
@flobj.route('/')
@flobj.route('/home')
def home():
    return render_template("base.html")

# about website and author page
@flobj.route('/home/about')
def about():
    return "Under Construction !!!!!"

# about the pet
@flobj.route('/home/about_pet')
def about_pet():
    return "Under Construction !!!!!"

@flobj.route('/home/why_adoption')
def why_adoption():
    return "Under Construction !!!!!"

# user sign up form
@flobj.route('/home/register' ,methods = ['GET', 'POST'])
def register():
    form = RegisterFormUser()

    if form.validate_on_submit():
        cur = mysql.connection.cursor()
        cur.execute('''select userid from user where userid = %s''', (form.user_id.data,))
        data = cur.fetchone()


        type = int(form.gender.data)
        sex = str(form.gender.choices[type-1][1])
        insert_query = '''insert into user (userid, name, userpasswd, address, pnumber, gender, doj) values (%s ,%s, %s, %s, %s, %s, %s)'''


        passwd = str(form.password.data)
        con_passwd = str(form.con_password.data)


        if passwd != con_passwd and len(data) != 0:
            err_message = "Password does not match!!"
            form.con_password.errors.append(err_message)
            err_message = "Entered username already exists!! Please enter different one"
            form.user_id.errors.append(err_message)
            return render_template('user_form.html', title = 'Register with us', form = form)


        if passwd != con_passwd:
            err_message = "Password does not match!!"
            form.con_password.errors.append(err_message)
            return render_template('user_form.html', title = 'Register with us', form = form)


        if data:
            err_message = "Entered username already exists!! Please enter different one"
            form.user_id.errors.append(err_message)
            return render_template('user_form.html', title = 'Register with us', form = form)


        sec = encrypt()
        enc_passwd = sec.encrypt_password(passwd)
        cur.execute(insert_query, (form.user_id.data, form.name.data, enc_passwd, form.address.data, form.phonenumber.data, sex, form.date.data))


        cur.connection.commit()
        return redirect(url_for('home'))

    return render_template('user_form.html', title = 'Register with us', form = form)


# user login form
@flobj.route('/home/login_user', methods = ['GET', 'POST'])
def login_user():
    if 'userid' in session:
        return redirect(url_for('userpage'))


    form = LoginForm()


    if form.validate_on_submit():
        sec = encrypt()
        cur = mysql.connection.cursor()
        cur.execute('''select userid, userpasswd from user''')
        data = cur.fetchall()
        funame = 0
        fpasswd = 0
        for tuple in data:
            dec_passwd = sec.decrypt_password(str(tuple[1]))
            if str(tuple[0]) == str(form.username.data) and dec_passwd == str(form.password.data):
                funame = 1
                fpasswd = 1
                session['userid'] = str(tuple[0])


        if min(funame, fpasswd) == 0:
            invcred = "Invalid Credentials!! Please enter valid details."
            return render_template('login_user.html', title = 'Login for user', form = form, invcred = invcred)

        return redirect(url_for('userpage'))

    return render_template('login_user.html', title = 'Login for user', form = form)


# admin login form
@flobj.route('/home/login_admin', methods = ['GET', 'POST'])
def login_admin():
    if 'admin' in session:
        return redirect(url_for('adminpage'))


    form = LoginForm()


    if form.validate_on_submit():
        if str(form.username.data) == 'admin' and str(form.password.data) == 'iamtheadmin':
            session['admin'] = 'iamtheadmin'
        else:
            invcred = "Invalid Credentials!! Please enter valid details."
            return render_template('login_admin.html', title = 'Login for admin', form = form, invcred = invcred)

        return redirect(url_for('adminpage'))

    return render_template('login_admin.html', title = 'Login for admin', form = form)


# logging out the user
@flobj.route('/home/logout_user')
def logout_user():
    session.pop('userid', None)
    return redirect(url_for('home'))


# logging out the admin
@flobj.route('/home/logout_admin')
def logout_admin():
    session.pop('admin', None)
    return redirect(url_for('home'))


# password protected pet list page and logged in user page
@flobj.route('/home/login/userpage')
def userpage():
    if 'userid' in session:
        cur = mysql.connection.cursor()
        cur.execute('''select name from user where userid = %s''', (session['userid'],))
        name = cur.fetchone()
        name = "Welcome!! " + name[0]
        return render_template('userpage.html', title = 'Userpage', name = name)
    else:
        return redirect(url_for('login_user'))


# password protected pet admin page
@flobj.route('/home/login/adminpage')
def adminpage():
    if 'admin' in session:
        name = "Welcome!! Admin"
        return render_template('adminpage.html', title = 'Adminpage', name = name)
    else:
        return redirect(url_for('login_admin'))


# logged person's information updation page
@flobj.route('/home/login/personal_information')
def per_info():
    if 'userid' in session:
        cur = mysql.connection.cursor()
        cur.execute('''select userid, name, userpasswd, address, pnumber, gender, doj from user where userid = %s''', (session['userid'],))
        data = cur.fetchone()
        return render_template('user_update_info.html', title = 'User_info', data = data)


# donate pets page
@flobj.route('/home/login/donate', methods = ['GET', 'POST'])
def donate():
    if 'userid' in session:
        form  = PetDonateForm()
        cur = mysql.connection.cursor()
        cur.execute('''select name from user where userid = %s''', (session['userid'],))
        name = cur.fetchone()
        name = "Welcome!! " + name[0]
        cur.execute('''select breedname from breed''')
        data = cur.fetchall()
        if form.validate_on_submit() and request.method == 'POST':
            if 'file' not in request.files:
                err_msg = 'Please choose the image file'
                return render_template('donate.html', title = 'Donate Page', data = data, name = name, form = form, msg = err_msg)


            f = request.files['file']


            if f.filename == '':
                err_msg = 'Please choose the image file'
                return render_template('donate.html', title = 'Donate Page', data = data, name = name, form = form, msg = err_msg)


            type = int(form.gender.data)
            sex = str(form.gender.choices[type-1][1])


            type1 = int(form.pettype.data)
            animal_type = str(form.pettype.choices[type1-1][1])


            cur.execute('''select max(petid) from pet''')
            maxpetid = cur.fetchone()
            if maxpetid[0] == None:
                petid = 1
            else:
                petid = int(maxpetid[0]) + 1


            cur.execute('''select max(vetid) from vet''')
            maxvetid = cur.fetchone()
            maxvetid = int(maxvetid[0])


            cur.execute('''select max(shelterid) from shelter''')
            maxshelterid = cur.fetchone()
            maxshelterid = int(maxshelterid[0])


            vetid = random.randint(1, maxvetid)
            shelterid = random.randint(1, maxshelterid)
            vetid = str(vetid)
            shelterid = str(shelterid)
            imgsrc = '/static/' + str(form.breedname.data) + '.jpg'
            cur.execute('''select breedname from breed where breedname = %s''', (str(form.breedname.data),))
            breeddata = cur.fetchone()


            if breeddata == None:
                err_msg = 'Entered breedname is not in the list'
                form.breedname.errors.append(err_msg)
                return render_template('donate.html', title = 'Donate Page', data = data, name = name, form = form)


            f.filename = str(form.breedname.data) + '.jpg'
            f.save(flobj.config['UPLOAD_FOLDER'] + f.filename)


            insert_query = '''insert into pet (petid, petname, pettype, gender, adopted_by, donated_by, vetid, breedname, shelterid, donation_date, adoption_date, imgsource, height, weight) values (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)'''


            cur.execute(insert_query, (petid, form.name.data, animal_type, sex, None, session['userid'], vetid, form.breedname.data, shelterid, form.date.data, None, imgsrc, form.height.data, form.weight.data))
            cur.connection.commit()
            return redirect(url_for('home'))


        return render_template('donate.html', title = 'Donate Page', data = data, name = name, form = form)


# adopt pet page
@flobj.route('/home/login/adopt', methods = ['GET', 'POST'])
def adopt():
    if 'userid' in session:
        cur = mysql.connection.cursor()
        cur.execute('''select name from user where userid = %s''', (session['userid'],))
        name = cur.fetchone()
        name = "Welcome!! " + name[0]
        form = SearchBar()
        cur.execute('''select petid, gender, breedname, imgsource from pet where adopted_by is null''')
        data = cur.fetchall()
        if form.validate_on_submit():
            cur.execute('''select petid, gender, breedname, imgsource from pet where adopted_by is null and breedname = %s''', (str(form.breedname.data),))
            data = cur.fetchall()


            if not data:
                err_msg = 'Please enter valid breedname'
                form.breedname.errors.append(err_msg)
                return render_template('adopt.html', title = 'Adopt', form = form, name = name)


            return render_template('adopt.html', title = 'Adopt', data = data, form = form, name = name)


        return render_template('adopt.html', title = 'Adopt', name = name, form = form, data = data)


# displays the pet information with petid = ptid
@flobj.route('/home/login/<string:ptid>', methods = ['GET', 'POST'])
def petinfo(ptid):
    if 'userid' in session:
        cur = mysql.connection.cursor()
        cur.execute('''select name from user where userid = %s''', (session['userid'],))
        name = cur.fetchone()
        name = "Welcome!! " + name[0]
        cur.execute('''select p.petid, p.petname, p.pettype, p.gender, p.donated_by, p.donation_date, p.imgsource, p.height, p.weight, b.breedname, b.breedcost, b.country_of_origin, v.name, v.address, v.pnumber, v.gender, s.sheltername, s.address, s.pnumber, u.name, u.address, u.pnumber, u.gender from pet p, breed b, vet v, shelter s, user u where p.donated_by = u.userid and p.breedname = b.breedname and p.vetid = v.vetid and p.shelterid = s.shelterid and p.petid = %s''', (ptid,))
        data = cur.fetchall()
        form = AdoptDate()
        cur.execute('''select adopted_by from pet where petid = %s''', (ptid,))
        uid = cur.fetchone()


        if uid[0]:
            msg = "This pet has been adopted successfully by " + uid[0]
            return render_template('petinfo_after_adoption.html', title = 'Pet Information', name = name, msg = msg, data = data)


        if form.validate_on_submit():
            cur.execute('''update pet set adoption_date = %s, adopted_by = %s where petid = %s''', (str(form.date.data), session['userid'], ptid))
            cur.connection.commit()
            msg = "This pet has been adopted successfully by " + session['userid']
            return render_template('petinfo_after_adoption.html', title = 'Pet Information', name = name, msg = msg, data = data)


        return render_template('petinfo_before_adoption.html', title = 'Pet Information', name = name, data = data, form = form)


# admin
@flobj.route('/home/login/iamadmin')
def iamadmin():
    if 'admin' in session:
        message = "You are currently logged in as admin"
        return render_template('iamadmin.html', title = 'iamadmin', message = message)
    else:
        redirect(url_for('login_admin'))


#adding new breed to the database
@flobj.route('/home/login/add_breed', methods = ['GET', 'POST'])
def add_breed():
    if 'admin' in session:
        name = "Welcome!! admin"
        form = AddBreed()
        if form.validate_on_submit():
            cur = mysql.connection.cursor()
            cur.execute('''insert into breed (breedname, breedcost, country_of_origin) values (%s, %s, %s)''', (form.breedname.data, form.breedcost.data, form.country_of_origin.data))
            cur.connection.commit()
            return redirect(url_for('home'))


        return render_template('add_breed.html', title = 'Add breed', form = form, name = name)


#adding new shelter to the database
@flobj.route('/home/login/add_shelter', methods = ['GET', 'POST'])
def add_shelter():
    if 'admin' in session:
        name = "Welcome!! admin"
        form = AddShelter()
        cur = mysql.connection.cursor()
        cur.execute('''select max(shelterid) from shelter''')
        maxid = cur.fetchone()


        if maxid[0] == None:
            shelterid = 1
        else:
            shelterid = int(maxid[0]) + 1


        if form.validate_on_submit():
            cur = mysql.connection.cursor()
            cur.execute('''insert into shelter (shelterid, sheltername, address, pnumber) values (%s, %s, %s, %s)''', (shelterid, form.name.data, form.address.data, form.pnumber.data))
            cur.connection.commit()
            return redirect(url_for('home'))


        return render_template('add_shelter.html', title = 'Add shelter', form = form, name = name)


#adding new vet to the database
@flobj.route('/home/login/add_vet', methods = ['GET', 'POST'])
def add_vet():
    if 'admin' in session:
        name = "Welcome!! admin"
        form = AddVet()
        cur = mysql.connection.cursor()
        cur.execute('''select max(vetid) from vet''')
        maxid = cur.fetchone()


        if maxid[0] == None:
            vetid = 1
        else:
            vetid = int(maxid[0]) + 1


        if form.validate_on_submit():
            type = int(form.gender.data)
            sex = str(form.gender.choices[type-1][1])
            cur = mysql.connection.cursor()
            cur.execute('''insert into vet (vetid, name, address, pnumber, gender) values (%s, %s, %s, %s, %s)''', (vetid, form.name.data, form.address.data, form.pnumber.data, sex))
            cur.connection.commit()
            return redirect(url_for('home'))


        return render_template('add_vet.html', title = 'Add vet', form = form, name = name)
