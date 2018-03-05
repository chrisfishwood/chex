defmodule Chex.Repo.Migrations.CreateSlackUsers do
  use Ecto.Migration

  def change do
    create table(:slack_users) do
      add :color, :string
      add :deleted, :boolean, default: false, null: false
      add :has_2fa, :boolean, default: false, null: false
      add :slack_id, :string
      add :is_admin, :boolean, default: false, null: false
      add :is_app_user, :boolean, default: false, null: false
      add :is_bot, :boolean, default: false, null: false
      add :is_owner, :boolean, default: false, null: false
      add :is_primary_owner, :boolean, default: false, null: false
      add :is_restricted, :boolean, default: false, null: false
      add :is_ultra_restricted, :boolean, default: false, null: false
      add :name, :string
      add :real_name, :string
      add :team_id, :string
      add :tz, :string
      add :tz_label, :string
      add :tz_offset, :integer
      add :updated, :integer

      timestamps()
    end

  end
end
