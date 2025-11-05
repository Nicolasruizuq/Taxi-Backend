defmodule Taxis.Repositories.UserRepository do
  import Ecto.Query
  alias Taxis.Repo
  alias Taxis.User
  alias Taxis.Driver


  #Login
  def find_by_username_and_password(username, password) do
    User
    |> where([u], u.username == ^username and u.password == ^password)
    |> preload(:role)
    |> Repo.one()
  end

  # Crear usuario
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  # Crear driver
  def create_driver(user_id, vehicle_attrs) do
    %Driver{}
    |> Driver.changeset(Map.put(vehicle_attrs, :id, user_id))
    |> Repo.insert()
  end

  # Crear usuario y driver en transacción
  def create_user_with_driver(attrs) do
    Repo.transaction(fn ->
      {:ok, user} = create_user(attrs)

      IO.inspect(attrs, label: "Attrs recibidos como átomos")

      if Map.get(attrs, "role_id") == 2 do
        vehicle_attrs = %{
          vehicle_model: Map.get(attrs, "vehicle_model"),
          vehicle_plate: Map.get(attrs, "vehicle_plate"),
          id: user.id
        }

        {:ok, _driver} = create_driver(user.id, vehicle_attrs)
      end

      Repo.preload(user, :driver)
    end)
  end
end
