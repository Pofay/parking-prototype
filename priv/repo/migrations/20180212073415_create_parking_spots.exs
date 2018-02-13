defmodule ParkingPrototype.Repo.Migrations.CreateParkingSpots do
  use Ecto.Migration

  def change do
    create table(:parking_spots) do
      add :name, :string
      add :available, :boolean, default: false, null: false

      timestamps()
    end

  end
end
