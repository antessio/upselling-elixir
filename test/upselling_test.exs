defmodule UpsellingTest do
  alias OwnedVehicleService.OwnedVehicle
  alias Upselling.Policy
  use ExUnit.Case
  doctest Upselling

  test "find potential upsells no owned vehicles" do

    result = Upselling.find_potential_upsell([
      %Policy{vehicle_id: "1", person_id: "2"}
    ], fn _ -> [] end)
    assert length(result) == 0

  end

  test "find potential upsells" do

    result = Upselling.find_potential_upsell([
      %Policy{vehicle_id: "V1", person_id: "P2"},
      %Policy{vehicle_id: "V2", person_id: "P2"},
      %Policy{vehicle_id: "V3", person_id: "P1"}
    ], fn _ -> [%OwnedVehicle{vehicle_id: "V5", person_id: "P1"}] end)
    assert length(result) == 1

  end

  test "finds potential upsel with empty policy list" do
    result = Upselling.find_potential_upsell([], fn _ -> [] end)

    assert length(result) == 0
  end


end
