defmodule CheckWinner do
  def other_player('x'), do: 'o'
  def other_player('o'), do: 'x'

  def player_lost?(board, player) do
    player_won?(board, other_player(player))
  end

  def player_won?([[a, b, c], _, _], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([_, [a, b, c], _], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([_, _, [a, b, c]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([[a, _, _], [b, _, _], [c, _, _]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([[_, a, _], [_, b, _], [_, c, _]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([[_, _, a], [_, _, b], [_, _, c]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([[a, _, _], [_, b, _], [_, _, c]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?([[_, _, a], [_, b, _], [c, _, _]], player) when a == player and b == player and c == player do
    true
  end

  def player_won?(_, _) do
    false
  end
end