# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
use Mix.Config

# Mix messages in colors...
config :elixir, ansi_enabled: true

#     import_config "#{Mix.env()}.exs"
import_config "persist_fave_name.exs"
import_config "persist_valid_ranges.exs"
