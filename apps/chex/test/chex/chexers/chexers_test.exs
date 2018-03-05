defmodule Chex.ChexersTest do
  use Chex.DataCase

  alias Chex.Chexers

  describe "slackchex" do
    alias Chex.Chexers.SlackChex

    @valid_attrs %{user: "csteinmeyer"}
    @update_attrs %{user: "some updated user"}
    @invalid_attrs %{user: nil}

    def slack_chex_fixture(attrs \\ %{}) do
      {:ok, slack_chex} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chexers.create_slack_chex()

      slack_chex
    end

    test "list_slackchex/0 returns all slackchex" do
      slack_chex = slack_chex_fixture()
      assert Chexers.list_slackchex() == [slack_chex]
    end

    test "get_slack_chex!/1 returns the slack_chex with given id" do
      slack_chex = slack_chex_fixture()
      assert Chexers.get_slack_chex!(slack_chex.id) == slack_chex
    end

    test "create_slack_chex/1 with valid data creates a slack_chex" do
      assert {:ok, %SlackChex{} = slack_chex} = Chexers.create_slack_chex(@valid_attrs)
      assert slack_chex.user == "csteinmeyer"
    end

    test "create_slack_chex/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chexers.create_slack_chex(@invalid_attrs)
    end

    test "update_slack_chex/2 with valid data updates the slack_chex" do
      slack_chex = slack_chex_fixture()
      assert {:ok, slack_chex} = Chexers.update_slack_chex(slack_chex, @update_attrs)
      assert %SlackChex{} = slack_chex
      assert slack_chex.user == "some updated user"
    end

    test "update_slack_chex/2 with invalid data returns error changeset" do
      slack_chex = slack_chex_fixture()
      assert {:error, %Ecto.Changeset{}} = Chexers.update_slack_chex(slack_chex, @invalid_attrs)
      assert slack_chex == Chexers.get_slack_chex!(slack_chex.id)
    end

    test "delete_slack_chex/1 deletes the slack_chex" do
      slack_chex = slack_chex_fixture()
      assert {:ok, %SlackChex{}} = Chexers.delete_slack_chex(slack_chex)
      assert_raise Ecto.NoResultsError, fn -> Chexers.get_slack_chex!(slack_chex.id) end
    end

    test "change_slack_chex/1 returns a slack_chex changeset" do
      slack_chex = slack_chex_fixture()
      assert %Ecto.Changeset{} = Chexers.change_slack_chex(slack_chex)
    end
  end
end
