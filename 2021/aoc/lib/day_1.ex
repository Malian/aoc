defmodule AOC.Day1 do
  def count_measurements_that_are_larger_than_the_previous_one(measurements, opts \\ []) do
    chunk = opts[:chunk] || 1

    measurements
    |> Enum.chunk_every(chunk, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end

  # Convenience functions for AOC
  @inputs AOC.parse_file("../inputs/01/inputs.txt")

  def part1 do
    @inputs
    |> count_measurements_that_are_larger_than_the_previous_one()
    |> IO.inspect(label: "Answer")
  end

  def part2 do
    @inputs
    |> count_measurements_that_are_larger_than_the_previous_one(chunk: 3)
    |> IO.inspect(label: "Answer")
  end
end
