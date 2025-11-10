defmodule Taxis.Repositories.ResultsAndRankingRepository do
  import Ecto.Query
  alias Taxis.Repo
  alias Taxis.ResultsAndRanking
  alias Taxis.User
  alias Taxis.Location


  # Crear solictitud
  def create_ranking(attrs) do
    %ResultsAndRanking{}
    |> ResultsAndRanking.changeset(attrs)
    |> Repo.insert()
  end

  def get_rankins() do
    query =
      from tr in ResultsAndRanking,
        join: us_passenger in User,
        on: us_passenger.id == tr.passenger_id,
        left_join: us_driver in User,
        on: us_driver.id == tr.driver_id,
        join: lo_origin in Location,
        on: lo_origin.id == tr.origin_location_id,
        join: lo_destination in Location,
        on: lo_destination.id == tr.destination_location_id,
        select: %{
          travel_id: tr.id,
          passenger: us_passenger.name,
          driver: us_driver.name,
          origin: lo_origin.name,
          destination: lo_destination.name,
          status: tr.status,
          created_at: tr.created_at
        }

    Repo.all(query)
  end

  def get_rankings_by_passengers() do
    query =
      from tr in ResultsAndRanking,
        join: us in User,
        on: us.id == tr.passenger_id,
        group_by: [tr.passenger_id, us.name],
        select: %{
          passenger_id: tr.passenger_id,
          name: us.name,
          total_passenger_points: sum(tr.passenger_points)
        },
        order_by: [desc: sum(tr.passenger_points)],
        limit: 10

    Repo.all(query)
  end

  def get_rankings_by_drivers() do
    query =
      from tr in ResultsAndRanking,
        join: us in User,
        on: us.id == tr.driver_id,
        group_by: [tr.driver_id, us.name],
        select: %{
          driver_id: tr.driver_id,
          name: us.name,
          total_passenger_points: sum(tr.passenger_points)
        },
        order_by: [desc: sum(tr.passenger_points)],
        limit: 10

    Repo.all(query)
  end

end
