defmodule ParkingPrototypeWeb.Router do
  use ParkingPrototypeWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ParkingPrototypeWeb do
    pipe_through :browser # Use the default browser stack

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
   scope "/api", ParkingPrototypeWeb do
     pipe_through :api

     resources "/areas", AreaController, except: [:new, :edit]

     patch "/areas/:id/spots/:spot_id", AreaController, :update_spot
     post "/areas/:id/spots", AreaController, :add_spot
   end
end
