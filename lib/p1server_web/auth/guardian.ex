# lib/your_app_web/auth/guardian.ex
defmodule P1serverWeb.Auth.Guardian do
  use Guardian, otp_app: :p1server

  def subject_for_token(resource, _claims) do
    {:ok, "user:#{resource.id}"}
  end

  def resource_from_claims(%{"sub" => "user:" <> id}) do
    # Fetch the user from the database using the id
    case P1server.Accounts.get_user(id) do
      nil -> {:error, :resource_not_found}
      user -> {:ok, user}
    end
  end
end
