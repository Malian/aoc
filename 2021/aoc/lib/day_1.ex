defmodule AOC.Day1 do
  def count_measurements_that_are_larger_than_the_previous_one(measurements, opts \\ []) do
    chunk = opts[:chunk] || 1

    measurements
    |> Enum.chunk_every(chunk, 1, :discard)
    |> Enum.map(&Enum.sum/1)
    |> Enum.chunk_every(2, 1, :discard)
    |> Enum.count(fn [a, b] -> b > a end)
  end
end
