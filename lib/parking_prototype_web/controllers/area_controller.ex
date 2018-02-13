defmodule ParkingPrototypeWeb.AreaController do
  use ParkingPrototypeWeb, :controller

  alias ParkingPrototype.Parking
  alias ParkingPrototype.Parking.Area

  action_fallback ParkingPrototypeWeb.FallbackController

  def index(conn, _params) do
    areas = Parking.list_areas()
    render(conn, "index.json", areas: areas)
  end

  # accepts { "area" { "name": "some_name" } }
  def create(conn, %{"area" => area_params}) do
    with {:ok, %Area{} = created_area} <- Parking.create_area(area_params) do
      area = Parking.get_area!(created_area.id)
      conn
      |> put_status(:created)
      |> put_resp_header("location", area_path(conn, :show, area))
      |> render("show.json", area: area)
    end
  end

  # still lacks error handling
  def show(conn, %{"id" => id}) do
    area = Parking.get_area!(id)
    render(conn, "show.json", area: area)
  end
 
  # not sure if i want this here
  def update(conn, %{"id" => id, "area" => area_params}) do
    area = Parking.get_area!(id)

    with {:ok, %Area{} = area} <- Parking.update_area(area, area_params) do
      render(conn, "show.json", area: area)
    end
  end

  # Should cascade delete along with its spots
  def delete(conn, %{"id" => id}) do
    area = Parking.get_area!(id)
    with {:ok, %Area{}} <- Parking.delete_area(area) do
      send_resp(conn, :no_content, "")
    end
  end

  # accepts { "available": "false" or "true"
  def update_spot(conn, params) do
    Parking.update_spot(params["spot_id"],params["available"])
    render(conn, "show.json", area: Parking.get_area!(params["id"]))
  end

  # accepts { "name": "some_name", "available": "true" or "false" }
  def add_spot(conn, %{"id" => id, "name" => name, "available" => available}) do
    Parking.add_spot(id, %{name: name, available: String.to_atom(available)})
    conn
    |> put_status(201)
    |> render("show.json", area: Parking.get_area!(id))
  end
end
