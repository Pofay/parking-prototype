defmodule ParkingPrototype.Parking.Area do
  use Ecto.Schema
  import Ecto.Changeset
  alias ParkingPrototype.Parking.Area


  schema "areas" do
    field :name, :string
    has_many :parking_spots, ParkingPrototype.Parking.Spot

    timestamps()
  end

  @doc false
  def changeset(%Area{} = area, attrs) do
    area
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
