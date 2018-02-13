defmodule ParkingPrototype.Parking do
  @moduledoc """
  The Parking context.
  """

  import Ecto.Query, warn: false
  alias ParkingPrototype.Repo

  alias ParkingPrototype.Parking.Area
  alias ParkingPrototype.Parking.Spot

  @doc """
  Returns the list of areas.

  ## Examples

      iex> list_areas()
      [%Area{}, ...]

  """
  def list_areas do
    Enum.map(Repo.all(Area), fn(area) -> %{ id: area.id, name: area.name, available_spots: get_available_spots(area.id) } end)
  end

  defp get_available_spots(area_id) do
    area = get_area!(area_id)
    Enum.count(area.parking_spots, fn(spot) -> spot.available == true end)
  end

  @doc """
  Gets a single area.

  Raises `Ecto.NoResultsError` if the Area does not exist.

  ## Examples

      iex> get_area!(123)
      %Area{}

      iex> get_area!(456)
      ** (Ecto.NoResultsError)

  """
  def get_area!(id) do  
    Repo.get!(Area, id)
    |> Repo.preload(:parking_spots)
  end

  @doc """
  Creates a area.

  ## Examples

      iex> create_area(%{field: value})
      {:ok, %Area{}}

      iex> create_area(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_area(attrs \\ %{}) do
    %Area{}
    |> Area.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a area.

  ## Examples

      iex> update_area(area, %{field: new_value})
      {:ok, %Area{}}

      iex> update_area(area, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_area(%Area{} = area, attrs) do
    area
    |> Area.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a Area.

  ## Examples

      iex> delete_area(area)
      {:ok, %Area{}}

      iex> delete_area(area)
      {:error, %Ecto.Changeset{}}

  """
  def delete_area(%Area{} = area) do
    Repo.delete(area)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking area changes.

  ## Examples

      iex> change_area(area)
      %Ecto.Changeset{source: %Area{}}

  """
  def change_area(%Area{} = area) do
    Area.changeset(area, %{})
  end

  def update_spot(spot_id, availability) do
    spot = Repo.get(Spot,spot_id)
    Spot.changeset(spot,%{name: spot.name, available: availability})
    |> Repo.update()
  end

  def add_spot(area_id, spot_params) do
    get_area!(area_id)
    |> Ecto.build_assoc(:parking_spots, %{name: spot_params.name, available: spot_params.available})
    |> Repo.insert!()
  end

end
