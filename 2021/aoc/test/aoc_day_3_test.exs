defmodule AOC.Day3.Test do
  use ExUnit.Case

  alias AOC.Day3

  @sample """
          00100
          11110
          10110
          10111
          10101
          01111
          00111
          11100
          10000
          11001
          00010
          01010
          """
          |> String.split("\n", trim: true)

  describe "compute_power_consumption/1" do
    assert Day3.compute_power_consumption(@sample) == 198
  end

  describe "compute_gamma_rate/1" do
    test "returns the bit if there is only one" do
      assert Day3.compute_gamma_rate(["1"]) == "1"
      assert Day3.compute_gamma_rate(["0"]) == "0"
    end

    test "returns the most common bit in the first bit position" do
      assert Day3.compute_gamma_rate(["1", "0", "1"]) == "1"
      assert Day3.compute_gamma_rate(["0", "0", "1"]) == "0"
    end

    test "returns the most common bit in all position" do
      expected = [
        "1010",
        "0011",
        "1010"
      ]

      assert Day3.compute_gamma_rate(expected) == "1010"
    end

    test "parses sample correctly" do
      assert Day3.compute_gamma_rate(@sample) == "10110"
    end
  end

  describe "compute_epsilon_rate/1" do
    test "returns the least common bit in all position" do
      expected = [
        "1010",
        "0011",
        "1010"
      ]

      assert Day3.compute_epsilon_rate(expected) == "0101"
    end

    test "parses sample correctly" do
      assert Day3.compute_epsilon_rate(@sample) == "01001"
    end
  end

  describe "compute_oxygen_generator_rate/1" do
    test "returns the number if only one number" do
      assert Day3.compute_oxygen_generator_rate(["1011"]) == "1011"
    end

    test "returns 1 if 0 and 1 are equally common" do
      assert Day3.compute_oxygen_generator_rate(["1", "0"]) == "1"
    end

    test "parses sample correctly" do
      assert Day3.compute_oxygen_generator_rate(@sample) == "10111"
    end
  end

  describe "compute_co2_scrubber_rate/1" do
    test "parses sample correctly" do
      assert Day3.compute_co2_scrubber_rate(@sample) == "01010"
    end
  end

  describe "compute_life_support_rating/1" do
    assert Day3.compute_life_support_rating(@sample) == 230
  end
end
