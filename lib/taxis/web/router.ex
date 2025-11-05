defmodule TaxisWeb.Router do
  use TaxisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaxisWeb do
    pipe_through :api

    post "/login", UserController, :login
    post "/register", UserController, :register
  end
end
