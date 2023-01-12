import mysql.connector

mydb = mysql.connector.connect(
    host="localhost",
    user="root",
    database="clubs"
)
c = mydb.cursor()


def add_user(User_id,Fname,Lname,User_ph,Email,Semester,Username,Password):
    c.execute('INSERT INTO login VALUES (%s,%s,%s)',(User_id,Username,Password))
    mydb.commit()
    c.execute('INSERT INTO users VALUES (%s,%s,%s,%s,%s,%s)',(User_id,Fname,Lname,User_ph,Email,Semester))
    mydb.commit()

def add_club(Club_id,Club_name,User_id):
    c.execute('INSERT INTO club values (%s,%s)',(Club_id,Club_name))
    mydb.commit()
    c.execute('Insert into user_clubs values(%s,%s)',(User_id,Club_id))
    mydb.commit()
    c.execute('insert into club_heads values(%s,%s)',(Club_id,User_id))
    mydb.commit()

def add_event(Event_id,Event_name,Club_id,Event_date,Time,Place,Description,Mem_applied):
    c.execute('insert into club_events values(%s,%s,%s,%s,%s,%s,%s,%s',(Event_id,Event_name,Club_id,Event_date,Time,Place,Description,Mem_applied))
    mydb.commit()

def add_account(Acc_no,bal,Club_id):
    c.execute('insert into accounts values(%s,%s)',(Acc_no,bal,Club_id))
    mydb.commit()


def view_user():
    c.execute('SELECT * FROM users')
    data = c.fetchall()
    return data

def view_club():
    c.execute('SELECT * FROM club')
    data = c.fetchall()
    return data

def view_event():
    c.execute('SELECT * FROM club_events')
    data = c.fetchall()
    return data

def view_account():
    c.execute('SELECT * FROM accounts')
    data = c.fetchall()
    return data

def change_club(Club_id,Club_name):
    c.execute('update club set Club_name=%s where Club_id=%s',(Club_name,Club_id))
    mydb.commit()

def delete_user_club(User_id,Club_id):
    c.execute('delete from user_clubs where User_id=%s and Club_id=%s',(User_id,Club_id))
    mydb.commit()

