defmodule AOC.Day6.Test do
  use ExUnit.Case

  alias AOC.Day6.LanternfishModel

  describe "new/1" do
    test "returns a LanternfishModel with initial frequencies as state" do
      assert LanternfishModel.new([3, 4, 4, 1, 2]) == %LanternfishModel{
               frequencies: {0, 1, 1, 1, 2, 0, 0, 0, 0}
             }
    end
  end

  describe "next_state/1" do
    test "returns the next state of the model after 1 iteration" do
      model = LanternfishModel.new([3, 4, 4, 1, 2])

      assert LanternfishModel.next_state(model) == %LanternfishModel{
               frequencies: {1, 1, 1, 2, 0, 0, 0, 0, 0}
             }
    end

    test "returns the next state of the model after 2 iteration" do
      result =
        [3, 4, 4, 1, 2]
        |> LanternfishModel.new()
        |> LanternfishModel.next_state()
        |> LanternfishModel.next_state()

      assert result == %LanternfishModel{
               frequencies: {1, 1, 2, 0, 0, 0, 1, 0, 1}
             }
    end
  end

  describe "next_state/2" do
    test "returns the next state of the model after n iteration" do
      model =
        [3, 4, 4, 1, 2]
        |> LanternfishModel.new()

      result =
        model
        |> LanternfishModel.next_state()
        |> LanternfishModel.next_state()
        |> LanternfishModel.next_state()
        |> LanternfishModel.next_state()

      assert result == LanternfishModel.next_state(model, 4)
    end
  end

  describe "count_fishes/1" do
    test "returns the initial number of alive fishes" do
      model =
        [3, 4, 4, 1, 2]
        |> LanternfishModel.new()

      assert LanternfishModel.count_fishes(model) == 5
    end

    test "returns the number of alive fishes at the current state" do
      model =
        [3, 4, 4, 1, 2]
        |> LanternfishModel.new()
        |> LanternfishModel.next_state()
        |> LanternfishModel.next_state()

      assert LanternfishModel.count_fishes(model) == 6
    end
  end
end
