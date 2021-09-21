defmodule NervesLivebook.GithubReleaseTest do
  use ExUnit.Case
  alias NervesLivebook.GithubRelease

  test "version/1" do
    assert "0.1.1" == GithubRelease.version(example_response())
  end

  test "firmware_url/2" do
    response = example_response()

    assert {:ok,
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi0.fw"} ==
             GithubRelease.firmware_url(response, "nerves_livebook_rpi0.fw")

    assert {:ok,
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_bbb.fw"} ==
             GithubRelease.firmware_url(response, "nerves_livebook_bbb.fw")

    assert {:ok,
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi4.fw"} ==
             GithubRelease.firmware_url(response, "nerves_livebook_rpi4.fw")

    assert {:error, :not_found} ==
             NervesLivebook.GithubRelease.firmware_url(response, "nerves_livebook_host.fw")
  end

  defp example_response() do
    %{
      "assets" => [
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_bbb.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_235,
          "label" => "",
          "name" => "nerves_livebook_bbb.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjM1",
          "size" => 27_959_165,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708235"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_bbb.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_230,
          "label" => "",
          "name" => "nerves_livebook_bbb.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjMw",
          "size" => 28_268_273,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708230"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_npi_imx6ull.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_226,
          "label" => "",
          "name" => "nerves_livebook_npi_imx6ull.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI2",
          "size" => 26_792_424,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708226"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_npi_imx6ull.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_231,
          "label" => "",
          "name" => "nerves_livebook_npi_imx6ull.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjMx",
          "size" => 27_099_401,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708231"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_osd32mp1.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_221,
          "label" => "",
          "name" => "nerves_livebook_osd32mp1.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjIx",
          "size" => 26_788_914,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708221"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_osd32mp1.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_223,
          "label" => "",
          "name" => "nerves_livebook_osd32mp1.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjIz",
          "size" => 32_156_996,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708223"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_224,
          "label" => "",
          "name" => "nerves_livebook_rpi.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI0",
          "size" => 42_968_548,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708224"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_219,
          "label" => "",
          "name" => "nerves_livebook_rpi.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjE5",
          "size" => 43_276_929,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708219"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi0.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_227,
          "label" => "",
          "name" => "nerves_livebook_rpi0.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI3",
          "size" => 41_786_592,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708227"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi0.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_222,
          "label" => "",
          "name" => "nerves_livebook_rpi0.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjIy",
          "size" => 42_104_612,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708222"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi2.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_232,
          "label" => "",
          "name" => "nerves_livebook_rpi2.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjMy",
          "size" => 32_141_641,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708232"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi2.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_229,
          "label" => "",
          "name" => "nerves_livebook_rpi2.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI5",
          "size" => 32_477_213,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:44Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708229"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi3.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_228,
          "label" => "",
          "name" => "nerves_livebook_rpi3.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI4",
          "size" => 42_594_613,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708228"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi3.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_225,
          "label" => "",
          "name" => "nerves_livebook_rpi3.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjI1",
          "size" => 42_908_648,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708225"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi3a.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_233,
          "label" => "",
          "name" => "nerves_livebook_rpi3a.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjMz",
          "size" => 43_110_865,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708233"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi3a.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_220,
          "label" => "",
          "name" => "nerves_livebook_rpi3a.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjIw",
          "size" => 43_422_806,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708220"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi4.fw",
          "content_type" => "application/octet-stream",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_218,
          "label" => "",
          "name" => "nerves_livebook_rpi4.fw",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjE4",
          "size" => 49_039_323,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708218"
        },
        %{
          "browser_download_url" =>
            "https://github.com/livebook-dev/nerves_livebook/releases/download/v0.1.1/nerves_livebook_rpi4.zip",
          "content_type" => "application/zip",
          "created_at" => "2021-04-23T20:18:42Z",
          "download_count" => 0,
          "id" => 35_708_234,
          "label" => "",
          "name" => "nerves_livebook_rpi4.zip",
          "node_id" => "MDEyOlJlbGVhc2VBc3NldDM1NzA4MjM0",
          "size" => 49_407_934,
          "state" => "uploaded",
          "updated_at" => "2021-04-23T20:18:45Z",
          "uploader" => %{
            "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
            "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
            "followers_url" => "https://api.github.com/users/livebook-dev/followers",
            "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
            "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
            "gravatar_id" => "",
            "html_url" => "https://github.com/livebook-dev",
            "id" => 64669,
            "login" => "livebook-dev",
            "node_id" => "MDQ6VXNlcjY0NjY5",
            "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
            "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
            "repos_url" => "https://api.github.com/users/livebook-dev/repos",
            "site_admin" => false,
            "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
            "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
            "type" => "User",
            "url" => "https://api.github.com/users/livebook-dev"
          },
          "url" =>
            "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/assets/35708234"
        }
      ],
      "assets_url" =>
        "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/41924363/assets",
      "author" => %{
        "avatar_url" => "https://avatars.githubusercontent.com/u/64669?v=4",
        "events_url" => "https://api.github.com/users/livebook-dev/events{/privacy}",
        "followers_url" => "https://api.github.com/users/livebook-dev/followers",
        "following_url" => "https://api.github.com/users/livebook-dev/following{/other_user}",
        "gists_url" => "https://api.github.com/users/livebook-dev/gists{/gist_id}",
        "gravatar_id" => "",
        "html_url" => "https://github.com/livebook-dev",
        "id" => 64669,
        "login" => "livebook-dev",
        "node_id" => "MDQ6VXNlcjY0NjY5",
        "organizations_url" => "https://api.github.com/users/livebook-dev/orgs",
        "received_events_url" => "https://api.github.com/users/livebook-dev/received_events",
        "repos_url" => "https://api.github.com/users/livebook-dev/repos",
        "site_admin" => false,
        "starred_url" => "https://api.github.com/users/livebook-dev/starred{/owner}{/repo}",
        "subscriptions_url" => "https://api.github.com/users/livebook-dev/subscriptions",
        "type" => "User",
        "url" => "https://api.github.com/users/livebook-dev"
      },
      "body" => "Initial CI-built release",
      "created_at" => "2021-04-23T18:36:35Z",
      "draft" => false,
      "html_url" => "https://github.com/livebook-dev/nerves_livebook/releases/tag/v0.1.1",
      "id" => 41_924_363,
      "name" => "v0.1.1",
      "node_id" => "MDc6UmVsZWFzZTQxOTI0MzYz",
      "prerelease" => false,
      "published_at" => "2021-04-23T20:19:57Z",
      "tag_name" => "v0.1.1",
      "tarball_url" => "https://api.github.com/repos/livebook-dev/nerves_livebook/tarball/v0.1.1",
      "target_commitish" => "main",
      "upload_url" =>
        "https://uploads.github.com/repos/livebook-dev/nerves_livebook/releases/41924363/assets{?name,label}",
      "url" => "https://api.github.com/repos/livebook-dev/nerves_livebook/releases/41924363",
      "zipball_url" => "https://api.github.com/repos/livebook-dev/nerves_livebook/zipball/v0.1.1"
    }
  end
end
