defmodule AOC.Day1 do
  def count_measurements_that_are_larger_than_the_previous_one(measurements)
      when is_list(measurements) do
    [first | rest] = measurements

    {count, _} =
      Enum.reduce(rest, {0, first}, fn depth, {count, previous} ->
        cond do
          depth > previous -> {count + 1, depth}
          depth < previous -> {count, depth}
          true -> {count, depth}
        end
      end)

    count
  end

  def sum_measurements_by_chunk(measurements) when is_list(measurements) do
    measurements
    |> Enum.chunk_every(3, 1, :discard)
    |> Enum.map(fn [a, b, c] -> a + b + c end)
  end
end
