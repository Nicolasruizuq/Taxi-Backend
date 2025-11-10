defmodule Taxis.ResultsAndRanking do
  use Ecto.Schema
  import Ecto.Changeset

  schema "results_and_ranking" do
    field :date_trip, :naive_datetime
    field :passenger_points, :integer
    field :driver_points, :integer
    field :origin, :string
    field :destination, :string
    field :status, :string
    field :deleted_at, :naive_datetime

    belongs_to :passenger, Taxis.User, foreign_key: :passenger_id
    belongs_to :driver, Taxis.User, foreign_key: :driver_id

    timestamps(inserted_at: :created_at, updated_at: :updated_at, type: :utc_datetime)
  end

  @doc false
  def changeset(results_and_ranking, attrs) do
    results_and_ranking
    |> cast(attrs, [
      :date_trip,
      :passenger_id,
      :passenger_points,
      :driver_id,
      :driver_points,
      :origin,
      :destination,
      :status,
      :deleted_at
    ])
    |> validate_required([
      :date_trip,
      :passenger_id,
      :driver_id,
      :origin,
      :destination,
      :status
    ])
    |> foreign_key_constraint(:passenger_id)
    |> foreign_key_constraint(:driver_id)
  end
end
