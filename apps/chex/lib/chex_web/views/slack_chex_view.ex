defmodule ChexWeb.SlackChexView do
  use ChexWeb, :view
  alias ChexWeb.SlackChexView

  def render("index.json", %{slackchex: slackchex}) do
    %{data: render_many(slackchex, SlackChexView, "slack_chex.json")}
  end

  def render("show.json", %{slack_chex: slack_chex}) do
    %{data: render_one(slack_chex, SlackChexView, "slack_chex.json")}
  end

  def render("slack_chex.json", %{slack_chex: slack_chex}) do
    %{id: slack_chex.id,
      user: slack_chex.user}
  end
end
