defmodule ChexWeb.SlackRefreshController do
  use ChexWeb, :controller

  alias Chex.Chexers
  alias Chex.Chexers.SlackChex
  alias Chex.Slack.User.Profile
  alias Chex.Slack.User
  alias Chex.Repo

  require IEx
  require Logger
  
  import ExProf.Macro
  import Ecto.Query, only: [from: 2]

  action_fallback ChexWeb.FallbackController

  def create(conn, %{"slack_refresh" => slack_refresh_params}) do
    IO.inspect slack_refresh_params
    with true <- check_secret(slack_refresh_params),
         {:ok, members} <- get_slack_users(),
         true <- Kernel.length(members) > 0 do

      Repo.delete_all Profile
      Repo.delete_all User
      count = count_members(members)
      #profile = Enum.each(List.last(members), &create_user_and_profile/1)
      {:ok, user} = create_user_and_profile(List.last(members))
      Logger.debug fn -> "returning user: #{inspect(user)}" end
      #profile = Enum.each(List.last(members), &create_user_and_profile/1)
      conn
      |>put_status(:created)
      |>json(user)
    else
      _ ->
        conn
        |>put_status(:service_unavailable)
        |>text(0)
    end
  end

  defp create_user_and_profile(member) do
    Logger.debug fn -> "inserting: #{inspect(member)}" end

    {:ok, slack_user} = create_slack_user(member)
    profile_params = Map.get(member, "profile") 
    {:ok, profile} = create_profile(profile_params, slack_user)
    #Repo.get(User, slack_user.id) |> Repo.preload(:slack_user_profile)
    member_with_profile = from(u in User, where: u.id == ^slack_user.id)
    |>Repo.all()
    |>Repo.preload(:slack_user_profile)
    #member_with_profile = Repo.get(User, slack_user.id)
    #member_with_profile = Repo.preload(member_with_profile, :slack_user_profile)
    {:ok, member_with_profile}
  end

  defp create_profile(profile_params, slack_user) do
    Logger.debug fn -> inspect(slack_user) end
    Logger.debug fn -> inspect(profile_params) end
    changeset = %Profile{slack_user_id: slack_user.id}
    |> Profile.changeset(profile_params)

    with {:ok, profile} <- Repo.insert(changeset) do
      Logger.debug fn -> IO.puts("Created profile for #{profile.display_name}") end
      {:ok, profile}
    else
      {:error, changeset} -> 
        Logger.error fn ->
          IO.inspect ("An error occurred creating a profile for #{Map.get(profile_params, "display_name")}")
          IO.inspect changeset.errors
        end
    end
  end

  defp create_slack_user(user_params) do
    changeset = User.changeset(%User{}, user_params)
    IO.inspect changeset
    with {:ok, user} <- Repo.insert(changeset) do
      Logger.debug fn -> IO.puts("Created user for #{user.real_name}") end
      {:ok, user}
    else
      {:error, changeset} -> 
        Logger.error fn ->
          IO.inspect ("An error occurred creating a user for #{Map.get(user_params, "real_name")}")
          IO.inspect changeset.errors
        end
    end
  end

  defp check_secret(params) do
    secret = Application.get_env(:chex, ChexWeb.Endpoint)[:refresh_secret]
    Map.get(params, "secret") == secret
  end

  defp count_members(members \\ []) do
    Kernel.length(members)
  end

  defp get_slack_users() do
    #Call slack API
    # Enum.each Map.get(Slack.Web.Users.list, "members"), fn member -> if Map.get(member, "real_name") === "Chris Steinmeyer" do IO.inspect(Map.get(member, "id")) end end
    # Enum.each members, fn member -> if Map.get(member, "real_name") === "Chris Steinmeyer" do IO.inspect(Map.get(member, "id")) end end

    with members <- Map.get(Slack.Web.Users.list, "members") do
      {:ok, members}
    else
      _ ->
        {:err, %{}}
    end
  end
end
