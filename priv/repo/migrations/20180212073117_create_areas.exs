defmodule ParkingPrototype.Repo.Migrations.CreateAreas do
  use Ecto.Migration

  def change do
    create table(:areas) do
      add :name, :string

      timestamps()
    end

  end
end
