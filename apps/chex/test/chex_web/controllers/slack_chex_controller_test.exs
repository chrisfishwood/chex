defmodule ChexWeb.SlackChexControllerTest do
  use ChexWeb.ConnCase

  alias Chex.Chexers
  alias Chex.Chexers.SlackChex

  @create_attrs %{user: "some user"}
  @update_attrs %{user: "some updated user"}
  @invalid_attrs %{user: nil}

  def fixture(:slack_chex) do
    {:ok, slack_chex} = Chexers.create_slack_chex(@create_attrs)
    slack_chex
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all slackchex", %{conn: conn} do
      conn = get conn, slack_chex_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create slack_chex" do
    test "renders slack_chex when data is valid", %{conn: conn} do
      conn = post conn, slack_chex_path(conn, :create), slack_chex: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, slack_chex_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "user" => "some user"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, slack_chex_path(conn, :create), slack_chex: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update slack_chex" do
    setup [:create_slack_chex]

    test "renders slack_chex when data is valid", %{conn: conn, slack_chex: %SlackChex{id: id} = slack_chex} do
      conn = put conn, slack_chex_path(conn, :update, slack_chex), slack_chex: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, slack_chex_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "user" => "some updated user"}
    end

    test "renders errors when data is invalid", %{conn: conn, slack_chex: slack_chex} do
      conn = put conn, slack_chex_path(conn, :update, slack_chex), slack_chex: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete slack_chex" do
    setup [:create_slack_chex]

    test "deletes chosen slack_chex", %{conn: conn, slack_chex: slack_chex} do
      conn = delete conn, slack_chex_path(conn, :delete, slack_chex)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, slack_chex_path(conn, :show, slack_chex)
      end
    end
  end

  defp create_slack_chex(_) do
    slack_chex = fixture(:slack_chex)
    {:ok, slack_chex: slack_chex}
  end
end
