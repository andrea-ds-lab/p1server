defmodule MyApp.Repo.Migrations.CreateUsersTokens do
  use Ecto.Migration

  def change do
    create table(:users_tokens) do
      add :context, :string
      add :token, :string
      add :sent_to, :string
      add :user_id, references(:users, on_delete: :delete_all)
      timestamps()
    end

    create index(:users_tokens, [:user_id])
  end
end
