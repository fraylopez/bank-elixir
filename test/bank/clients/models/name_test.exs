defmodule Bank.Clients.Models.NameTest do
  use ExUnit.Case
  alias Bank.Clients.Models.Name

  test "validates name" do
    assert Name.new("John", "Doe") == %Name{first_name: "John", last_name: "Doe"}
  end

  test "validates name with middle name" do
    assert Name.new("John", "Doe", "M") ==
             %Name{first_name: "John", last_name: "Doe", middle_name: "M"}
  end

  test "invalidates empty name" do
    assert Name.new("", "Doe") == {:error, :first_name_is_required}
  end
end
