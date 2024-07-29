defmodule P1serverWeb.Layouts do
  @moduledoc """
  This module holds different layouts used by your application.

  See the `layouts` directory for all templates available.
  The "root" layout is a skeleton rendered as part of the
  application router. The "app" layout is set as the default
  layout on both `use P1serverWeb, :controller` and
  `use P1serverWeb, :live_view`.
  """
  use P1serverWeb, :html

  embed_templates "layouts/*"
end
