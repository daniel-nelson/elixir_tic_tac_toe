defmodule TicTacToe do
  import CheckWinner
  import MakeMove
  import DrawBoard

  @moduledoc """
  Documentation for TicTacToe.
  """

  @doc """
  Hello world.

  ## Examples

      iex> TicTacToe.hello
      :world

  """

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


  def play_game(game_data \\ %GameData{board: new_board()}) do
    game_data.board |> draw_board()

    cond do
      x_won?(game_data.board) -> IO.puts("X won!")
      o_won?(game_data.board) -> IO.puts("O won!")
      draw?(game_data.board) -> IO.puts("Draw")
      true ->
        {col, row} = if game_data.xs_turn do
          game_data |> get_move()
        else
          %{col: col, row: row, board: board} = game_data |> ai_move('o')
          {col, row}
        end

        case make_move(game_data, col, row) do
          {:ok, board} ->
            game_data
            |> Map.replace(:board, board)
            |> Map.replace(:xs_turn, !game_data.xs_turn)
            |> play_game()

          {:occupied, _} ->
            IO.puts "That’s occupied"
            game_data
            |> play_game()
        end
    end
  end

  def ai_move(game_data, my_piece, depth \\ 1) do
    game_data = game_data |> Map.replace(:xs_turn, xs_turn?(my_piece))

    moves = for col <- [1, 2, 3], row <- [1, 2, 3] do
      case make_move(game_data, col, row) do
        {:ok, board} ->
          cond do
            player_won?(board, my_piece) -> %{col: col, row: row, board: board, depth: depth}
            player_lost?(board, my_piece) -> %{col: col, row: row, board: board, depth: depth}
            draw?(board) -> %{col: col, row: row, board: board, depth: depth}
            true ->
              winner = ai_move(game_data |> Map.replace(:board, board), other_player(my_piece), depth + 1)

              if winner do
                %{col: col, row: row, board: winner.board, depth: winner.depth}
              else
                nil
              end
          end

        {:occupied, _} -> nil
      end
    end

    moves = moves
      |> Enum.filter(&(&1))
      |> Enum.filter(&(&1.board))
      |> Enum.sort(&(&1.depth <= &2.depth))

    # if depth == 1 do
    #   IO.puts("***************")
    #   IO.puts(my_piece)
    #   IO.inspect(moves)
    #   IO.puts("***************")
    # end

    Enum.find(moves, &(&1.board |> player_won?(my_piece))) ||
       Enum.find(moves |> Enum.reverse(), &(&1.board |> draw?())) ||
       Enum.find(moves |> Enum.reverse(), &(&1.board |> player_lost?(my_piece)))
  end

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
    # row1 ++ row2 ++ row3
    # |> Enum.member?(' ')
    # these are equivalent
    ' ' in (row1 ++ row2 ++ row3)
  end

  defp get_move(game_data) do
    move = if game_data.xs_turn do
      IO.gets "X’s turn\n"
    else
      IO.gets "O’s turn\n"
    end

    [col | ["," | [row | _]]] = String.codepoints(move)
    # <<col>> = col
    # <<row>> = row
    {String.to_integer(col), String.to_integer(row)}
  end

  defp new_board do
    [
      [' ', ' ', ' '],
      [' ', ' ', ' '],
      [' ', ' ', ' '],
    ]
  end

  defp make_move(game_data, col, row) do
    if game_data.xs_turn do
      x_moves(game_data.board, col, row)
    else
      o_moves(game_data.board, col, row)
    end
  end

  defp xs_turn?('x'), do: true
  defp xs_turn?('o'), do: false
end
