defmodule TaxisWeb.TravelRequestController do
  use TaxisWeb, :controller
  alias Taxis.Services.TravelRequestService


  # Realiza solicitud
  def solicitude(conn, params) do
    case TravelRequestService.solicitude(params) do
      {:ok, response} ->
        conn
        |> put_status(:created)
        |> json(response)

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: message})
    end
  end


  #Consulta las solicitudes
  def get_solicitudes(conn, _params) do
    solicitudes = TravelRequestService.get_solicitudes()
    json(conn, solicitudes)
  end
end
