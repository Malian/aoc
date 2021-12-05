defmodule AOC.Day5 do
  defmodule HydrothermalVent do
    def parse_input(input) do
      input
      |> String.split("\n", trim: true)
      |> Enum.map(fn line ->
        line
        |> String.split([",", "->"], trim: true)
        |> Enum.map(fn value -> String.trim(value) |> String.to_integer() end)
        |> Enum.chunk_every(2)
        |> Enum.map(&List.to_tuple/1)
      end)
    end

    def expand_lines(coordinates), do: Enum.map(coordinates, &expand_line/1)
    defp expand_line([{x, y1}, {x, y2}]), do: for(y <- y1..y2, do: {x, y})
    defp expand_line([{x1, y}, {x2, y}]), do: for(x <- x1..x2, do: {x, y})
    defp expand_line([{x1, y1}, {x2, y2}]), do: Enum.zip(x1..x2, y1..y2)

    def filter_vertical_and_horizontal_lines(coordinates) do
      Enum.filter(coordinates, fn [{x1, y1}, {x2, y2}] -> x1 == x2 or y1 == y2 end)
    end

    def diagram([h | _] = coordinates, dim) when is_list(h) do
      coordinates
      |> List.flatten()
      |> diagram(dim)
    end

    def diagram(coordinates, dim) do
      frequencies =
        coordinates
        |> Enum.frequencies()

      diagram =
        for y <- 0..(dim - 1) do
          for x <- 0..(dim - 1) do
            Map.get(frequencies, {x, y}, 0)
          end
        end

      {diagram, frequencies}
    end

    def count_overlaps(frequencies) do
      Enum.count(frequencies, fn {_, count} -> count > 1 end)
    end
  end

  defmodule Drawer do
    def draw(diagram) do
      diagram
      |> Enum.map(fn row ->
        Enum.map(row, fn
          0 -> "."
          v -> v
        end)
        |> Enum.join("")
      end)
      |> Enum.join("\n")
      |> IO.puts()
    end
  end

  def part1 do
    coordinates =
      "../inputs/05/inputs.txt"
      |> File.read!()
      |> HydrothermalVent.parse_input()

    dim = length(coordinates)

    coordinates
    |> HydrothermalVent.filter_vertical_and_horizontal_lines()
    |> HydrothermalVent.expand_lines()
    |> HydrothermalVent.diagram(dim)
    |> tap(fn {diagram, _frequencies} -> if dim < 20, do: Drawer.draw(diagram) end)
    |> then(fn {_diagram, frequencies} -> frequencies end)
    |> HydrothermalVent.count_overlaps()
  end

  def part2 do
    coordinates =
      "../inputs/05/inputs.txt"
      |> File.read!()
      |> HydrothermalVent.parse_input()

    dim = length(coordinates)

    coordinates
    |> HydrothermalVent.expand_lines()
    |> HydrothermalVent.diagram(10)
    |> tap(fn {diagram, _frequencies} -> if dim < 20, do: Drawer.draw(diagram) end)
    |> then(fn {_diagram, frequencies} -> frequencies end)
    |> HydrothermalVent.count_overlaps()
  end
end
