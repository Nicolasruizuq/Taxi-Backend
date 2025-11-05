defmodule Taxis.User do
  use Ecto.Schema
  import Ecto.Changeset

  schema "users" do
    belongs_to :role, Taxis.Role  # FK hacia roles.id
    has_one :driver, Taxis.Driver, foreign_key: :id
    field :name, :string
    field :username, :string
    field :password, :string
    field :deleted_at, :naive_datetime

    timestamps(inserted_at: :created_at, updated_at: :updated_at, type: :utc_datetime)
  end

  @doc false
  def changeset(user, attrs) do
    user
    |> cast(attrs, [:role_id, :name, :username, :password, :deleted_at])
    |> validate_required([:role_id, :name, :username, :password])
    |> assoc_constraint(:role)  # valida que el role_id exista en roles
  end
end
