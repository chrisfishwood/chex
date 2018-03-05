defmodule ChexWeb.Router do
  use ChexWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ChexWeb do
    pipe_through :api
    resources "/slackchex", SlackChexController, except: [:new, :edit]
    resources "/slackrefresh", SlackRefreshController, only: [:create]
  end
end
