defprotocol OwnedVehicleService do

  defmodule OwnedVehicle do
    @enforce_keys [:person_id, :vehicle_id]
    defstruct [:person_id, :vehicle_id]
  end

  @type person_ids() :: list(String.t())
  @type owned_vehicles_list() :: list(OwnedVehicle)
  @spec get_owned_vehicles(person_ids()) :: owned_vehicles_list()
  def get_owned_vehicles(personIds)

end
