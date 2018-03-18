defmodule Chex.Repo.Migrations.CreateSlackUserProfiles do
  use Ecto.Migration

  def change do
    create table(:slack_user_profiles) do
      add :avatar_hash, :string
      add :display_name, :string
      add :display_name_normalized, :string
      add :email, :string
      add :first_name, :string
      add :image_1024, :string
      add :image_192, :string
      add :image_24, :string
      add :image_32, :string
      add :image_48, :string
      add :image_512, :string
      add :image_72, :string
      add :image_original, :string
      add :last_name, :string
      add :phone, :string
      add :real_name, :string
      add :real_name_normalized, :string
      add :skype, :string
      add :status_emoji, :string
      add :status_text, :string
      add :team, :string
      add :title, :string

      timestamps()
    end

  end
end
