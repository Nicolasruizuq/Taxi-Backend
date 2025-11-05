defmodule TaxisWeb.Gettext do
  @moduledoc """
  Proporciona soporte de internacionalización (i18n) con la librería Gettext.
  """

  use Gettext.Backend, otp_app: :taxis
end
