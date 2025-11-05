defmodule Taxis.TravelRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "travel_requests" do
    # Relaciones con usuarios
    belongs_to :passenger, Taxis.User, foreign_key: :passenger_id
    belongs_to :driver, Taxis.User, foreign_key: :driver_id

    # Relaciones con ubicaciones
    belongs_to :origin_location, Taxis.Location, foreign_key: :origin_location_id
    belongs_to :destination_location, Taxis.Location, foreign_key: :destination_location_id

    # Otros campos
    field :status, Ecto.Enum, values: [:Pendiente, :Aceptado, :Completado, :Cancelado]
    field :deleted_at, :naive_datetime

    timestamps(inserted_at: :created_at, updated_at: :updated_at, type: :utc_datetime)
  end

  @doc false
  def changeset(travel_request, attrs) do
    travel_request
    |> cast(attrs, [
      :passenger_id,
      :driver_id,
      :origin_location_id,
      :destination_location_id,
      :status,
      :deleted_at
    ])
    |> validate_required([
      :passenger_id,
      :driver_id,
      :origin_location_id,
      :destination_location_id,
      :status
    ])
    |> foreign_key_constraint(:passenger_id)
    |> foreign_key_constraint(:driver_id)
    |> foreign_key_constraint(:origin_location_id)
    |> foreign_key_constraint(:destination_location_id)
  end
end
