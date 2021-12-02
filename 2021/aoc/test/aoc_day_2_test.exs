defmodule AOC.Day2.Test do
  use ExUnit.Case

  alias AOC.Day2

  describe "compute_position_of_submarine/1" do
    test "returns [0, 0] by default" do
      assert Day2.compute_position_of_submarine([]) == [0, 0]
    end

    test "moves the horizontal position of the submarine by 1 when given 'forward 1'" do
      assert Day2.compute_position_of_submarine([["forward", 1]]) == [1, 0]
    end

    test "increases the depth position of the submarine by 1 when given 'down 1'" do
      assert Day2.compute_position_of_submarine([["down", 1]]) == [0, 1]
    end

    test "decreases the depth position of the submarine by 1 when given 'up 1'" do
      assert Day2.compute_position_of_submarine([["up", 1], ["down", 1]]) == [0, 0]
    end
  end

  describe "compute_correct_position_of_submarine/1" do
    test "returns [0, 0, 0] by default" do
      assert Day2.compute_correct_position_of_submarine([]) == [0, 0, 0]
    end

    test "increases the aim by 1 when given 'down 1'" do
      assert Day2.compute_correct_position_of_submarine([["down", 1]]) == [0, 0, 1]
    end

    test "decreases the aim by 1 when given 'up 1'" do
      instructions = [
        ["down", 1],
        ["up", 1]
      ]

      assert Day2.compute_correct_position_of_submarine(instructions) == [0, 0, 0]
    end

    test "increases horizontal position by 2, and inscrease depth by 2 * aim" do
      instructions = [
        ["down", 1],
        ["down", 1],
        ["forward", 2]
      ]

      assert Day2.compute_correct_position_of_submarine(instructions) == [2, 4, 2]
    end
  end
end
