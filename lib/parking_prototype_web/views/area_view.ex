defmodule ParkingPrototypeWeb.AreaView do
  use ParkingPrototypeWeb, :view
  alias ParkingPrototypeWeb.AreaView

  def render("index.json", %{areas: areas}) do
    %{data: %{areas: render_many(areas, AreaView, "area_information.json")}}
  end

  def render("area_information.json", %{area: area}) do
    %{available_spots: area.available_spots, id: area.id, name: area.name}
  end

  def render("show.json", %{area: area}) do
    %{data: render_one(area, AreaView, "area.json")}
  end

  def render("area.json", %{area: area}) do
    %{id: area.id,
      name: area.name,
      spots: Enum.map(area.parking_spots, fn spot -> render(AreaView, "parking_spot.json", parking_spot: spot) end)
      }
  end

  def render("parking_spot.json", %{parking_spot: "#Ecto.Association.NotLoaded<association :parking_spots is not loaded>"}) do
    %{}
  end


  def render("parking_spot.json", %{parking_spot: parking_spot}) do
    %{id: parking_spot.id, area_id: parking_spot.area_id, name: parking_spot.name, available: parking_spot.available}
  end
end
