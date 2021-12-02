defmodule AOC.Day2 do
  def compute_position_of_submarine(instructions) do
    Enum.reduce(instructions, [0, 0], fn [action, value], [horizontal, depth] ->
      case action do
        "forward" -> [horizontal + value, depth]
        "down" -> [horizontal, depth + value]
        "up" -> [horizontal, depth - value]
      end
    end)
  end

  def compute_correct_position_of_submarine(instructions) do
    Enum.reduce(instructions, [0, 0, 0], fn [action, value], [horizontal, depth, aim] ->
      case action do
        "forward" -> [horizontal + value, depth + aim * value, aim]
        "down" -> [horizontal, depth, aim + value]
        "up" -> [horizontal, depth, aim - value]
      end
    end)
  end

  # Convenience functions for AOC
  @inputs "../inputs/02/inputs.txt"
          |> File.stream!()
          |> Stream.map(&String.trim/1)
          |> Enum.map(&String.split(&1, " "))
          |> Enum.map(fn [action, value] -> [action, String.to_integer(value)] end)

  def part1 do
    @inputs
    |> compute_position_of_submarine()
    |> Enum.product()
    |> IO.inspect(label: "Answer")
  end

  def part2 do
    @inputs
    |> compute_correct_position_of_submarine()
    |> then(fn [horizontal, depth, _] -> horizontal * depth end)
    |> IO.inspect(label: "Answer")
  end
end
