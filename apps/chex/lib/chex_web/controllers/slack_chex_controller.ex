defmodule ChexWeb.SlackChexController do
  use ChexWeb, :controller

  alias Chex.Chexers
  alias Chex.Chexers.SlackChex

  action_fallback ChexWeb.FallbackController

  def index(conn, _params) do
    slackchex = Chexers.list_slackchex()
    render(conn, "index.json", slackchex: slackchex)
  end

  def create(conn, %{"slack_chex" => slack_chex_params}) do
    IO.puts("-----------------")
    IO.inspect(slack_chex_params)
    IO.puts("-----------------")
    #in the future this will spin up a new genserver instance and start pinging for the users status.
    with {:ok, %SlackChex{} = slack_chex} <- Chexers.create_slack_chex(slack_chex_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", slack_chex_path(conn, :show, slack_chex))
      |> render("show.json", slack_chex: slack_chex)
    end
  end

  def show(conn, %{"id" => id}) do
    slack_chex = Chexers.get_slack_chex!(id)
    render(conn, "show.json", slack_chex: slack_chex)
  end

  def update(conn, %{"id" => id, "slack_chex" => slack_chex_params}) do
    slack_chex = Chexers.get_slack_chex!(id)

    with {:ok, %SlackChex{} = slack_chex} <- Chexers.update_slack_chex(slack_chex, slack_chex_params) do
      render(conn, "show.json", slack_chex: slack_chex)
    end
  end

  def delete(conn, %{"id" => id}) do
    slack_chex = Chexers.get_slack_chex!(id)
    with {:ok, %SlackChex{}} <- Chexers.delete_slack_chex(slack_chex) do
      send_resp(conn, :no_content, "")
    end
  end

end
