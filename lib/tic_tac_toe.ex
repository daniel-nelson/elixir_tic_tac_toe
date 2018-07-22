defmodule TicTacToe do
  import CheckWinner
  import MakeMove

  @moduledoc """
  Documentation for TicTacToe.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TicTacToe.hello
      :world

  """
  def new_board do
    [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' '],
    ]
  end

#    |   |
# ———————————
#    |   |
# ———————————
#    |   |

# X's turn
# 1,1

#    |   |
# ———————————
#    |   |
# ———————————
#  x |   |

#  O's turn
#  2,1

#    |   |
# ———————————
#    |   |
# ———————————
#  x | o |

#   def play_game do
#     board = new_board
#     xs_turn = true

#     loop_until x_won?(board) or o_won?(board) or draw?(board)
#       draw board
#       put whose turn
#       ask for move
#       {response, board} = x_moves || o_moves depending on xs_turn
#       if response == :ok do
#         xs_turn = !xs_turn
#       else
#         IO.puts "That's occupied"
#       end
#     end

#     if x_won?(board) do
#       IO.puts("X won!")
#     else if o_won?(board) do
#       IO.puts("O won!")
#     else if draw?(board) do
#       IO.puts("Draw")
#     end

#   end

  def x_moves(board, col, row) do
    board |> player_moves('x', col, row)
  end

  def o_moves(board, col, row) do
    board |> player_moves('o', col, row)
  end

  def draw?(board) do
    !empty_space?(board) and !x_won?(board) and !o_won?(board)
  end

  def x_won?(board) do
    board |> player_won?('x')
  end

  def o_won?(board) do
    board |> player_won?('o')
  end

  defp empty_space?([row1, row2, row3]) do
    row1 ++ row2 ++ row3
    |> Enum.member?(' ')
  end
end
