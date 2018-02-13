defmodule ParkingPrototype.Parking.Spot do
  use Ecto.Schema
  import Ecto.Changeset
  alias ParkingPrototype.Parking.Spot


  schema "parking_spots" do
    field :available, :boolean, default: false
    field :name, :string
    belongs_to :area, ParkingPrototype.Parking.Area

    timestamps()
  end

  @doc false
  def changeset(%Spot{} = spot, attrs) do
    spot
    |> cast(attrs, [:name, :available])
    |> validate_required([:name, :available])
  end
end
