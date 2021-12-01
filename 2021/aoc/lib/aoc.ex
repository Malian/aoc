defmodule AOC do
  def parse_file(filepath) do
    File.stream!(filepath)
    |> Stream.map(&String.trim/1)
    |> Enum.map(&String.to_integer/1)
  end
end
