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

  # Obtener todas las solicitudes
  def get_solicitudes() do
    TravelRequestRepository.get_solicitudes()
  end
end
