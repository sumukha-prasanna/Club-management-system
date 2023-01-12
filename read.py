import pandas as pd
import streamlit as st
import plotly.express as px
from database import *


def read_user():
    result = view_user()
    st.write(result)

def read_club():
    result = view_club()
    st.write(result)

def read_event():
    result = view_event()
    st.write(result)

def read_account():
    result = view_account()
    st.write(result)