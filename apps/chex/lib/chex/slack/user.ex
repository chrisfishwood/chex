defmodule Chex.Slack.User do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chex.Slack.User


  schema "slack_users" do
    field :color, :string
    field :deleted, :boolean, default: false
    field :has_2fa, :boolean, default: false
    field :is_admin, :boolean, default: false
    field :is_app_user, :boolean, default: false
    field :is_bot, :boolean, default: false
    field :is_owner, :boolean, default: false
    field :is_primary_owner, :boolean, default: false
    field :is_restricted, :boolean, default: false
    field :is_ultra_restricted, :boolean, default: false
    field :name, :string
    field :real_name, :string
    field :slack_id, :string
    field :team_id, :string
    field :tz, :string
    field :tz_label, :string
    field :tz_offset, :integer
    field :updated, :integer

    timestamps()
  end

  @doc false
  def changeset(%User{} = user, attrs) do
    user
    |> cast(attrs, [:color, :deleted, :has_2fa, :slack_id, :is_admin, :is_app_user, :is_bot, :is_owner, :is_primary_owner, :is_restricted, :is_ultra_restricted, :name, :real_name, :team_id, :tz, :tz_label, :tz_offset, :updated])
    |> validate_required([:color, :deleted, :has_2fa, :slack_id, :is_admin, :is_app_user, :is_bot, :is_owner, :is_primary_owner, :is_restricted, :is_ultra_restricted, :name, :real_name, :team_id, :tz, :tz_label, :tz_offset, :updated])
  end
end
