defmodule TicTacToeTest do
  use ExUnit.Case
  # doctest TicTacToe

  describe "TicTacToe.draw?/1" do
    test "is true when no empty cells and neither x nor o won" do
      board = [
        ['x', 'o', 'x'],
        ['o', 'x', 'o'],
        ['o', 'x', 'o'],
      ]
      assert TicTacToe.draw?(board) == true
    end

    test "is false when x won" do
      board = [
        ['x', 'o', 'x'],
        ['o', 'x', 'o'],
        ['o', 'x', 'x'],
      ]
      assert TicTacToe.draw?(board) == false
    end

    test "is false when o won" do
      board = [
        ['x', 'o', 'x'],
        ['o', 'x', 'x'],
        ['o', 'o', 'o'],
      ]
      assert TicTacToe.draw?(board) == false
    end

    test "is false when an empty cell" do
      board = [
        ['x', 'o', 'x'],
        ['o', 'x', ' '],
        ['o', 'x', 'o'],
      ]
      assert TicTacToe.draw?(board) == false
    end
  end

  describe "TicTacToe.x_won?/1" do
    test "is true with Xs across the top" do
      board = [
        ['x', 'x', 'x'],
        [' ', ' ', ' '],
        [' ', ' ', ' '],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with Xs across the middle" do
      board = [
        [' ', ' ', ' '],
        ['x', 'x', 'x'],
        [' ', ' ', ' '],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with Xs across the bottom" do
      board = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        ['x', 'x', 'x'],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with Xs down the left side" do
      board = [
        ['x', ' ', ' '],
        ['x', ' ', ' '],
        ['x', ' ', ' '],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with Xs down the middle" do
      board = [
        [' ', 'x', ' '],
        [' ', 'x', ' '],
        [' ', 'x', ' '],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with Xs down the right side" do
      board = [
        [' ', ' ', 'x'],
        [' ', ' ', 'x'],
        [' ', ' ', 'x'],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with diagonal Xs left-top to right-bottom" do
      board = [
        ['x', ' ', ' '],
        [' ', 'x', ' '],
        [' ', ' ', 'x'],
      ]
      assert TicTacToe.x_won?(board) == true
    end

    test "is true with diagonal Xs left-bottom to right-top" do
      board = [
        [' ', ' ', 'x'],
        [' ', 'x', ' '],
        ['x', ' ', ' '],
      ]
      assert TicTacToe.x_won?(board) == true
    end
  end

  describe "TicTacToe.x_moves/3 into an empty spot" do
    test "into 2, 1 places an x into that spot" do
      board = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' '],
      ]

      expected = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', 'x', ' '],
      ]
      assert TicTacToe.x_moves(board, 2, 1) == {:ok, expected}
    end

    test "into 3, 2 places an x into that spot" do
      board = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', ' ', ' '],
      ]

      expected = [
        [' ', ' ', ' '],
        [' ', ' ', 'x'],
        [' ', ' ', ' '],
      ]
      assert TicTacToe.x_moves(board, 3, 2) == {:ok, expected}
    end
  end

  describe "TicTacToe.x_moves/3 into a non-empty spot" do
    test "leaves the spot as it was" do
      board = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', 'o', ' '],
      ]

      expected = [
        [' ', ' ', ' '],
        [' ', ' ', ' '],
        [' ', 'o', ' '],
      ]
      assert TicTacToe.x_moves(board, 2, 1) == {:occupied, expected}
    end
  end

  describe "TicTacToe.ai_move/2 with one open space remaining when that space is a winning space" do
    test "returns the coordinates of the empty space, with :win and 1 (move)" do
      game_data = %GameData{board:
        [
          ['x', 'o', 'o'],
          ['x', 'x', ' '],
          ['o', 'x', 'o'],
        ]
      }

      expected = [
        ['x', 'o', 'o'],
        ['x', 'x', 'x'],
        ['o', 'x', 'o'],
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 3, row: 2, board: expected, depth: 1}
    end
  end

  describe "TicTacToe.ai_move/2 with one open space remaining when that space is a draw space" do
    test "returns the coordinates of the empty space, with :draw and 1 (move)" do
      game_data = %GameData{board:
        [
          ['x', 'o', ' '],
          ['x', 'x', 'o'],
          ['o', 'x', 'o'],
        ]
      }

      expected = [
        ['x', 'o', 'x'],
        ['x', 'x', 'o'],
        ['o', 'x', 'o'],
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 3, row: 3, board: expected, depth: 1}
    end
  end

  describe "TicTacToe.ai_move/2 with two open spaces remaining when one space is a winning space" do
    test "returns the coordinates of the winning space" do
      game_data = %GameData{board:
        [
          ['o', 'x', 'o'],
          ['x', 'x', ' '],
          ['o', 'o', ' '],
        ]
      }

      expected = [
        ['o', 'x', 'o'],
        ['x', 'x', 'x'],
        ['o', 'o', ' '],
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 3, row: 2, board: expected, depth: 1}
    end
  end

  describe "TicTacToe.ai_move/2 when the opponent will win in one move" do
    test "returns the coordinates of a blocking move" do
      game_data = %GameData{board:
        [
          [' ', 'o', 'o'],
          [' ', ' ', ' '],
          [' ', 'x', ' '],
        ]
      }

      expected = [
        ['x', 'o', 'o'],
        ['o', 'o', 'x'],
        ['x', 'x', 'o']
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 1, row: 3, board: expected, depth: 6}
    end
  end

  describe "TicTacToe.ai_move/2 when the opponent will win with 3, 1" do
    test "returns the coordinates of a blocking move" do
      game_data = %GameData{board:
        [
          ['o', ' ', ' '],
          ['x', 'o', ' '],
          [' ', ' ', ' '],
        ]
      }

      expected = [
        ['o', 'o', 'x'],
        ['x', 'o', ' '],
        [' ', 'o', 'x']
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 3, row: 1, board: expected, depth: 4}
    end
  end

  describe "TicTacToe.ai_move/2 when the opponent has checkmate" do
    test "returns the coordinates of any open space, with :lose, and 2 (moves until loss)" do
      game_data = %GameData{board:
        [
          ['o', ' ', 'o'],
          [' ', 'x', ' '],
          ['o', ' ', 'x'],
        ]
      }

      expected = [
        ['o', ' ', 'o'],
        ['o', 'x', 'x'],
        ['o', ' ', 'x'],
      ]
      assert TicTacToe.ai_move(game_data, 'x') == %{col: 3, row: 2, board: expected, depth: 2}
    end
  end

  describe "TicTacToe.ai_move/2 when the opponent has moved first in a corner" do
    test "returns the coordinates of any the opposite corner, with :draw" do
      game_data = %GameData{board:
        [
          [' ', ' ', ' '],
          [' ', ' ', ' '],
          ['x', ' ', ' '],
        ]
      }

      expected = [
        ['o', 'x', 'x'],
        ['x', 'o', 'o'],
        ['x', 'o', 'x']
      ]
      assert TicTacToe.ai_move(game_data, 'o') == %{col: 2, row: 2, board: expected, depth: 8}
    end
  end
end
