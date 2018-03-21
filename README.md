# Chex

## Todo

* Design schema
  * ChexAPI `/chex/chexer (slack/jira/gmail)`
  * `slak_chex` is the model to track a single slack check
  * `slack_chex_server` is the genserver taht is kicked off to track a single slack check
  * `chexers` is the service that creates new chexers
* change the user and profile creation to Ecto.multi
* create slack_refresh create view and return the complete object
* Request/Response for a single user's status
* GenServer polling for a single user
* Websockets for status on a given user
* Add authentication
  * Send a token with each request
* Add admin user support
  * Create new account
  * Upload Slack token for workspace


#Lessons Learned
* If you are using a custom (non-standard) association name (`slack_user_id` and not `user_id` you need to add a `foreign_key` to the association in the model.
* Use `Ecto.multi` instead of transactions
* All log messages are executed during runtime, only the the ones below 'level' aren't shown.
* `inspect` in loggers are expensive.

## Questions

* What data store to use?
  * Time series data.
     * Just use Aurora
      * Index on date, status and date + status
* Agent or GenServer and a DB?

## Domain

`mix phx.gen.schema Slack.User.Profile slack_user_profiles avatar_hash:string display_name:string display_name_normalized:string email:string first_name:string image_1024:string image_192:string image_24:string image_32:string image_48:string image_512:string image_72:string image_original:string last_name:string phone:string real_name:string real_name_normalized:string slype:string status_emoji:string status_text:string team:string title:string`
`mix phx.gen.schema Slack.User slack_users color:string deleted:boolean has_2fa:boolean slack_id:string is_admin:boolean is_app_user:boolean is_bot:boolean is_owner:boolean is_primary_owner:boolean is_restricted:boolean is_ultra_restricted:boolean name:string real_name:string team_id:string tz:string tz_label:string tz_offset:integer updated:integer`


```
"color"
"deleted"
"has_2fa"
"id"
"is_admin"
"is_app_user"
"is_bot"
"is_owner"
"is_primary_owner"
"is_restricted"
"is_ultra_restricted"
"name",
"profile"
"real_name"
"team_id"
"tz"
"tz_label"
"tz_offset"
"updated"
"profile" => %{
    "avatar_hash" => "1143444d6203",
    "display_name" => "Alex Aksenov",
    "display_name_normalized" => "Alex Aksenov",
    "email" => "aaksenov@weedmaps.com",
    "first_name" => "Aleksei",
    "image_1024" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_1024.jpg",
    "image_192" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_192.jpg",
    "image_24" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_24.jpg",
    "image_32" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_32.jpg",
    "image_48" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_48.jpg",
    "image_512" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_512.jpg",
    "image_72" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_72.jpg",
    "image_original" => "https://avatars.slack-edge.com/2017-10-19/258122663137_1143444d6203f126cade_original.jpg",
    "last_name" => "Aksenov",
    "phone" => "+79814425072",
    "real_name" => "Aleksei Aksenov",
    "real_name_normalized" => "Aleksei Aksenov",
    "skype" => "",
    "status_emoji" => ":face_with_monocle:",
    "status_text" => "",
    "team" => "T5PC7FYTC",
    "title" => ""
  },```
