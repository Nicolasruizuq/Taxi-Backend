defmodule Taxis.Services.UserService do
  alias Taxis.Repositories.UserRepository


  # Login
  def login(username, password) do
    case UserRepository.find_by_username_and_password(username, password) do
      nil ->
        {:error, "Invalid credentials"}

      %{} = user ->
        {:ok, format_user_response(user)}
    end
  end

  # Registro
  def register(attrs) do
    case UserRepository.create_user_with_driver(attrs) do
      {:ok, user} ->
        IO.inspect(user, label: "Usuario creado")
        {:ok, format_user_response(user)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:error, format_changeset_errors(changeset)}

      {:error, reason} ->
        IO.inspect(reason, label: "Error creando usuario o driver")
        {:error, reason}
    end
  end

  # Formatea la respuesta JSON
  defp format_user_response(user) do
    IO.inspect(user, label: "User struct", pretty: true)
    %{
      data: [
        %{
          type: "user",
          id: to_string(user.id),
          attributes: %{
            id: to_string(user.id),
            name: user.name,
            username: user.username,
            role_id: user.role_id,
            created_at: user.created_at,
            updated_at: user.updated_at
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

  # Obtiene datos de perfil
  def get_profile(id) do
    case UserRepository.get_profile(id) do
      nil ->
        {:error, "User not found"}

      %{} = user ->
        {:ok, format_profile_response(user)}
    end
  end

  # Formatea la respuesta JSON
  defp format_profile_response(user) do
    IO.inspect(user, label: "User struct", pretty: true)
    %{
      data: [
        %{
          type: "user",
          id: to_string(user.id),
          attributes: %{
            id: to_string(user.id),
            name: user.name,
            role_id: user.role_id,
            username: user.username,
            created_at: user.created_at,
            vehicle_model: user.vehicle_model,
            vehicle_plate: user.vehicle_plate,
            total_passenger_points: user.total_passenger_points,
            total_driver_points: user.total_driver_points

          }
        }
      ]
    }
  end
end
