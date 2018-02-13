defmodule ParkingPrototype.Repo.Migrations.ParkingSpotBelongsToArea do
  use Ecto.Migration

  def change do
    alter table(:parking_spots) do
      add :area_id, references(:areas)
    end

  end
end
