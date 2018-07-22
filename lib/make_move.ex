defmodule MakeMove do
  def player_moves(board, player, col, row) do
    row_index = 3 - row
    col_index = col - 1

    the_row = Enum.fetch!(board, row_index)

    if Enum.fetch!(the_row, col_index) == ' ' do
      updated_row = List.replace_at(the_row, col_index, player)
      {:ok, List.replace_at(board, row_index, updated_row)}
    else
      {:occupied, board}
    end
  end
end