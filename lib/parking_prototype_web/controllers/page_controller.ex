defmodule ParkingPrototypeWeb.PageController do
  use ParkingPrototypeWeb, :controller

  def index(conn, _params) do
    render conn, "index.html"
  end
end
