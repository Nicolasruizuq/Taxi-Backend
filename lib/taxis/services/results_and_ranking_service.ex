defmodule Taxis.Services.ResultsAndRankingService do
  alias Taxis.Repositories.ResultsAndRankingRepository


  # Crear historial de ranking
  def ranking(attrs) do
    case ResultsAndRankingRepository.create_ranking(attrs) do
      {:ok, ranking} ->
        IO.inspect(ranking, label: "Ranking creado")
        {:ok, format_ranking_response(ranking)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, format_changeset_errors(changeset)}

      {:error, reason} ->
        IO.inspect(reason, label: "Error creando solicitud")
        {:error, reason}
    end
  end

  # Formatea la respuesta JSON
  defp format_ranking_response(ranking) do
    IO.inspect(ranking, label: "Ranking struct", pretty: true)
    %{
      data: [
        %{
          type: "results_and_ranking",
          id: to_string(ranking.id),
          attributes: %{
            id: to_string(ranking.id),
            date_trip: ranking.date_trip,
            passenger_id: ranking.passenger_id,
            passenger_points: ranking.passenger_points,
            driver_id: ranking.driver_id,
            driver_points: ranking.driver_points,
            origin: ranking.origin,
            destination: ranking.destination,
            status: ranking.status,
            created_at: ranking.created_at,
            updated_at: ranking.updated_at
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

  # Consulta todas las rankings
  def get_rankins() do
    ResultsAndRankingRepository.get_rankins()
  end

  # Consulta las rankings por passengerId
  def get_rankings_by_passengers() do
    ResultsAndRankingRepository.get_rankings_by_passengers()
  end

  # Consulta las rankings por driverId
  def get_rankings_by_drivers() do
    ResultsAndRankingRepository.get_rankings_by_drivers()
  end

end
