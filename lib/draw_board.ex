defmodule DrawBoard do
  def draw_board([]) do
  end

  def draw_board([row | tail]) do
    draw_row(row)
    unless Enum.empty?(tail) do draw_row_divider() end
    draw_board(tail)
  end

  def draw_row_divider do
    IO.puts("———————————")
  end

  def draw_row(row) do
    draw_col(row)
    IO.write "\n"
  end

  def draw_col([]) do
  end

  def draw_col([col | tail]) do
    IO.write " #{col}"
    unless Enum.empty?(tail) do IO.write " |" end
    draw_col(tail)
  end
end