import random
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
def mark_square(r, c):
    global current_player, move_start_time

    if board[r][c] == " ":
        board[r][c] = current_player
        btn = buttons[r][c]
        btn.config(text=current_player)

        if check_winner(current_player):
            messagebox.showinfo("Koniec gry", "Gracz {} wygrał!".format(current_player))
            new_board()
        else:
            if current_player == "X":
                current_player = "O"
            else:
                current_player = "X"

        move_start_time = time.time()
        window.after(100, check_time_limit)


def make_rand_move():
    while True:
        r = random.randint(0, 4)
        c = random.randint(0, 4)
        if board[r][c] == " ":
            mark_square(r, c)
            break


# Funkcja sprawdzająca warunki zwycięstwa
def check_winner(player):
    # Sprawdzenie wierszy
    for r in board:
        if r.count(player) == 5:
            return True

    # Sprawdzenie kolumn
    for c in range(5):
        if [board[r][c] for r in range(5)].count(player) == 5:
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
        make_rand_move()
    else:
        window.after(100, check_time_limit)


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
    for r in range(5):
        for c in range(5):
            buttons[r][c].config(text=" ")


# Tworzenie przycisków na planszy
buttons = []
for r in range(5):
    button_row = []
    for c in range(5):
        button = tk.Button(window, text=" ", font=("Arial", 20), width=6, height=3,
                           command=lambda row=r, col=c: mark_square(row, col))
        button.grid(row=r, column=c, padx=5, pady=5)
        button_row.append(button)
    buttons.append(button_row)


#check_time_limit()
# Uruchomienie pętli głównej
window.mainloop()
