defmodule Chex.Repo.Migrations.CreateSlackchex do
  use Ecto.Migration

  def change do
    create table(:slackchex) do
      add :user, :string

      timestamps()
    end

  end
end
