defmodule AOC.Day5.Test do
  use ExUnit.Case

  alias AOC.Day5.HydrothermalVent
  alias AOC.Day5.Drawer

  @sample """
  0,9 -> 5,9
  8,0 -> 0,8
  9,4 -> 3,4
  2,2 -> 2,1
  7,0 -> 7,4
  6,4 -> 2,0
  0,9 -> 2,9
  3,4 -> 1,4
  0,0 -> 8,8
  5,5 -> 8,2
  """

  describe "parse_input/1" do
    test "transforms the input into a list of couple of coordinates" do
      assert HydrothermalVent.parse_input("""
             0,9 -> 5,9
             2,1 -> 2,2
             """) == [
               [{0, 9}, {5, 9}],
               [{2, 1}, {2, 2}]
             ]
    end
  end

  describe "filter_vertical_and_horizontal_lines/1" do
    test "filters out the vertical and horizontal lines" do
      assert HydrothermalVent.filter_vertical_and_horizontal_lines([
               [{0, 9}, {5, 9}],
               [{2, 1}, {2, 2}],
               [{1, 2}, {3, 4}]
             ]) == [
               [{0, 9}, {5, 9}],
               [{2, 1}, {2, 2}]
             ]
    end
  end

  describe "expand_lines/1" do
    test "expands horizontal lines (x1 == x2)" do
      assert HydrothermalVent.expand_lines([[{1, 1}, {1, 3}]]) == [[{1, 1}, {1, 2}, {1, 3}]]
    end

    test "expands vartical lines (y1 == y2)" do
      assert HydrothermalVent.expand_lines([[{9, 7}, {7, 7}]]) == [[{9, 7}, {8, 7}, {7, 7}]]
    end
  end

  describe "diagram/2" do
    test "computes the diagram and the frequencies" do
      coordinates = [
        [{0, 2}, {2, 2}],
        [{1, 0}, {1, 2}]
      ]

      {diagram, frequencies} =
        coordinates
        |> HydrothermalVent.expand_lines()
        |> HydrothermalVent.diagram(3)

      assert frequencies == %{{0, 2} => 1, {1, 2} => 2, {2, 2} => 1, {1, 0} => 1, {1, 1} => 1}

      assert diagram == [
               [0, 1, 0],
               [0, 1, 0],
               [1, 2, 1]
             ]
    end
  end

  describe "count_overlaps/1" do
    test "conts the overlaps" do
      coordinates = [
        [{0, 2}, {2, 2}],
        [{1, 0}, {1, 2}]
      ]

      {_diagram, frequencies} =
        coordinates
        |> HydrothermalVent.expand_lines()
        |> HydrothermalVent.diagram(3)

      assert HydrothermalVent.count_overlaps(frequencies) == 1
    end
  end

  test "solves the sample" do
    assert HydrothermalVent.parse_input(@sample)
           |> HydrothermalVent.filter_vertical_and_horizontal_lines()
           |> HydrothermalVent.expand_lines()
           |> HydrothermalVent.diagram(10)
           |> then(fn {_diagram, frequencies} -> frequencies end)
           |> HydrothermalVent.count_overlaps() ==
             5
  end
end
