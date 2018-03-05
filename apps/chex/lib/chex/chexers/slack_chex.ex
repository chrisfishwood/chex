defmodule Chex.Chexers.SlackChex do
  use Ecto.Schema
  import Ecto.Changeset
  alias Chex.Chexers.SlackChex


  schema "slackchex" do
    field :user, :string

    timestamps()
  end

  @doc false
  def changeset(%SlackChex{} = slack_chex, attrs) do
    slack_chex
    |> cast(attrs, [:user])
    |> validate_required([:user])
  end
end
