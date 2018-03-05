defmodule Chex.Slack.User.Profile do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chex.Slack.User.Profile


  schema "slack_user_profiles" do
    field :avatar_hash, :string
    field :display_name, :string
    field :display_name_normalized, :string
    field :email, :string
    field :first_name, :string
    field :image_1024, :string
    field :image_192, :string
    field :image_24, :string
    field :image_32, :string
    field :image_48, :string
    field :image_512, :string
    field :image_72, :string
    field :image_original, :string
    field :last_name, :string
    field :phone, :string
    field :real_name, :string
    field :real_name_normalized, :string
    field :slype, :string
    field :status_emoji, :string
    field :status_text, :string
    field :team, :string
    field :title, :string

    timestamps()
  end

  @doc false
  def changeset(%Profile{} = profile, attrs) do
    profile
    |> cast(attrs, [:avatar_hash, :display_name, :display_name_normalized, :email, :first_name, :image_1024, :image_192, :image_24, :image_32, :image_48, :image_512, :image_72, :image_original, :last_name, :phone, :real_name, :real_name_normalized, :slype, :status_emoji, :status_text, :team, :title])
    |> validate_required([:avatar_hash, :display_name, :display_name_normalized, :email, :first_name, :image_1024, :image_192, :image_24, :image_32, :image_48, :image_512, :image_72, :image_original, :last_name, :phone, :real_name, :real_name_normalized, :slype, :status_emoji, :status_text, :team, :title])
  end
end
