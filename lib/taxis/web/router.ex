defmodule TaxisWeb.Router do
  use TaxisWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", TaxisWeb do
    pipe_through :api

    # Método POST inserta o obtiene datos que no pueden ser mostrados en la URl por seguridad
    post "/login", UserController, :login
    post "/register", UserController, :register
    post "/solicitude", TravelRequestController, :solicitude

    # Método GET obtiene datos
    get "/solicitude", TravelRequestController, :get_solicitudes
    get "/solicitudesByPassenger/:id", TravelRequestController, :get_solicitudes_by_passenger_id
    get "/solicitudesByDriver/:id", TravelRequestController, :get_solicitudes_by_driver_id

    # PUT Actualiza los datos
    put "/solicitudeStatusById/:id", TravelRequestController, :update_solicitude_status
  end
end
