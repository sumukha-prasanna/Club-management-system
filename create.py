import streamlit as st
from database import *




def create_user():
    col1, col2 = st.columns(2)
    with col1:
        User_id = st.text_input("User_id:")
        Fname = st.text_input("First Name:")
        Lname = st.text_input("Last Name:")
        Username = st.text_input("Username:")
        Password = st.text_input("Password:")
    with col2:
        User_ph = st.text_input("Phone number:")
        Email = st.text_input("Email:")
        Semester = st.text_input("Semester:")
    if st.button("Create"):
        add_user(User_id,Fname,Lname,User_ph,Email,Semester,Username,Password)
        st.success("Successfully added user: {}".format(Username))


def create_club():
    col1, col2 = st.columns(2)
    with col1:
        Club_id = st.text_input("Club ID:")
        Club_name = st.text_input("Club Name:")
        User_id = st.text_input("User ID:")
    if st.button("Create club"):
        add_club(Club_id,Club_name,User_id)
        st.success("Successfully created club: {}".format(Club_name))

def create_event():
    col1, col2 = st.columns(2)
    with col1:
        Event_id = st.text_input("Event id:")
        Event_name = st.text_input("Event Name:")
        Club_id = st.text_input("Club id:")
        Event_date = st.text_input("Date:")
        Time = st.text_input("Time:")
    with col2:
        Place = st.text_input("Place:")
        Description = st.text_input("Description:")
        Mem_applied = st.text_input("Members applied:")
    if st.button("Create"):
        add_event(Event_id,Event_name,Club_id,Event_date,Time,Place,Description,Mem_applied)
        st.success("Successfully added event: {}".format(Event_name))

def create_account():
    col1, col2 = st.columns(2)
    with col1:
        Acc_no = st.text_input("Account Number:")
        bal = st.text_input("Available_balance:")
        Club_id = st.text_input("Club ID:")
    if st.button("Create club"):
        add_account(Acc_no,bal,Club_id)
        st.success("Successfully created account: {}".format(Acc_no))


def edit_club():
    col1, col2 = st.columns(2)
    with col1:
        Club_id = st.text_input("Club ID:")
        Club_name=st.text_input("New club name:")
    if st.button("Change club name"):
        change_club(Club_id,Club_name)
        st.success("Successfully changed club name: {}".format(Club_name))


def delete_user():
    col1, col2 = st.columns(2)
    with col1:
        User_id = st.text_input("User_id:")
        Club_id = st.text_input("Club ID:")
    if st.button("Delete user from club"):
        delete_user_club(User_id,Club_id)
        st.success("Successfully deleted user from club: {}".format(User_id))

