defmodule TaxisWeb.ResultsAndRankingController do
  use TaxisWeb, :controller
  alias Taxis.Services.ResultsAndRankingService


  # Inserta un ranking
  def ranking(conn, params) do
    case ResultsAndRankingService.ranking(params) do
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


  # Consulta todas las rankings
  def get_rankings(conn, _params) do
    rankings = ResultsAndRankingService.get_rankings()
    json(conn, rankings)
  end


  # Consulta las rankings por passengerId
  def get_rankings_by_passengers(conn, _params) do
    rankings = ResultsAndRankingService.get_rankings_by_passengers()
    json(conn, rankings)
  end


  # Consulta las solicitudes por driverId
  def get_rankings_by_drivers(conn, _params) do
    rankings = ResultsAndRankingService.get_rankings_by_drivers()
    json(conn, rankings)
  end

end
