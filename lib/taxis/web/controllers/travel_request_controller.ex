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


  # Consulta todas las solicitudes
  def get_solicitudes(conn, _params) do
    solicitudes = TravelRequestService.get_solicitudes()
    json(conn, solicitudes)
  end


  # Consulta las solicitudes por passengerId
  def get_solicitudes_by_passenger_id(conn, %{"id" => id}) do
    solicitudes = TravelRequestService.get_solicitudes_by_passenger_id(id)
    json(conn, solicitudes)
  end


  # Consulta las solicitudes por driverId
  def get_solicitudes_by_driver_id(conn, %{"id" => id}) do
    solicitudes = TravelRequestService.get_solicitudes_by_driver_id(id)
    json(conn, solicitudes)
  end


  # Actualiza el estado de una solicitud
  def update_solicitude_status(conn, %{"id" => id, "status" => status}) do
    case TravelRequestService.update_solicitude_status(id, status) do
      {:ok, result} ->
        json(conn, result)

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end


  # Consulta todas las solicitudes por status
  def get_solicitudes_by_status(conn, %{"status" => status}) do
    case TravelRequestService.get_solicitudes_by_status(status) do
      {:ok, solicitudes} ->
        json(conn, solicitudes)

      {:error, reason} ->
        conn
        |> put_status(:bad_request)
        |> json(%{error: reason})
    end
  end


  # Actualiza datos de una solicitud
  def update_solicitude_data(conn, %{"id" => id, "driver_id" => driver_id, "status" => status}) do
    case TravelRequestService.update_solicitude_data(id, driver_id, status) do
      {:ok, result} ->
        json(conn, result)

      {:error, reason} ->
        conn
        |> put_status(:unprocessable_entity)
        |> json(%{error: reason})
    end
  end

end
