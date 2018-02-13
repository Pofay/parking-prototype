defmodule ParkingPrototypeWeb.AreaControllerTest do
  use ParkingPrototypeWeb.ConnCase

  alias ParkingPrototype.Parking

  describe "create/2" do 

    test "create/2 for a new parking area",%{conn: conn} do
      response = conn
                 |> post(area_path(conn,:create), %{area: %{name: "Canteen Area"}})
                 |> json_response(201)
      assert response != nil
    end

    test "A newly created parking area has no spots", %{conn: conn} do
      {:ok,area} = Parking.create_area(%{name: "Some Area"})

      expected = %{"data" => %{"id" => area.id, "name" => area.name, "spots" => []}}

      response = conn
                 |> get(area_path(conn, :show, area.id))
                 |> json_response(200)

      assert response == expected
    end
  end
  
  describe "rendering the json of an area" do

    test "index/2 returns a list of all areas with their available_spots" ,%{conn: conn} do
      {:ok, area1} = Parking.create_area(%{name: "Area1"})
      {:ok, area2} = Parking.create_area(%{name: "Area2"})

      Parking.add_spot(area1.id, %{name: "A1", available: true})

      expected = %{ "data" => %{"areas" => [%{"id" => area1.id, "name" => area1.name, "available_spots" => 1},
                                          %{"id" => area2.id, "name" => area2.name, "available_spots" => 0}]
      }}
 
      response = conn
                 |> get(area_path(conn, :index))
                 |> json_response(200)
      
      assert response == expected
    end

    test "spots that are not available should not be counted in available_spots", %{conn: conn} do
      {:ok, area1} = Parking.create_area(%{name: "Area1"})

      Parking.add_spot(area1.id, %{name: "B2", available: false})

      expected = %{ "data" => %{"areas" => [%{"id" => area1.id, "name" => area1.name, "available_spots" => 0}]}}

      response = conn
                 |> get(area_path(conn, :index))
                 |> json_response(200)

      assert response == expected
 
    end

    test "show/2 should render the spots of an area if there is any", %{conn: conn} do
      {:ok,area} = Parking.create_area(%{name: "Some Area"})
      spot = Parking.add_spot(area.id, %{name: "C1", available: true})

      expected = %{"data" => %{"id" => area.id, "name" => area.name, "spots" => [
        %{"area_id" => area.id,
        "name" => spot.name,
        "id" => spot.id,
        "available" => spot.available}
      ]}}

      response = conn
                 |> get(area_path(conn, :show, area.id))
                 |> json_response(200)

      assert response == expected
    end
  end
  
  test "update_spot/2 should update the spot of the specified area", %{conn: conn} do
    {:ok, area} = Parking.create_area(%{name: "Some Area"})
    spot = Parking.add_spot(area.id,%{name: "C2", available: true})

    expected = %{"data" => %{"id" => area.id, "name" => area.name, "spots" => [
      %{"area_id" => area.id,
      "name" => spot.name,
      "id" => spot.id,
      "available" => false}
    ]}}


    response = conn
               |> patch(area_path(conn, :update_spot, area.id, spot.id), %{available: "false"})
               |> json_response(200)

    assert response == expected
  end

  test "add_spot/2 returns 201 on creating a spot to an area", %{conn: conn} do
    {:ok, area} = Parking.create_area(%{name: "Canteen Area"})

    conn
    |> post(area_path(conn, :add_spot, area.id), %{ name: "C3", available: "true" } )
    |> json_response(201)
  end

end
