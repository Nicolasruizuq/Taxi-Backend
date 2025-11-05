defmodule Taxis.Driver do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :id, autogenerate: false}
  schema "drivers" do
    field :vehicle_model, :string
    field :vehicle_plate, :string
    field :deleted_at, :naive_datetime

    timestamps(inserted_at: :created_at, updated_at: :updated_at, type: :utc_datetime)
  end

  @doc false
  def changeset(driver, attrs) do
    driver
    |> cast(attrs, [:id, :vehicle_model, :vehicle_plate, :deleted_at])
    |> validate_required([:id, :vehicle_model, :vehicle_plate])
    |> foreign_key_constraint(:id)
  end
end
