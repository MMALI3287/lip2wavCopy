import tkinter as tk
from tkinter import filedialog

def select_folder_dialog():
    root = tk.Tk()
    root.withdraw()  # Hide the main tkinter window
    
    folder_selected = filedialog.askdirectory()
    root.destroy()  # Destroy the tkinter window after selection
    
    return folder_selected