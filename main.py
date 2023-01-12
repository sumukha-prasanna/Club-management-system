import streamlit as st
import mysql.connector


from create import *
from database import *
from read import *



def main():
    st.title("Student Club")
    menu = ["Add", "View", "Edit", "Remove"]
    choice = st.sidebar.selectbox("Menu", menu)
    if choice == "Add":
        add = ["Add a user", "Add a club", "Add an event", "Add an account"]
        choice1 = st.sidebar.selectbox("Add",add )
        if choice1 == "Add a user":
            st.subheader("Add user")
            create_user()
        elif choice1=="Add a club":
            st.subheader("Add club")
            create_club()
        elif choice1=="Add an event":
            st.subheader("Add event")
            create_event()
        else:
            st.subheader("Add account")
            create_account()

    elif choice == "View":
        event = ["View users", "View clubs", "View events", "View accounts"]
        choice2 = st.sidebar.selectbox("View",event )
        if choice2 == "View users":
            st.subheader("View user")
            read_user()
        elif choice2=="View clubs":
            st.subheader("View club")
            read_club()
        elif choice2=="View events":
            st.subheader("View event")
            read_event()
        else:
            st.subheader("View account")
            read_account()

    elif choice == "Edit":
        st.subheader("Change club name:")
        edit_club()

    elif choice == "Remove":
        st.subheader("Delete user from club")
        delete_user()

if __name__ == '__main__':
    main()
