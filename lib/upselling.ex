defmodule Upselling do
alias OwnedVehicleService.OwnedVehicle


  defmodule Policy do
    @enforce_keys [:person_id, :vehicle_id]
    defstruct [:person_id, :vehicle_id]
  end

  defmodule UpsellingOpportunity do

    @enforce_keys [:person_id, :vehicle_id]
    defstruct [:person_id, :vehicle_id]
  end

  @type policies() :: list(Policy)
  @type potential_upsells() :: list(UpsellingOpportunity)
  @type owned_vehicle_services :: (list(String) -> list(OwnedVehicle))
  @spec find_potential_upsell(policies(), OwnedVehicleService) :: potential_upsells()
  def find_potential_upsell(policies, owned_vehicle_service) when length(policies) > 0 do

    person_vehicle_map = Enum.group_by(policies, fn p -> p.person_id end, fn p -> p.vehicle_id end)
    owned_vehicles = owned_vehicle_service.(Map.keys(person_vehicle_map))

    owned_vehicles
    |> Stream.filter(& &1.vehicle_id not in person_vehicle_map[&1.person_id])
    |> Stream.map(& convert_to_upselling_opportunity(&1))
    |> Enum.to_list()
  end

  def find_potential_upsell(policies, _) when length(policies) == 0 do
    []
  end

  def convert_to_upselling_opportunity(policy) do
    %UpsellingOpportunity{person_id: policy.person_id, vehicle_id: policy.vehicle_id}
  end

  def hello do
    :world
  end
end
