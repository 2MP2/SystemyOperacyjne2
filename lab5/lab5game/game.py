import tkinter as tk
from tkinter import messagebox
import time

# Inicjalizacja planszy
board = [[" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "]]
         

# Inicjalizacja gracza
current_player = "X"

move_start_time = 0

# Tworzenie okna
window = tk.Tk()
window.title("Kółko i krzyżyk")


# Funkcja oznaczająca wybrane pole
def mark_square(row, col):
    global current_player

    if board[row][col] == " ":
        board[row][col] = current_player
        button = buttons[row][col]
        button.config(text=current_player)

        if check_winner(current_player):
            messagebox.showinfo("Koniec gry", "Gracz {} wygrał!".format(current_player))
            new_board()
        else:
            if current_player == "X":
                current_player = "O"
            else:
                current_player = "X"


# Funkcja sprawdzająca warunki zwycięstwa
def check_winner(player):
    # Sprawdzenie wierszy
    for row in board:
        if row.count(player) == 5:
            return True

    # Sprawdzenie kolumn
    for col in range(5):
        if [board[row][col] for row in range(5)].count(player) == 5:
            return True

    # Sprawdzenie przekątnych
    if board[0][0] == board[1][1] == board[2][2] == board[3][3] == board[4][4] == player:
        return True
    if board[0][4] == board[1][3] == board[2][2] == board[3][1] == board[4][0] == player:
        return True

    return False

def check_time_limit():
    global move_start_time

    current_time = time.time()
    if current_time - move_start_time > 5:
        messagebox.showinfo("Czas minął", "Przekroczono limit czasu na wykonanie ruchu!")
        new_board()

    window.after(5000, check_time_limit)

# Funkcja resetująca grę
def new_board():
    global current_player
    board.clear()
    board.extend([[" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "],
         [" ", " ", " ", " ", " "]])
    current_player = "X"
    for row in range(5):
        for col in range(5):
            buttons[row][col].config(text=" ")


# Tworzenie przycisków na planszy
buttons = []
for row in range(5):
    button_row = []
    for col in range(5):
        button = tk.Button(window, text=" ", font=("Arial", 20), width=6, height=3,
                           command=lambda row=row, col=col: mark_square(row, col))
        button.grid(row=row, column=col, padx=5, pady=5)
        button_row.append(button)
    buttons.append(button_row)


check_time_limit()
# Uruchomienie pętli głównej
window.mainloop()
