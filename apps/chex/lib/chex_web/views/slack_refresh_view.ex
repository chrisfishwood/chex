defmodule ChexWeb.SlackRefreshView do
  use ChexWeb, :view
  alias ChexWeb.SlackRefreshView
  
  require Logger

  def render("index.json", %{refreshes: refreshes}) do
    %{data: render_many(refreshes, SlackRefreshView, "refresh.json")}
  end

  def render("show.json", %{refreshes: refresh}) do
  
    Logger.debug(inspect(refresh))
    %{data: render_one(refresh, SlackRefreshView, "refresh.json")}
  end

  def render("refresh.json", %{refresh: refresh}) do
    %{id: refresh.id,
      name: refresh.name}
  end
  def render("refresh.json",refresh) do
    user = Map.get(refresh, :slack_refresh)

    %{id: user.id,
      name: user.real_name}
  end
end

