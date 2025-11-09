defmodule Taxis.Services.TravelRequestService do
  alias Taxis.Repositories.TravelRequestRepository


  # Realizar solicitud
  def solicitude(attrs) do
    case TravelRequestRepository.create_solicitude(attrs) do
      {:ok, travel} ->
        IO.inspect(travel, label: "Solicitud creada")
        {:ok, format_solicitude_response(travel)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, format_changeset_errors(changeset)}

      {:error, reason} ->
        IO.inspect(reason, label: "Error creando solicitud")
        {:error, reason}
    end
  end

  # Formatea la respuesta JSON
  defp format_solicitude_response(travel) do
    IO.inspect(travel, label: "Travel struct", pretty: true)
    %{
      data: [
        %{
          type: "travel_request",
          id: to_string(travel.id),
          attributes: %{
            id: to_string(travel.id),
            passenger_id: travel.passenger_id,
            origin_location_id: travel.origin_location_id,
            destination_location_id: travel.destination_location_id,
            status: travel.status,
            created_at: travel.created_at,
            updated_at: travel.updated_at
          }
        }
      ]
    }
  end

  # Formatea errores de changeset
  defp format_changeset_errors(changeset) do
    Ecto.Changeset.traverse_errors(changeset, fn {msg, opts} ->
      Enum.reduce(opts, msg, fn {key, value}, acc ->
        String.replace(acc, "%{#{key}}", to_string(value))
      end)
    end)
  end

  # Consulta todas las solicitudes
  def get_solicitudes() do
    TravelRequestRepository.get_solicitudes()
  end

  # Consulta las solicitudes por passengerId
  def get_solicitudes_by_passenger_id(id) when is_integer(id) do
    TravelRequestRepository.get_solicitudes_by_passenger_id(id)
  end

  #
  def get_solicitudes_by_passenger_id(id) when is_binary(id) do
    case Integer.parse(id) do
      {passenger_id, ""} ->
        TravelRequestRepository.get_solicitudes_by_passenger_id(passenger_id)

      :error ->
        {:error, :invalid_id}
    end
  end

  # Consulta las solicitudes por driverId
  def get_solicitudes_by_driver_id(id) when is_integer(id) do
    TravelRequestRepository.get_solicitudes_by_driver_id(id)
  end

  #
  def get_solicitudes_by_driver_id(id) when is_binary(id) do
    case Integer.parse(id) do
      {driver_id, ""} ->
        TravelRequestRepository.get_solicitudes_by_driver_id(driver_id)

      :error ->
        {:error, :invalid_id}
    end
  end

  # Actualiza el estado de una solicitud
  def update_solicitude_status(id, status) do
    case Integer.parse(id) do
      {travel_id, ""} ->
        valid_statuses = ["Pendiente", "Aceptado", "Completado", "Cancelado"]

        if status in valid_statuses do
          case TravelRequestRepository.update_solicitude_status(travel_id, status) do
            {:ok, travel} ->
              # Formateamos la respuesta antes de devolverla
              {:ok, format_travel_response(travel)}

            {:error, reason} ->
              {:error, reason}
          end
        else
           {:error, "Invalid status value"}
        end

      :error ->
        {:error, "Invalid ID"}
    end
  end

  # Formatea la respuesta del update de la solicitud
  defp format_travel_response(travel) do
    %{
      data: %{
        type: "travel_request",
        id: to_string(travel.id),
        attributes: %{
          id: travel.id,
          passenger_id: travel.passenger_id,
          driver_id: travel.driver_id,
          origin_location_id: travel.origin_location_id,
          destination_location_id: travel.destination_location_id,
          status: travel.status,
          created_at: travel.created_at,
          updated_at: travel.updated_at
        }
      }
    }
  end

  #
  def get_solicitudes_by_status(status) do
    valid_statuses = ["Pendiente", "Aceptado", "Completado", "Cancelado"]

    if status in valid_statuses do
      solicitudes = TravelRequestRepository.get_solicitudes_by_status(status)
      {:ok, solicitudes}
    else
      {:error, "Invalid status value"}
    end
  end

  # Actualiza el estado de una solicitud
  def update_solicitude_data(id, driver_id, status) do
    case Integer.parse(id) do
      {travel_id, ""} ->
        valid_statuses = ["Pendiente", "Aceptado", "Completado", "Cancelado"]

        if status in valid_statuses do
          case TravelRequestRepository.update_solicitude_data(travel_id, driver_id, status) do
            {:ok, travel} ->
              {:ok, format_travel_response(travel)}

            {:error, reason} ->
              {:error, reason}
          end
        else
          {:error, "Invalid status value"}
        end

      :error ->
        {:error, "Invalid ID"}
    end
  end


end
