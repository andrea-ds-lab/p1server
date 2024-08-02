# lib/your_app_web/auth/guardian.ex
defmodule P1serverWeb.Auth.Guardian do
  use Guardian, otp_app: :p1server

  def subject_for_token(resource, _claims) do
    {:ok, "user:#{resource.id}"}
  end

  def resource_from_claims(claims) do
    # Implement how to retrieve the user from the claims
    {:ok, P1server.Accounts.get_user!(claims["sub"])}
  end
end
