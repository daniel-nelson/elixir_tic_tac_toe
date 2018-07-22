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
end
