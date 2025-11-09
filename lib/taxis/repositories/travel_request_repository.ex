defmodule Taxis.Repositories.TravelRequestRepository do
  import Ecto.Query
  alias Taxis.Repo
  alias Taxis.TravelRequest
  alias Taxis.User
  alias Taxis.Location


  # Crear solictitud
  def create_solicitude(attrs) do
    %TravelRequest{}
    |> TravelRequest.changeset(attrs)
    |> Repo.insert()
  end

  def get_solicitudes() do
    query =
      from tr in TravelRequest,
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

  def get_solicitudes_by_passenger_id(id) do
    query =
      from tr in TravelRequest,
        join: us_passenger in User,
        on: us_passenger.id == tr.passenger_id,
        left_join: us_driver in User,
        on: us_driver.id == tr.driver_id,
        join: lo_origin in Location,
        on: lo_origin.id == tr.origin_location_id,
        join: lo_destination in Location,
        on: lo_destination.id == tr.destination_location_id,
        where: tr.passenger_id == ^id,
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

  def get_solicitudes_by_driver_id(id) do
    query =
      from tr in TravelRequest,
        join: us_passenger in User,
        on: us_passenger.id == tr.passenger_id,
        left_join: us_driver in User,
        on: us_driver.id == tr.driver_id,
        join: lo_origin in Location,
        on: lo_origin.id == tr.origin_location_id,
        join: lo_destination in Location,
        on: lo_destination.id == tr.destination_location_id,
        where: tr.driver_id == ^id,
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

  def update_solicitude_status(id, status) do
    case Repo.get(TravelRequest, id) do
      nil ->
        {:error, "Solicitud no encontrada"}

      travel_request ->
        atom_status = String.to_existing_atom(status)

        travel_request
        |> Ecto.Changeset.change(status: atom_status)
        |> Repo.update()
    end
  end

end
