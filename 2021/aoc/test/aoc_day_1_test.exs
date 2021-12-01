defmodule AOC.Day1.Test do
  use ExUnit.Case

  alias AOC.Day1

  describe "count_measurements_that_are_larger_than_the_previous_one/1" do
    test "returns 0 if no measurements are larger than the previous one" do
      assert Day1.count_measurements_that_are_larger_than_the_previous_one([3, 2, 1]) == 0
    end

    test "returns 1 if only one measurement is larger than the previous one" do
      assert Day1.count_measurements_that_are_larger_than_the_previous_one([2, 1, 3]) == 1
    end

    test "does not count equal measurements" do
      assert Day1.count_measurements_that_are_larger_than_the_previous_one([1, 1, 1]) == 0
    end

    test "returns 7" do
      assert "../inputs/01/small_inputs.txt"
             |> AOC.parse_file()
             |> Day1.count_measurements_that_are_larger_than_the_previous_one() == 7
    end
  end

  describe "sum_measurements_by_chunk/1" do
    test "sums the measurements by chunck of 3 sliding by 1" do
      assert Day1.sum_measurements_by_chunk([1, 2, 3, 4, 5, 6]) == [6, 9, 12, 15]
    end
  end
end
