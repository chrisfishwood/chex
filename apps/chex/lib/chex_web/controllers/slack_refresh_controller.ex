defmodule ChexWeb.SlackRefreshController do
  use ChexWeb, :controller

  alias Chex.Chexers
  alias Chex.Chexers.SlackChex

  action_fallback ChexWeb.FallbackController

  def create(conn, %{"slack_refresh" => slack_refresh_params}) do
    IO.inspect slack_refresh_params
    # with check param for secret
    # drop tables
    # create tables
    # put_status
    # put_resp_header
    #with {:ok, %SlackChex{} = slack_chex} <- Chexers.create_slack_chex(slack_chex_params) do
      #conn
      #|> put_status(:created)
      #|> put_resp_header("location", slack_chex_path(conn, :show, slack_chex))
      #|> render("show.json", slack_chex: slack_chex)
    #end
    with true <- check_secret(slack_refresh_params),
         {:ok, members} <- get_slack_users() do
      count = count_members(members)
      conn
      |>put_status(:created)
      |>text(count)
    else
      _ ->
        conn
        |>put_status(:service_unavailable)
        |>text(0)
    end
  end

  defp check_secret(params) do
    Map.get(params, "secret") == "refreshme"
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
