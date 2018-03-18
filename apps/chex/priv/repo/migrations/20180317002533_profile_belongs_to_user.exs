defmodule Chex.Repo.Migrations.ProfileBelongsToUser do
  use Ecto.Migration

  def change do
    alter table(:slack_user_profiles) do
      add :slack_user_id, references(:slack_users)
    end
  end
end
