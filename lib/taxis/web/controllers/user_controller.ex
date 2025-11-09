defmodule TaxisWeb.UserController do
  use TaxisWeb, :controller
  alias Taxis.Services.UserService


  # Login
  def login(conn, %{"username" => username, "password" => password}) do
    case UserService.login(username, password) do
      {:ok, response} ->
        json(conn, response)

      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end

  # Registro
  def register(conn, params) do
    case UserService.register(params) do
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


  # Obtiene datos de perfil
  def get_profile(conn, %{"id" => id}) do
    case UserService.get_profile(id) do
      {:ok, response} ->
        json(conn, response)

      {:error, message} ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: message})
    end
  end

end
