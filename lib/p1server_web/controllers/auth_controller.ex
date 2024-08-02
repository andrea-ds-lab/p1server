defmodule P1serverWeb.AuthController do
  use P1serverWeb, :controller
  alias P1server.Accounts
  alias P1serverWeb.Auth.Guardian

  def register(conn, %{"user" => user_params}) do
    case Accounts.change_user_registration(user_params) do
      {:ok, user} ->
        conn
        |> put_status({:created})
        |> json(%{message: "User created succesfully"})
      {:error, _reason} ->
        conn
        |> put_status({:unprocessable_entity})
        |> json(%{error: "Failed to create user"})
    end
  end

  def login(conn, %{"user" => %{"email" => email, "password" => password}}) do
    with  {:ok, user } <-  Accounts.authenticate_user(email, password),
          {:ok, token, _claims} <- Guardian.encode_and_sign(user) do
            conn
            |> put_status(:ok)
            |> json(%{token: token})
    else
      _ ->
        conn
        |> put_status(:unauthorized)
        |> json(%{error: "Invalid credentials"})
    end
  end
end
