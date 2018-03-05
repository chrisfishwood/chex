defmodule Chex.Chexers do
  @moduledoc """
  The Chexers context.
  """

  import Ecto.Query, warn: false
  alias Chex.Repo

  alias Chex.Chexers.SlackChex

  @doc """
  Returns the list of slackchex.

  ## Examples

      iex> list_slackchex()
      [%SlackChex{}, ...]

  """
  def list_slackchex do
    Repo.all(SlackChex)
  end

  @doc """
  Gets a single slack_chex.

  Raises `Ecto.NoResultsError` if the Slack chex does not exist.

  ## Examples

      iex> get_slack_chex!(123)
      %SlackChex{}

      iex> get_slack_chex!(456)
      ** (Ecto.NoResultsError)

  """
  def get_slack_chex!(id), do: Repo.get!(SlackChex, id)

  @doc """
  Creates a slack_chex.

  ## Examples

      iex> create_slack_chex(%{field: value})
      {:ok, %SlackChex{}}

      iex> create_slack_chex(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_slack_chex(attrs \\ %{}) do
    presence = get_user_slack_status(attrs)
    IO.puts("#################")
    IO.inspect(presence)
    IO.puts("#################")
    %SlackChex{}
    |> SlackChex.changeset(attrs)
    |> Repo.insert()

  end

  @doc """
  Updates a slack_chex.

  ## Examples

      iex> update_slack_chex(slack_chex, %{field: new_value})
      {:ok, %SlackChex{}}

      iex> update_slack_chex(slack_chex, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_slack_chex(%SlackChex{} = slack_chex, attrs) do
    slack_chex
    |> SlackChex.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a SlackChex.

  ## Examples

      iex> delete_slack_chex(slack_chex)
      {:ok, %SlackChex{}}

      iex> delete_slack_chex(slack_chex)
      {:error, %Ecto.Changeset{}}

  """
  def delete_slack_chex(%SlackChex{} = slack_chex) do
    Repo.delete(slack_chex)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking slack_chex changes.

  ## Examples

      iex> change_slack_chex(slack_chex)
      %Ecto.Changeset{source: %SlackChex{}}

  """
  def change_slack_chex(%SlackChex{} = slack_chex) do
    SlackChex.changeset(slack_chex, %{})
  end

  defp get_user_slack_status(attrs) do
    IO.inspect(attrs)
  end

  defp get_user_slack_status(%{"user" => username}) do
    IO.inspect(username)
    #refactor
    #Call slack API
    Slack.Web.Users.get_presence(username)
  end

end
