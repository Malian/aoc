defmodule AOC.Day6 do
  defmodule LanternfishModel do
    @enforce_keys :frequencies
    defstruct [:frequencies]

    def new(initial_age_of_fishes) do
      initial_states = List.to_tuple(List.duplicate(0, 9))

      initial_frequencies =
        initial_age_of_fishes
        |> Enum.frequencies()
        |> Enum.reduce(initial_states, fn {state, count}, states ->
          put_elem(states, state, count)
        end)

      %LanternfishModel{frequencies: initial_frequencies}
    end

    def next_state(%LanternfishModel{frequencies: frequencies} = model, n \\ 1) do
      new_state =
        Enum.reduce((n - 1)..0, frequencies, fn _day, frequencies ->
          {s0, s1, s2, s3, s4, s5, s6, s7, s8} = frequencies
          {s1, s2, s3, s4, s5, s6, s7 + s0, s8, s0}
        end)

      %{model | frequencies: new_state}
    end

    def count_fishes(%LanternfishModel{frequencies: frequencies}) do
      Tuple.sum(frequencies)
    end
  end

  def part1 do
    "../inputs/06/inputs.txt"
    |> File.read!()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> LanternfishModel.new()
    |> LanternfishModel.next_state(80)
    |> LanternfishModel.count_fishes()
  end

  def part2 do
    "../inputs/06/inputs.txt"
    |> File.read!()
    |> String.split(",", trim: true)
    |> Enum.map(&String.to_integer/1)
    |> LanternfishModel.new()
    |> LanternfishModel.next_state(256)
    |> LanternfishModel.count_fishes()
  end
end
