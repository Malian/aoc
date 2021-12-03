defmodule AOC.Day3 do
  def compute_power_consumption(binary_numbers) do
    gamma_rate =
      binary_numbers
      |> compute_gamma_rate()
      |> convert_binary_to_integer()

    epsilon_rate =
      binary_numbers
      |> compute_epsilon_rate()
      |> convert_binary_to_integer()

    gamma_rate * epsilon_rate
  end

  def compute_gamma_rate(binary_numbers) do
    binary_numbers
    |> Enum.map(&String.split(&1, "", trim: true))
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
    |> Enum.map(&Enum.frequencies/1)
    |> Enum.map(&Enum.max_by(&1, fn {_, v} -> v end))
    |> Enum.map_join(fn {bit, _} -> bit end)
  end

  def compute_epsilon_rate(binary_numbers) do
    binary_numbers
    |> compute_gamma_rate()
    |> flip_binary_number()
  end

  def compute_life_support_rating(binary_numbers) do
    oxygen_generator_rate =
      binary_numbers
      |> compute_oxygen_generator_rate()
      |> convert_binary_to_integer()

    co2_scrubber_rate =
      binary_numbers
      |> compute_co2_scrubber_rate()
      |> convert_binary_to_integer()

    oxygen_generator_rate * co2_scrubber_rate
  end

  def compute_oxygen_generator_rate(binary_numbers) do
    compute_recursive_rate(binary_numbers, &frequencies_filter(&1, :oxygen))
  end

  def compute_co2_scrubber_rate(binary_numbers) do
    compute_recursive_rate(binary_numbers, &frequencies_filter(&1, :co2))
  end

  # Privates
  defp compute_recursive_rate(binary_number, decision, pos \\ 0)

  defp compute_recursive_rate([binary_number], _decision, _pos), do: binary_number

  defp compute_recursive_rate(binary_numbers, decision, pos) do
    bit =
      binary_numbers
      |> Enum.map(&String.at(&1, pos))
      |> Enum.frequencies()
      |> then(decision)

    binary_numbers
    |> Enum.filter(fn <<_h::binary-size(pos)>> <> <<b::binary-size(1)>> <> _rest -> b == bit end)
    |> compute_recursive_rate(decision, pos + 1)
  end

  defp frequencies_filter(frequencies, :oxygen) do
    case frequencies do
      %{"0" => same, "1" => same} -> "1"
      %{"0" => zeros, "1" => ones} -> if zeros > ones, do: "0", else: "1"
      %{"0" => _zeros} -> "0"
      %{"1" => _ones} -> "1"
    end
  end

  defp frequencies_filter(frequencies, :co2) do
    frequencies
    |> frequencies_filter(:oxygen)
    |> flip_binary_number()
  end

  defp flip_binary_number("0"), do: "1"
  defp flip_binary_number("1"), do: "0"

  defp flip_binary_number(binary_number) do
    binary_number
    |> String.split("", trim: true)
    |> Enum.map_join(&flip_binary_number/1)
  end

  defp convert_binary_to_integer(binary) do
    {int, ""} = Integer.parse(binary, 2)
    int
  end

  # Convenience functions for AOC
  @inputs "../inputs/03/inputs.txt"
          |> File.read!()
          |> String.split("\n", trim: true)
          |> Enum.map(&String.trim/1)

  def part1 do
    @inputs
    |> compute_power_consumption()
    |> IO.inspect(label: "Answer")
  end

  def part2 do
    @inputs
    |> compute_life_support_rating()
    |> IO.inspect(label: "Answer")
  end
end
